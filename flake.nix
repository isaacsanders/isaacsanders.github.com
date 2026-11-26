{
  description = "isaacbfsanders.com: personal site built with Astro";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (
        system: pkgs:
        let
          inherit (pkgs) lib;
          nodejs = pkgs.nodejs_24;
        in
        {
          # The built static site (the contents of dist/).
          site = pkgs.buildNpmPackage {
            pname = "isaacbfsanders-com";
            version = "1.0.0";
            inherit nodejs;

            # Only the files the build reads, so README or workflow edits don't trigger a rebuild.
            src = lib.fileset.toSource {
              root = ./.;
              fileset = lib.fileset.unions [
                ./package.json
                ./package-lock.json
                ./astro.config.mjs
                ./src
                ./public
              ];
            };

            # Update after changing package-lock.json: set to lib.fakeHash, build,
            # and copy the hash from the error message.
            npmDepsHash = "sha256-UdmoKHUl7Vb6dflK/DLkUEjXLbda81Y9OImb7w/ADr8=";

            env.ASTRO_TELEMETRY_DISABLED = "1";

            installPhase = ''
              runHook preInstall
              cp -r dist $out
              runHook postInstall
            '';
          };

          default = self.packages.${system}.site;
        }
      );

      apps = forAllSystems (
        system: pkgs:
        let
          site = self.packages.${system}.site;
          nodejs = pkgs.nodejs_24;

          # `nix run`: serve the production build, as GitHub Pages would.
          serve = pkgs.writeShellApplication {
            name = "serve-site";
            runtimeInputs = [ pkgs.static-web-server ];
            text = ''
              port="''${PORT:-4321}"
              echo "Serving ${site} at http://localhost:$port"
              exec static-web-server --root ${site} --port "$port" \
                --page404 ${site}/404.html --directory-listing false "$@"
            '';
          };

          # `nix run .#dev`: Astro's live-reloading dev server on the working tree.
          dev = pkgs.writeShellApplication {
            name = "dev-site";
            runtimeInputs = [ nodejs ];
            text = ''
              if [ ! -f package.json ] || ! grep -q '"astro"' package.json; then
                echo "Run this from the root of the site repository." >&2
                exit 1
              fi
              if [ ! -d node_modules ] || [ package-lock.json -nt node_modules ]; then
                npm ci
              fi
              export ASTRO_TELEMETRY_DISABLED=1
              exec npm run dev -- "$@"
            '';
          };
        in
        {
          default = {
            type = "app";
            program = "${serve}/bin/serve-site";
            meta.description = "Serve the built site locally";
          };
          dev = {
            type = "app";
            program = "${dev}/bin/dev-site";
            meta.description = "Run the Astro dev server with live reload";
          };
        }
      );

      devShells = forAllSystems (
        system: pkgs: {
          default = pkgs.mkShell {
            packages = [ pkgs.nodejs_24 ];
            ASTRO_TELEMETRY_DISABLED = "1";
          };
        }
      );

      formatter = forAllSystems (system: pkgs: pkgs.nixfmt);
    };
}
