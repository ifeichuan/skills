---
name: design-analyze
description: 分析一个设计截图/URL，拆解它为什么好、有哪些值得学习的特点，输出结构化笔记存入 Obsidian。Use when the user shares a design screenshot, pastes a design URL, says "分析这个设计", "为什么这个设计好", "拆解一下", "design analysis", or when they bookmark/save a design and want to understand what makes it work.
user-invocable: true
argument-hint: "[screenshot path or URL]"
---

# Design Analyze — 设计拆解

收到设计截图或 URL 时，从视觉设计角度做结构化拆解，说明这个设计好在哪、为什么好、哪些手法可以复用。

## 输入

以下任一：
- 截图文件路径（用 Read 工具查看图片）
- 网页 URL（用 agent-browser 截图后分析）
- 用户直接贴的图片

## URL 取证流程

分析网页 URL 时，不能只看首屏静态截图。先做最小但足够的取证，避免漏掉滚动、hover、转场、加载、滤镜等关键设计。

### 1. 页面内容

- 用 `fetch_content` 抓页面文本、标题、导航、图片 alt、关键 CTA。
- 如果页面来自文章/Demo，顺手抓原文或教程页；例如 Codrops Demo 要抓对应 article。
- 记录原始 URL、截图路径、文章/源码链接。所有结论都要能回指这些材料；无法验证的标 `uncertain`。

### 2. 浏览器截图

用 `agent-browser` 至少保存这些状态：

1. **首屏初始态**：加载完成后截图。
2. **遮挡清理态**：关闭 cookie/banner/modal 后再截图；如果关不掉，明确说明遮挡影响。
3. **滚动态**：至少 25%、50%、75% 或连续 `scroll` 2-3 次截图，观察 reveal、parallax、sticky、scrub、像素化/模糊变化。
4. **hover/focus 态**：对导航、按钮、卡片、作品列表、图片等主要可交互元素 hover 后截图。
5. **转场态**：多页/导航型网站至少点击 1-2 个内部链接，观察 page transition；必要时连续截图而不是只截最终页。
6. **移动态**：视觉强依赖布局时，补一个窄屏截图；否则可跳过并说明未测移动端。

截图命名建议：`/tmp/design-analyze/<slug>/01-initial.png`、`02-clean.png`、`03-scroll-50.png`、`04-hover-nav.png`、`05-transition.png`。

### 3. 源码和资产线索

对 URL 页面额外查源码，至少搜索这些关键词：

```bash
curl -L -s <url> | rg -n "script|stylesheet|canvas|webgl|three|gsap|barba|lenis|scroll|hover|mousemove|pointer|transition|animation|clip-path|mask|filter|blur|pixel|shader|svg|feGaussianBlur|feDisplacementMap|data-component|data-interaction"
```

如果发现主 bundle，继续抓 bundle 并搜索：

```bash
curl -L -s <asset.js> | rg -n "gsap|ScrollTrigger|barba|lenis|canvas|webgl|shader|pixel|hover|mouseenter|mousemove|scroll|clipPath|mask|filter"
```

重点识别：

- **滚动系统**：`Lenis`、`ScrollTrigger`、`data-scroll`、`js-scroller`、`position: sticky`。
- **页面转场**：`Barba.js`、`Swup`、`ViewTransition`、`data-barba`、`pageTransition`、`router`。
- **鼠标交互**：`mouseenter`、`mousemove`、`pointermove`、`data-cursor`、磁吸/拖尾/hover reveal。
- **视觉滤镜**：`filter`、`clip-path`、`mask`、`canvas`、`WebGL`、`shader`、`feGaussianBlur`、`feColorMatrix`、`feDisplacementMap`。
- **像素化/模糊 reveal**：`pixel`、`image-rendering`、`canvas drawImage`、低分辨率占位图、`data-component="...pixelated..."`。

不要把源码关键词当成最终结论。它们是证据线索，必须和截图/交互观察互相印证。

### 4. 动效分析

如果页面有明显动效，必须单独增加「动效与交互」小节，说明：

- **触发方式**：加载、滚动、hover、点击、页面跳转、输入、视频播放。
- **变化对象**：图片、文字、遮罩、容器、背景、导航、光标、SVG path、WebGL plane。
- **变化属性**：`transform`、`opacity`、`clip-path`、`mask`、`filter`、`canvas/WebGL shader`、像素化/模糊强度。
- **时间感**：快/慢、stagger、scrub、惯性、ease-out/expo、是否跟随滚动。
- **设计语义**：动效是否在讲产品概念，而不只是装饰。例如“像素化逐步归零 = 从噪声到清晰”。
- **工程边界**：性能、可访问性、prefers-reduced-motion、是否锁交互、防重复点击、是否清理 inline styles。

