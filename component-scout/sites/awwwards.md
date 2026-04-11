---
name: Awwwards
url: https://www.awwwards.com
tier: 1
type: design
search-strategy: google-site
---

# Awwwards 适配器

## 搜索策略

**主策略：google-site**
- 搜索模板：`site:awwwards.com {query} component design`
- 图片搜索：`site:awwwards.com {query} UI` + `&tbm=isch`

**备用：站内搜索**
- URL：`https://www.awwwards.com/websites/?q={query}`
- 也支持按 tag 浏览：`https://www.awwwards.com/websites/{tag}/`

## 结果页特征

- 搜索结果为获奖/提名网站列表
- 每个结果包含：网站截图、名称、评分、标签
- 详情页有完整的桌面/移动端截图

## 截图技巧

- 等待时间：3 秒
- 视口建议：1440x900
- 弹窗处理：可能有 cookie 同意弹窗，用 `agent-browser snapshot -i` 找到关闭按钮
- 详情页向下滚动可以看到更多截图和评审信息

## 已知问题

- 和 Godly 类似，更偏向整站设计灵感，组件级别搜索精度有限
- 部分内容需要会员才能查看高清截图
- 网站加载速度较慢，建议等待时间设长一些
