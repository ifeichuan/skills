---
name: Mobbin
url: https://mobbin.com
tier: 1
type: design
search-strategy: google-site
---

# Mobbin 适配器

## 搜索策略

**主策略：google-site**
- 搜索模板：`site:mobbin.com {query} UI design`
- 图片搜索：`site:mobbin.com {query}` + `&tbm=isch`

Mobbin 的核心价值是真实 app 的 UI 截图，Google 图片搜索效果很好。

**备用：站内搜索**
- URL：`https://mobbin.com/browse/web/screens?q={query}` 或 `https://mobbin.com/browse/ios/screens?q={query}`

## 结果页特征

- 搜索结果为真实 app 的屏幕截图网格
- 每个结果包含：app 截图、app 名称、screen 类型标签
- 点击进入详情可以看到同一 app 的更多相关 screen

## 截图技巧

- 等待时间：3 秒（图片懒加载）
- 视口建议：1440x900
- 结果页本身就是截图网格，直接截图结果页即可获得多个参考
- 进入详情页后截取单张 screen 可获得高清截图

## 已知问题

- 需要登录才能查看完整内容，未登录有浏览限制
- 如果需要登录，提示用户用 `agent-browser --auto-connect` 利用已登录的浏览器
- 搜索结果分 Web / iOS / Android 三个 tab
