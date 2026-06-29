/**
 * Mock data source for the long image-text list.
 *
 * Lynx's `<list>` is a high-performance recycling container, so generating
 * data incrementally (page by page) keeps memory low while letting the list
 * grow arbitrarily large via `bindscrolltolower` load-more.
 */

export interface ListItem {
  /** Unique id, also used as `item-key`/`key` on `<list-item>`. */
  id: number
  /** Image URL. Uses picsum.photos so it works cross-platform without bundling. */
  image: string
  /** Main title text. */
  title: string
  /** Secondary description text. */
  subtitle: string
}

const TITLES = [
  '极光之夜',
  '山海之间',
  '城市霓虹',
  '林间晨雾',
  '沙漠星空',
  '海岸黄昏',
  '雪国列车',
  '古镇烟火',
  '云端漫步',
  '溪谷探幽',
]

const SUBTITLES = [
  '记录每一段值得回味的旅程',
  '用脚步丈量世界的宽度',
  '在喧嚣中寻找内心的宁静',
  '光影流转，时光静好',
  '远方有诗，也有风景',
  '每一次出发都是新的开始',
  '把生活过成想要的样子',
  '在旅途中遇见更好的自己',
]

/** Build one page of `pageSize` items starting from `offset`. */
export function fetchPage(offset: number, pageSize: number): ListItem[] {
  return Array.from({ length: pageSize }, (_, i) => {
    const id = offset + i
    const seed = id + 1
    return {
      id,
      // picsum.photos returns a stable image per seed, 600x400 keeps payload small.
      image: `https://picsum.photos/seed/${seed}/600/400`,
      title: `${TITLES[id % TITLES.length]} #${id + 1}`,
      subtitle: SUBTITLES[id % SUBTITLES.length],
    }
  })
}
