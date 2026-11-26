import { getCollection } from 'astro:content';
import { archivePath } from './paths';

const newestFirst = (a: { data: { date: Date } }, b: { data: { date: Date } }) =>
  b.data.date.valueOf() - a.data.date.valueOf();

export async function getPosts() {
  const posts = await getCollection('posts', ({ data }) => import.meta.env.DEV || !data.draft);
  return posts.sort(newestFirst).map((post) => ({
    entry: post,
    href: `/blog/${post.id}/`,
    title: post.data.title,
    date: post.data.date,
  }));
}

export async function getArchive() {
  const posts = await getCollection('archive');
  return posts.sort(newestFirst).map((post) => ({
    entry: post,
    href: `/archive/${archivePath(post.id)}/`,
    title: post.data.title,
    date: post.data.date,
  }));
}
