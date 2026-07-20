# Vault Interview Log

## For agent

这是用户真实面经与牛客同步日志。**drill 优先贴近这些出现过的题**，尤其是带有真实追问链、项目背景或用户曾经答错/需要补课的知识点。这里记录的是题目与面试经历，不等于经过官方验证的答案；出题后应回源专题资料或官方文档核对，来源不足处标 `uncertain`。

**原始材料：** [Obsidian 面试题.md](file:///Users/feichuan/Documents/Obsidian/03-Areas/%E8%81%8C%E4%B8%9A%E7%94%9F%E6%B6%AF/%E9%9D%A2%E8%AF%95%E9%A2%98.md)

## 真实面试场次

### 小程序 / 网络链路面试

来源：[Obsidian 面试题.md](file:///Users/feichuan/Documents/Obsidian/03-Areas/%E8%81%8C%E4%B8%9A%E7%94%9F%E6%B6%AF/%E9%9D%A2%E8%AF%95%E9%A2%98.md)；原帖：[牛客 detail/82f6c6b453994a2fa6ed9827d316f936](https://www.nowcoder.com/feed/main/detail/82f6c6b453994a2fa6ed9827d316f936)

关键追问点：

- 小程序公告通知与微信订阅消息推送链路
- GET/POST 语义、网络传输区别、幂等性与默认缓存
- URL 长度限制由谁施加
- 简单请求、复杂请求、自定义请求头与 OPTIONS 预检
- URI 的概念与请求返回 URI 的误区
- 内存缓存、磁盘缓存、强缓存、协商缓存之间的关系
- setTimeout 时间不准确、渲染帧率与 requestAnimationFrame
- Promise、async/await、回调地狱与链式调用
- 数组相加的类型转换、解构赋值
- 用 var 伪实现 const
- 手写 Promise.all

### 小鹏前端一面

来源：[Obsidian 面试题.md](file:///Users/feichuan/Documents/Obsidian/03-Areas/%E8%81%8C%E4%B8%9A%E7%94%9F%E6%B6%AF/%E9%9D%A2%E8%AF%95%E9%A2%98.md)；原帖链接在原笔记中仅标为牛客首页，具体帖子不可由当前材料证明。

关键追问点：

- 浏览器渲染、reflow/repaint
- CSS 选择器优先级、BFC、DOCTYPE、盒模型
- 原型与原型链、事件传播
- 防抖与节流及使用场景
- Promise 链式调用、async/await 本质
- HTTP 常见状态码、GET/POST、浏览器缓存
- Vue 双向绑定、组件通信、虚拟 DOM、路由模式
- 性能优化、模块化规范、CommonJS 与 ES Module
- TypeScript 与 JavaScript、interface 与 type
- 前端内存泄漏检测与调试工具

### 影石前端一面（已过）

来源：[Obsidian 面试题.md](file:///Users/feichuan/Documents/Obsidian/03-Areas/%E8%81%8C%E4%B8%9A%E7%94%9F%E6%B6%AF/%E9%9D%A2%E8%AF%95%E9%A2%98.md)；原帖链接在原笔记中仅标为牛客首页，具体帖子不可由当前材料证明。

关键追问点：

- HTML 遇到 script、async 与 defer 执行时机
- HTTP 缓存、跨域表现、同源判断、OPTIONS 预检
- ES6 新 API、箭头函数与普通函数
- 事件循环、利用事件循环优化大量计算
- requestAnimationFrame 在浏览器调度中的位置
- React Hooks、自定义 Hook、Zustand 与 Redux
- setState 为什么不能立即读到新值
- URL 输入后白屏过久的定位与优化
- 分页竞态：第二页响应晚于第三页时如何保证展示最新请求

### 字节前端一面（75 分钟）

来源：[Obsidian 面试题.md](file:///Users/feichuan/Documents/Obsidian/03-Areas/%E8%81%8C%E4%B8%9A%E7%94%9F%E6%B6%AF/%E9%9D%A2%E8%AF%95%E9%A2%98.md)；原帖链接在原笔记中仅标为牛客首页，具体帖子不可由当前材料证明。

关键追问点：

- 自我介绍、项目与基础架构、项目深挖
- 性能指标、阶段分析、优化验证
- JSBridge 与客户端底层通信
- TypeScript `keyof`、`typeof`、泛型、装饰器及工程价值
- JS 数据类型与多种数组判断方法
- 移动端视觉还原、图片模糊、DPR
- Canvas、动画选型、JS 动画卡顿、重绘与重排
- React Hooks、React 相对直接使用 JS 的提升、React 18 变化
- SSR/RSC/CSR、水合失败
- HTTP 0.9/1.0/1.1/2/3、队头阻塞、TCP/UDP、缓存
- CSRF/XSS、对称/非对称加密
- 手写 `Array.prototype.flat` 与 `Promise.all`

### Fiber 复盘

来源：[Obsidian 面试题.md](file:///Users/feichuan/Documents/Obsidian/03-Areas/%E8%81%8C%E4%B8%9A%E7%94%9F%E6%B6%AF/%E9%9D%A2%E8%AF%95%E9%A2%98.md)。

关键追问点：

- React 16 以前同步、不可中断更新导致卡顿
- Fiber 将更新拆成可中断、可恢复的工作单元
- Render/Reconciliation 阶段可暂停、重做、丢弃
- Commit 阶段同步执行并应用副作用
- 高优先级用户输入、滚动、动画与任务让渡

### 牛客同步日志中的 Agent / AI 前端面经

来源：[Obsidian 面试题.md](file:///Users/feichuan/Documents/Obsidian/03-Areas/%E8%81%8C%E4%B8%9A%E7%94%9F%E6%B6%AF/%E9%9D%A2%E8%AF%95%E9%A2%98.md)。以下是同步日志中的高密度方向，简历/岗位材料仅极简保留，不作为用户经历事实。

- 快手 AI Agent 前端二面：[0eb3f9b46a4843c086f6d575d20b15b4](https://www.nowcoder.com/feed/main/detail/0eb3f9b46a4843c086f6d575d20b15b4)：Fiber、流式打字机、Markdown/LaTeX、性能指标、Webpack、微前端、状态管理、异常监控。
- 百度 AI Agent 前端实习生面经：[0ee219e39f254208bef730ca1e928fcc](https://www.nowcoder.com/feed/main/detail/0ee219e39f254208bef730ca1e928fcc)：Skill/Workflow、状态机、幂等、熔断、SSE 重连、断点续传、FCP/LCP、RAG 与 Multi-Agent。
- 百度 Agent 前端一面：[96cc5b7e2cb84f148eb48be23952f647](https://www.nowcoder.com/feed/main/detail/96cc5b7e2cb84f148eb48be23952f647)：SSE、Markdown 安全、CSRF、任务进度、自定义事件、全局状态、性能指标。
- 美团前端暑期一二面：[22c08e97f0e34becbae6d388131209f3](https://www.nowcoder.com/feed/main/detail/22c08e97f0e34becbae6d388131209f3)：SSE/WebSocket、AI 工作流、质量验收、人工介入、弱网与语音降噪。
- 前端+AI 面试题真题：[0be454f3836b44bab988cc3c1130b5e1](https://www.nowcoder.com/feed/main/detail/0be454f3836b44bab988cc3c1130b5e1)：SSE、RAG、Agent、Function Calling、MCP、Skills、多 Agent、ReAct。
- 快手/美团/阿里云/得物/MiniMax AI 前端面经：原始链接与逐题记录见上述 Obsidian 原文，集中考查流式 Markdown、ReadableStream、Promise 并发、自动滚动、虚拟列表、重试与安全。

## 高频知识点清单

以下是从本文件对应的真实场次与同步日志去重归并出的练习地图；它是题目出现频率/集中度清单，不是客观市场排名。

- **JavaScript 基础**：数据类型、类型转换、`==`/`===`、数组判断、作用域、闭包、原型链、`new`、箭头函数、事件传播、解构赋值、垃圾回收
- **异步与调度**：Promise 状态与链式调用、`async/await`、事件循环、宏任务/微任务、`setTimeout`、`requestAnimationFrame`、并发控制、重试与超时
- **浏览器加载与渲染**：URL 输入链路、HTML 解析、script/async/defer、DOM/CSSOM、Layout、Paint、Composite、reflow/repaint、白屏、内存/磁盘缓存
- **网络与安全**：GET/POST、幂等、HTTP 状态码、HTTP 版本、TCP/UDP、TLS、HTTPS、缓存、同源策略、CORS、OPTIONS、XSS、CSRF、加密
- **CSS 与布局**：选择器优先级、BFC、盒模型、Flex、DPR、两栏/三栏布局、动画与性能
- **Vue**：双向绑定、响应式、Vue 2/3、`v-if`/`v-show`、computed/watch、组件通信、路由、虚拟 DOM、`ref`/`reactive`
- **React**：Hooks、自定义 Hook、`setState`、Fiber、Render/Commit、React 18、Context、Zustand/Redux、SSR/RSC/CSR、水合
- **工程化与 TypeScript**：Webpack/Vite、模块化、构建优化、`keyof`/`typeof`/泛型/装饰器、`interface`/`type`、异常监控
- **性能与交互**：指标采集、首屏、LCP/FCP、长任务、动画卡顿、虚拟列表、流式打字机、自动滚动、弱网和断线恢复
- **AI 前端**：SSE/WebSocket、ReadableStream、Markdown/LaTeX 安全渲染、Agent/Workflow/Skill、RAG、Function Calling、MCP、Memory、Multi-Agent
- **行为与项目**：自我介绍、项目背景/职责/难点/结果、为什么前端、AI 使用方式、技术选型与真实取舍

## 可出题题干

以下题干均可直接作为一轮 drill 的问题；优先结合对应场次追问，不要一次性连发。

1. GET 和 POST 在语义、缓存和幂等性上有什么区别？
2. GET 请求的 URL 长度限制到底由谁决定？
3. 什么是简单请求，什么是 CORS 预检请求？
4. 自定义请求头为什么可能触发 OPTIONS？
5. URI、URL、URN 有什么关系？
6. 强缓存与协商缓存分别由哪些响应头控制？
7. 内存缓存和磁盘缓存如何与强缓存/协商缓存配合？
8. 为什么 `setTimeout(fn, 16)` 不能保证每 16ms 执行？
9. `requestAnimationFrame` 为什么更适合做动画？
10. Promise 如何实现链式调用？
11. `async/await` 和 Promise 的关系是什么？
12. 两个数组相加时 JavaScript 为什么会发生字符串拼接？
13. 解构赋值在 JavaScript 中是如何工作的？
14. 如何用 `var` 伪实现一个 `const`？
15. 如何手写 `Promise.all`，需要处理哪些边界？
16. 浏览器从输入 URL 到页面可见经历了哪些阶段？
17. 遇到 script、async、defer 时 HTML 解析和脚本执行如何交错？
18. 什么是 reflow 和 repaint，它们分别发生在渲染哪一阶段？
19. 如何定位首屏白屏时间过长的根因？
20. CSS 选择器优先级如何计算？
21. 什么是 BFC，如何触发，能解决哪些布局问题？
22. content-box 和 border-box 的区别是什么？
23. 原型和原型链分别解决什么问题？
24. 箭头函数和普通函数在 this、arguments、构造能力上有什么区别？
25. JavaScript 事件传播的捕获、目标和冒泡阶段如何运行？
26. 防抖和节流分别适合哪些真实场景？
27. JavaScript 事件循环中宏任务、微任务和渲染机会如何安排？
28. 大量计算导致页面卡顿时，如何利用事件循环让出主线程？
29. Vue 双向绑定的原理是什么？
30. Vue 2 和 Vue 3 的响应式实现有什么区别？
31. `v-if` 和 `v-show` 应如何按场景选择？
32. computed 和 watch 的职责边界是什么？
33. Vue 组件之间有哪些通信方式，分别适用于什么关系？
34. 虚拟 DOM 解决了什么问题，又没有解决什么问题？
35. React Hooks 为什么比类组件更适合组合逻辑？
36. 自定义 Hook 和普通工具函数的边界是什么？
37. React 的 `setState` 为什么不能立即读到更新后的值？
38. React Fiber 解决了什么问题，Render 和 Commit 如何分工？
39. React 18 相比之前的版本改变了什么？
40. SSR、RSC、CSR 的边界和取舍是什么？
41. 水合失败会发生什么，如何定位？
42. Zustand 为什么比 Redux 轻量，代价是什么？
43. CommonJS 和 ES Module 在加载与导出上有什么区别？
44. Webpack 和 Vite 的开发/生产构建模型有什么区别？
45. TypeScript 的 `keyof`、`typeof` 和泛型分别解决什么问题？
46. `interface` 和 `type` 如何选择？
47. 如何设计前端异常捕获与白屏监控？
48. HTTP/1.1、HTTP/2、HTTP/3 如何解决或暴露队头阻塞？
49. TCP 和 UDP 如何按可靠性、顺序和实时性选型？
50. HTTPS 如何通过证书和加密防止中间人攻击？
51. XSS 和 CSRF 的攻击面与防御手段有什么区别？
52. AI 流式输出为什么常用 SSE 而不是 WebSocket？
53. SSE 断线重连、心跳和断点续传如何设计？
54. Fetch 的 ReadableStream 如何跨 chunk 解析流式文本？
55. 流式 Markdown 或 LaTeX 标签被截断时如何避免渲染闪烁？
56. AI 聊天长列表如何同时保证流式更新和滚动性能？
57. Agent、RAG、Function Calling、MCP、Skill 的职责如何区分？
58. Workflow 与 Agent 的差异是什么，什么时候用固定流程？
59. 如何设计 AI 任务状态机的幂等、重试、熔断和取消？
60. 项目性能优化如何从指标、定位、方案和验证四步回答？

