run:
	jekyll --server --auto
new:
	vim _posts/`date "+%Y-%m-%d"-`$(post).md
