import { useState } from '@lynx-js/react'

import './App.css'
import { fetchAll, type ListItem } from './lib/listData.js'

export function App() {
  // All items are loaded up front — no pagination.
  const [items] = useState<ListItem[]>(() => fetchAll())

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
                <text
                  className='Card__title'
                  text-maxline='1'
                >
                  {item.title}
                </text>
                <text
                  className='Card__subtitle'
                  text-maxline='2'
                >
                  {item.subtitle}
                </text>
              </view>
              <text className='Card__index'>{item.id + 1}</text>
            </view>
          </list-item>
        ))}
      </list>
    </view>
  )
}
