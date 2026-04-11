---
name: UIverse
url: https://uiverse.io
tier: 1
type: design
search-strategy: site-search
---

# UIverse 适配器

## 搜索策略

**主策略：site-search**（UIverse 的站内搜索质量好，且结果直接带 live preview）
- URL：`https://uiverse.io/elements?s={query}`
- 也可按类别浏览：`https://uiverse.io/buttons`、`https://uiverse.io/inputs` 等

**备用：google-site**
- 搜索模板：`site:uiverse.io {query} CSS`

## 结果页特征

- 搜索结果为卡片网格，每张卡片就是一个 **live CSS/HTML 组件预览**
- 每个结果包含：组件实时渲染、作者、点赞数
- 点击进入详情有完整的 HTML/CSS 代码

## 截图技巧

- 等待时间：2 秒（组件渲染）
- 视口建议：1440x900
- **关键**：结果页的每张卡片本身就是活的组件 demo，截图结果页即可获得大量视觉参考
- 进入详情页可以截取单个组件的大图
- 支持暗色模式切换

## 已知问题

- 内容偏向独立的 CSS 组件/特效，不是完整的设计系统组件
- 非常适合按钮、输入框、卡片、加载器等小型 UI 元素
- 无需登录，完全开源免费
