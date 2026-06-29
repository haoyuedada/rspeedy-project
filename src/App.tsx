import { useCallback, useState } from '@lynx-js/react'

import './App.css'
import { fetchPage, type ListItem } from './lib/listData.js'

const PAGE_SIZE = 12
// How many items from the bottom trigger the next load.
const LOWER_THRESHOLD = 3
// Hard cap so the demo doesn't grow forever.
const MAX_ITEMS = 120

export function App() {
  const [items, setItems] = useState<ListItem[]>(() => fetchPage(0, PAGE_SIZE))
  const [loading, setLoading] = useState(false)
  const [hasMore, setHasMore] = useState(true)

  const loadMore = useCallback(() => {
    'background only'
    if (loading || !hasMore) return

    setLoading(true)
    // Simulate a network request. setTimeout only exists on the background
    // thread in Lynx, which is why this callback is 'background only'.
    setTimeout(() => {
      setItems(prev => {
        const next = fetchPage(prev.length, PAGE_SIZE)
        const merged = prev.concat(next)
        if (merged.length >= MAX_ITEMS) {
          setHasMore(false)
        }
        return merged
      })
      setLoading(false)
    }, 800)
  }, [loading, hasMore])

  return (
    <view className='App'>
      <view className='Header'>
        <text className='Header__title'>图文长列表</text>
        <text className='Header__subtitle'>
          共 {items.length} 条 · Lynx {'<list>'} 高性能列表
        </text>
      </view>

      <list
        className='List'
        list-type='single'
        span-count={1}
        scroll-orientation='vertical'
        lower-threshold-item-count={LOWER_THRESHOLD}
        bindscrolltolower={loadMore}
      >
        {items.map(item => (
          <list-item
            key={`item-${item.id}`}
            item-key={`item-${item.id}`}
            estimated-main-axis-size-px={120}
          >
            <view className='Card'>
              <image
                className='Card__image'
                src={item.image}
                mode='aspectFill'
              />
              <view className='Card__body'>
                <text className='Card__title'>{item.title}</text>
                <text className='Card__subtitle'>{item.subtitle}</text>
              </view>
              <text className='Card__index'>{item.id + 1}</text>
            </view>
          </list-item>
        ))}

        {/* Footer status item. full-span so it occupies the whole row. */}
        <list-item
          key='list-footer'
          item-key='list-footer'
          full-span={true}
          recyclable={false}
        >
          <view className='Footer'>
            {loading
              ? <text className='Footer__text'>加载中…</text>
              : hasMore
                ? <text className='Footer__text'>上拉加载更多</text>
                : <text className='Footer__text'>— 没有更多了 —</text>}
          </view>
        </list-item>
      </list>
    </view>
  )
}
