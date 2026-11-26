/** "2011-06-10-introductions" -> "2011/06/10/introductions" */
export function archivePath(id: string): string {
  const [, y, m, d, slug] = id.match(/^(\d{4})-(\d{2})-(\d{2})-(.+)$/) ?? [];
  return slug ? `${y}/${m}/${d}/${slug}` : id;
}

export function formatDate(date: Date, style: 'long' | 'short' = 'long'): string {
  return date.toLocaleDateString('en-US', { year: 'numeric', month: style, day: 'numeric', timeZone: 'UTC' });
}

export function isoDate(date: Date): string {
  return date.toISOString().slice(0, 10);
}