### 5. 反查遗漏清单

输出前自检：

- 是否只看了首屏，没滚动？如果是，先补滚动截图。
- 是否只看静态截图，没 hover？如果页面有明显交互元素，先补 hover。
- 是否有 cookie/modal 遮挡？如果有，说明并尽量补无遮挡截图。
- 是否把动态效果误判成静态风格？检查源码关键词和多状态截图。
- 是否有文章/源码解释该 Demo？有则引用，不要只凭肉眼猜。
- 是否把未验证内容写成事实？未亲自验证的一律标 `uncertain`。

## 分析框架

对每个设计，从以下维度拆解：

### 1. 整体印象
一句话概括这个设计的核心气质和目标受众。

### 2. 布局与结构
- 网格系统（几栏、比例）
- 视觉层级（信息优先级如何通过布局传达）
- 留白节奏（疏密对比、呼吸感）

### 3. 色彩
- 主色 + 辅色 + 强调色（给出近似色值）
- 配色策略（互补、类似、单色、对比度）
- 色彩如何服务于信息层级

### 4. 字体与排版
- 字体选择（衬线/无衬线、几种字体）
- 字重层级（标题/正文/注释的对比）
- 行高、字间距的处理

### 5. 视觉焦点
- 用户第一眼看到什么、为什么
- 引导视线的手法（大小对比、色彩对比、空间引导）

### 6. 细节与质感
- 圆角、阴影、边框的运用
- 图标/插画风格
- 材质处理：噪声、像素化、模糊、滤镜、蒙版、WebGL、SVG
- 微交互线索

### 7. 动效与交互
- 触发方式：加载、滚动、hover、点击、转场
- 状态变化：从什么状态到什么状态，是否连续、是否 scrub
- 技术线索：CSS transition/animation、GSAP、Lenis、Barba、canvas、WebGL、SVG filter
- 设计语义：动效是否服务品牌/产品概念
- 风险：性能、遮挡、移动端、可访问性、过度动效

### 8. 风格标签
给出 3-5 个风格关键词，如：Minimal, Brutalist, Glassmorphism, Editorial, Playful, Corporate, Retro 等。

### 9. 可复用的手法
列出 2-3 个你可以直接偷到自己项目里的具体技巧。不说空话，说具体怎么做。优先写可落地的交互机制，例如：

- 滚动时图片从 `pixelated/blurred` 逐步过渡到清晰。
- hover 作品列表时只 reveal 对应图片，其余保持文字主导。
- 页面跳转时用 overlay / clip-path / SVG morph 遮住内容切换。
- 转场期间锁交互，结束后清理 GSAP inline styles。

## 输出格式

输出为 Markdown，结构如上。在终端直接展示给用户。

如果用户要求保存，存到 `~/Documents/Obsidian/Design-Library/` 目录，文件名格式：`YYYY-MM-DD-简短描述.md`，frontmatter 包含：

```yaml
---
tags: [design-analysis]
source: "[URL or 截图来源]"
style: [风格标签]
date: YYYY-MM-DD
---
```

## 启动：加载设计知识

使用本 skill 时，先检查宿主环境的 available skills 列表，寻找以下设计/UI 相关 skill：

- `frontend-design` — 前端设计原则
- `impeccable` — UI 品质标准
- `gsap-core` — 动效判断依据
- `design-explorer` — 设计参考站点
- 其他名称含 design / ui / animation / layout 的 skill

找到后用 Skill 工具读取其内容，将其中的设计原则、品质标准、动效规范作为分析时的判断依据。这样拆解不是凭空发挥，而是基于一套已校准的标准。

## 注意

- 不写废话，每个观点具体到像素级别的观察
- 不说"设计很好看"这种空话，说"标题用 72px/900weight 配 16px 正文，7:1 的大小对比制造冲击力"
- 如果设计有明显缺陷也要指出，不是所有部分都值得学
- URL 分析默认要看动态状态；首屏截图只能证明首屏，不能证明滚动、hover、转场
- 看到像素块、模糊、遮罩、分层图片时，默认怀疑它可能是动态 reveal，不要急着判成静态风格
- 动效结论必须同时有两类证据：截图/交互观察 + 文本/源码/教程线索；缺一类就标 `uncertain`
