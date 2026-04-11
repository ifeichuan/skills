---
name: 网站名称
url: https://example.com
category: component-library | design-inspiration
search-strategy: google-site
---

# {网站名称} 适配器

## 搜索策略

描述在此网站搜索组件的具体方法。

**google-site 策略**：
- 搜索模板：`site:example.com {query} component design`
- 图片搜索：`site:example.com {query} UI` + `&tbm=isch`

**direct-url 策略**（组件库文档）：
- URL 模板：`https://example.com/components/{name}`
- 备用搜索：`https://example.com/search?q={query}`

**site-search 策略**：
- 搜索入口：首页顶部搜索图标
- 搜索框描述：点击搜索图标后出现输入框
- 提交方式：Enter 键

## 结果页特征

描述搜索结果页的结构，帮助 AI 识别有价值的内容区域。

- 结果布局：卡片网格 / 列表 / 瀑布流
- 每个结果包含：缩略图 / 标题 / 作者 / 标签
- 有价值的截图区域：结果卡片本身 / 点进详情页后的主图

## 截图技巧

- 等待时间：页面加载后等待 N 秒（图片懒加载）
- 需要滚动：是否需要向下滚动才能看到完整结果
- 弹窗处理：cookie 同意弹窗 / 登录弹窗的关闭方法
- 视口建议：推荐的浏览器视口大小

## 已知问题

- 列出该网站的特殊情况（如需要登录、有频率限制、某些页面结构不稳定等）

## 自定义网站额外字段

以下字段仅用于用户添加的自定义网站：

```yaml
added_by: user
added_at: YYYY-MM-DD
```
