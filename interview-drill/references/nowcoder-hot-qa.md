---
title: 牛客秋招清洗版前端高频题卡
sourceCount: 45
---

## For agent

这份 reference 是 `interview-drill` 的核心题卡库。
Agent 在 drill 模式下应优先按 frequency 降序选择题目，再结合难度、标签和易错点出题纠正。
题库答案不等同于官方规范；涉及版本或规范细节时应继续核验，并将无法核验的判断标为 `uncertain`。

- **题目数**：45
- **排序**：按 `frequency` 降序；同频题保持源文件顺序

# 牛客秋招清洗版前端高频题卡

## Q1. Vue 和 React 的核心区别是什么？

`frequency: 2744 | difficulty: 3 | tags: 前端、Vue、React、框架对比、八股`

**速记**

Vue 更偏模板和响应式依赖追踪，React 更强调函数式组件、状态驱动和显式渲染。

**要点**

- Vue 响应式依赖追踪
- React 状态驱动渲染
- 模板 vs JSX
- 生态和约束不同

**易错**

- 不要简单站队
- 不要说 React 没有响应式就低级

**完整答**

Vue 通过模板、响应式系统和编译优化降低开发心智，数据变化后依赖追踪能更精确地触发更新；React 更强调 UI=f(state)，用 JSX 表达组件，状态变化后重新执行组件函数，再通过 reconciliation 找出差异。Vue 上手和约束更强，React 灵活度和生态组合更高。回答时不要说谁更好，而要结合团队、项目复杂度、类型系统、生态和性能优化方式分析。

## Q2. HTTP 和 HTTPS 有什么区别？

`frequency: 2461 | difficulty: 2 | tags: 前端、网络、HTTP、八股`

**速记**

HTTPS 是在 HTTP 基础上加入 TLS，提供加密、身份认证和完整性保护。

**要点**

- TLS 加密
- 证书认证
- 完整性校验
- 端口不同

**易错**

- 不要只说 HTTPS 更安全
- 不要说 HTTPS 绝对防所有攻击

**完整答**

HTTP 明文传输，容易被窃听、篡改和伪造。HTTPS 通过 TLS 建立安全通道，使用证书验证服务器身份，用非对称加密协商密钥，再用对称加密传输数据，同时通过摘要/MAC 保证完整性。HTTPS 默认端口 443，HTTP 默认 80。回答时可以补充 TLS 握手成本可通过会话复用、HTTP/2 等方式降低。

## Q3. 浏览器缓存机制有哪些？

`frequency: 1716 | difficulty: 3 | tags: 前端、浏览器、HTTP缓存、八股`

**速记**

浏览器缓存分强缓存和协商缓存，强缓存看 Cache-Control/Expires，协商缓存看 ETag/Last-Modified。

**要点**

- 强缓存
- 协商缓存
- Cache-Control
- ETag
- 文件 hash

**易错**

- 不要把 no-cache 理解成不缓存
- 不要忽略 HTML 和静态资源策略不同

**完整答**

强缓存命中时浏览器不向服务器发请求，主要由 Cache-Control:max-age、s-maxage、no-cache、no-store 或 Expires 控制。强缓存过期后会走协商缓存，浏览器带 If-None-Match/If-Modified-Since，服务器根据 ETag/Last-Modified 判断资源是否变化，未变化返回 304。工程上静态资源常用文件 hash + 长缓存，HTML 使用 no-cache 以便及时更新入口。

## Q4. Promise 的状态和链式调用原理是什么？

`frequency: 1502 | difficulty: 2 | tags: 前端、JavaScript、Promise、异步、八股`

**速记**

Promise 有 pending、fulfilled、rejected 三种状态，状态确定后不可逆；then 会返回新的 Promise 实现链式调用。

**要点**

- 三种状态
- 状态不可逆
- then 返回新 Promise
- 回调进入微任务

**易错**

- 不要把 Promise 当成线程
- 不要漏掉错误冒泡

**完整答**

Promise 用来描述异步操作结果。它初始是 pending，成功变 fulfilled，失败变 rejected，状态一旦改变不能再变。then/catch/finally 的回调会进入微任务队列；then 返回一个新的 Promise，如果回调返回普通值，新 Promise fulfilled；如果返回 Promise，则跟随它的状态；抛错会进入 rejected。工程中要注意错误冒泡、Promise.all 并发和 async/await 的 try/catch。

## Q5. 前端面试中如何做自我介绍？

`frequency: 1168 | difficulty: 1 | tags: 前端、HR面、自我介绍`

**速记**

按背景、技术栈、项目亮点、岗位匹配四段讲，控制在 1 分钟左右。

**要点**

- 控制在 45-90 秒
- 突出岗位匹配
- 准备 1 个可深挖项目
- 不要只背简历

**易错**

- 不要把简历逐字念一遍
- 不要说一堆空泛形容词
- 不要暴露自己项目说不清楚

**完整答**

应届生自我介绍不要流水账。推荐先用一句话说明学校、专业和求职方向；再说核心技术栈，例如 JavaScript、Vue/React、工程化和浏览器基础；接着挑一个最能体现能力的项目，用业务背景、负责模块、技术难点、结果指标讲清楚；最后把经历和岗位要求连接起来。表达要稳定、自信，给面试官留下可深挖的入口。

## Q6. Vue2 和 Vue3 有哪些核心区别？

`frequency: 959 | difficulty: 2 | tags: 前端、Vue、八股`

**速记**

Vue3 使用 Proxy 响应式、Composition API、Fragments、更好 TS 支持和更强编译优化。

**要点**

- Proxy 响应式
- Composition API
- 更好 TS 支持
- 编译优化
- 新内置能力

**易错**

- 不要只说语法不同
- 不要把 Vue3 说成完全不兼容 Vue2

**完整答**

Vue2 响应式主要基于 Object.defineProperty，需要递归劫持已有属性，对新增属性和数组索引有边界；Vue3 基于 Proxy，能代理整个对象，支持 Map/Set 等结构。Vue3 引入 Composition API，让逻辑按功能组织而不是按选项分散；同时支持 Fragment、Teleport、Suspense，编译器有 patch flag、静态提升等优化，TypeScript 支持也更好。迁移时要注意生命周期命名和生态差异。

## Q7. Webpack 和 Vite 有什么区别？

`frequency: 887 | difficulty: 2 | tags: 前端、工程化、Webpack、Vite、八股`

**速记**

Webpack 以打包为中心，Vite 开发态基于原生 ESM 按需加载，冷启动和 HMR 更快。

**要点**

- Webpack bundle
- Vite 原生 ESM
- Vite 开发快
- 生产仍需构建
- 生态兼容取舍

**易错**

- 不要说 Vite 不打包
- 不要只比较速度

**完整答**

Webpack 会从入口构建依赖图，把模块打包成 bundle，生态成熟、配置能力强，但大项目开发启动和热更新可能较慢。Vite 开发环境利用浏览器原生 ESM，按需转换和加载模块，冷启动快，HMR 粒度更细；生产构建通常基于 Rollup。选择时要看项目生态、插件、兼容性和构建定制需求。

## Q8. 如何解决跨域问题？

`frequency: 808 | difficulty: 3 | tags: 前端、浏览器、跨域、CORS、场景题`

**速记**

生产环境优先用 CORS 或同源反向代理，特殊场景可用 JSONP、postMessage 等。

**要点**

- 同源策略
- CORS
- OPTIONS 预检
- 反向代理
- 凭证配置

**易错**

- 不要以为前端单方面能解决所有跨域
- 不要在带 Cookie 时用通配 Origin

**完整答**

跨域来自浏览器同源策略，协议、域名、端口任一不同都算跨域。最常见方案是服务端配置 CORS，返回 Access-Control-Allow-Origin、Methods、Headers 等，复杂请求会先发 OPTIONS 预检。开发环境常用 devServer 代理，生产可用 Nginx 反向代理保持同源。JSONP 只支持 GET 且有安全限制，postMessage 适合窗口间通信。带 Cookie 时还要配置 credentials 和具体 Origin。

## Q9. JavaScript 事件循环机制是什么？

`frequency: 787 | difficulty: 3 | tags: 前端、JavaScript、事件循环、浏览器、八股`

**速记**

同步代码执行完后，先清空微任务队列，再执行下一个宏任务，浏览器在合适时机渲染页面。

**要点**

- 同步栈
- 宏任务
- 微任务
- 微任务优先清空
- 浏览器渲染时机

**易错**

- 不要只背 setTimeout 和 Promise 顺序
- 不要忽略 async/await

**完整答**

JS 主线程先执行调用栈中的同步任务。遇到异步任务时，定时器、网络、事件等进入宏任务来源，Promise.then、queueMicrotask、MutationObserver 等进入微任务队列。每轮宏任务执行结束后，会清空所有微任务，然后浏览器可能进行渲染，再取下一轮宏任务。回答时要能说出 async/await 本质上也是 Promise，并警惕大量微任务阻塞渲染。

## Q10. 前端首屏性能优化怎么做？

`frequency: 748 | difficulty: 4 | tags: 前端、性能优化、首屏优化、场景题`

**速记**

先度量瓶颈，再从资源体积、网络加载、渲染阻塞、运行时长任务和缓存策略优化。

**要点**

- 先度量
- 资源压缩和拆包
- 关键资源优先
- 减少渲染阻塞
- 指标验证

**易错**

- 不要一上来堆方案不定位
- 不要只说懒加载
- 不要没有量化指标

**完整答**

首屏优化要先用 Lighthouse、Performance、Web Vitals 定位 LCP、FCP、TTFB、长任务等瓶颈。资源层面做代码分割、Tree Shaking、压缩、CDN、图片 WebP/AVIF、字体优化；加载层面使用缓存、预加载关键资源、懒加载非首屏资源；渲染层面减少阻塞 CSS/JS，SSR/SSG 可改善首屏；运行时减少大组件同步渲染、长列表虚拟化、避免重复请求。最后要用指标对比优化前后。

## Q11. 什么是闭包？闭包有什么应用和风险？

`frequency: 710 | difficulty: 2 | tags: 前端、JavaScript、闭包、八股`

**速记**

闭包是函数能访问其词法作用域中的变量，即使外层函数已经执行结束。

**要点**

- 词法作用域
- 外层变量被保留
- 可封装私有状态
- 可能造成内存占用

**易错**

- 不要把闭包说成内存泄漏本身
- 不要没有例子

**完整答**

闭包来自 JavaScript 的词法作用域。内部函数被外部引用时，它仍然能访问外层函数的变量。常见应用包括封装私有状态、函数柯里化、防抖节流、回调中保存上下文等。风险是如果闭包长期持有大对象或 DOM 引用，可能导致内存无法及时释放。回答时最好用一个计数器或防抖函数例子说明，而不是只背定义。

## Q12. JavaScript 垃圾回收机制是什么？

`frequency: 710 | difficulty: 3 | tags: 前端、JavaScript、垃圾回收、八股`

**速记**

主流思路是可达性分析，不再可达的对象会被回收，现代引擎通常分代回收。

**要点**

- 可达性分析
- 新生代/老生代
- 标记清除
- 常见内存泄漏
- 主动解除引用

**易错**

- 不要说手动 free
- 不要把闭包等同于泄漏

**完整答**

JavaScript 垃圾回收会自动管理内存。核心判断是对象是否还能从根对象访问到，不能访问到就可回收。V8 等引擎会按对象生命周期分新生代和老生代，新对象频繁创建销毁，适合复制回收；存活久的对象进入老生代，使用标记清除、标记整理等策略。常见内存泄漏来自全局变量、未清理定时器/事件监听、闭包长期持有引用和 DOM 引用未释放。

## Q13. 原型和原型链是什么？

`frequency: 683 | difficulty: 2 | tags: 前端、JavaScript、原型链、八股`

**速记**

对象通过原型链查找属性，实例的隐式原型指向构造函数的 prototype。

**要点**

- 属性查找链路
- prototype 和隐式原型
- 方法共享
- 原型链终点是 null

**易错**

- 不要混淆 prototype 和 __proto__
- 不要只画图不解释属性查找

**完整答**

JavaScript 对象查找属性时，先查自身，没有就沿着 [[Prototype]] 继续向上找，直到 null，这条链就是原型链。构造函数有 prototype 属性，new 出来的实例会把隐式原型指向这个 prototype，从而共享方法。原型链实现了 JS 的继承和方法复用，但过深的链会影响可读性，也容易误改共享引用。

## Q14. 浏览器从输入 URL 到页面渲染经历了什么？

`frequency: 624 | difficulty: 3 | tags: 前端、浏览器、网络、渲染、八股`

**速记**

经历 URL 解析、缓存检查、DNS、TCP/TLS、HTTP 请求、资源解析、DOM/CSSOM、布局、绘制和合成。

**要点**

- 缓存/DNS/TCP/TLS
- HTTP 请求响应
- DOM/CSSOM
- Layout/Paint/Composite
- JS 阻塞

**易错**

- 不要只讲网络不讲渲染
- 不要忽略缓存和 HTTPS

**完整答**

完整链路可以按网络和渲染两段讲。网络阶段包括解析 URL、检查缓存、DNS 查询、建立 TCP 连接，HTTPS 还要 TLS 握手，然后发送 HTTP 请求并接收响应。渲染阶段浏览器解析 HTML 构建 DOM，解析 CSS 构建 CSSOM，合成渲染树，执行 layout 计算位置尺寸，paint 绘制，composite 合成上屏。遇到 JS 可能阻塞解析，async/defer 会改变脚本执行时机。

## Q15. Vue 响应式原理是什么？

`frequency: 564 | difficulty: 3 | tags: 前端、Vue、响应式原理、八股`

**速记**

核心是数据读取时收集依赖，数据修改时触发依赖更新；Vue2 用 defineProperty，Vue3 用 Proxy。

**要点**

- 依赖收集
- 派发更新
- effect/watch/computed
- Vue2 defineProperty
- Vue3 Proxy
- 异步批量更新

**易错**

- 不要只说双向绑定
- 不要漏掉依赖收集和调度

**完整答**

Vue 响应式本质是建立数据和副作用之间的依赖关系。渲染或 computed/watch 读取响应式数据时，会通过 track 收集当前 effect；数据变化时通过 trigger 找到相关 effect 并调度更新。Vue2 使用 Object.defineProperty 劫持属性 getter/setter；Vue3 使用 Proxy 拦截对象操作，覆盖面更完整。为了性能，更新不是立即同步渲染全部组件，而是进入调度队列批量刷新。

## Q16. 防抖和节流有什么区别？

`frequency: 556 | difficulty: 2 | tags: 前端、JavaScript、性能优化、场景题`

**速记**

防抖是停止触发一段时间后执行一次；节流是固定时间间隔最多执行一次。

**要点**

- 防抖合并最后一次
- 节流限制频率
- 输入搜索用防抖
- 滚动拖拽用节流

**易错**

- 不要把两者场景说反
- 不要只背代码不解释

**完整答**

防抖适合输入框搜索、窗口 resize 后重新计算等场景，核心是把多次触发合并成最后一次。节流适合滚动监听、拖拽、频繁上报等场景，核心是控制执行频率。实现上防抖每次触发都重置定时器，节流通过时间戳或定时器限制间隔。面试时要讲清场景选择，而不是只写代码。

## Q17. 深拷贝和浅拷贝有什么区别？如何实现深拷贝？

`frequency: 397 | difficulty: 3 | tags: 前端、JavaScript、深拷贝、八股`

**速记**

浅拷贝只复制第一层引用，深拷贝会递归复制嵌套对象，避免共享内部引用。

**要点**

- 浅拷贝共享嵌套引用
- 深拷贝递归复制
- WeakMap 处理循环引用
- JSON 方法有缺陷

**易错**

- 不要把 JSON 方法当万能方案
- 不要漏掉循环引用

**完整答**

浅拷贝如 Object.assign、展开运算符只复制对象第一层，嵌套对象仍共享引用。深拷贝需要递归处理对象、数组、Date、RegExp、Map、Set 等，还要用 WeakMap 解决循环引用。JSON.parse(JSON.stringify()) 简单但会丢失 undefined、函数、Symbol、Date 类型等。工程中优先使用成熟库或结构化克隆 structuredClone，手写时要说明边界。

## Q18. React Hooks 的规则和常见坑是什么？

`frequency: 367 | difficulty: 3 | tags: 前端、React、Hooks、八股`

**速记**

Hooks 只能在函数组件或自定义 Hook 顶层调用，要注意依赖数组、闭包旧值和副作用清理。

**要点**

- 顶层调用
- 依赖数组
- 副作用清理
- 闭包旧值
- 自定义 Hook 复用逻辑

**易错**

- 不要条件调用 Hook
- 不要故意省略依赖
- 不要把所有逻辑塞进 useEffect

**完整答**

React Hooks 让函数组件拥有状态和副作用。规则是只能在函数组件或自定义 Hook 中调用，且不能放在条件、循环、嵌套函数里，保证调用顺序稳定。useEffect 要正确填写依赖数组，并在订阅、定时器、请求等场景做清理。常见坑包括 stale closure、依赖缺失导致状态旧、依赖过多导致重复执行，以及把派生状态错误地放进 effect。

## Q19. CSS 盒模型是什么？标准盒模型和 border-box 有什么区别？

`frequency: 228 | difficulty: 1 | tags: 前端、CSS、盒模型、八股`

**速记**

盒模型由 content、padding、border、margin 组成；标准盒模型 width 只含 content，border-box 包含 content、padding、border。

**要点**

- content/padding/border/margin
- 标准模型 width 只含内容
- border-box 更适合工程布局
- margin 不算入 width

**易错**

- 不要漏掉 margin
- 不要把 border-box 说成包含 margin

**完整答**

CSS 盒模型描述元素占据空间的方式。标准盒模型中设置的 width/height 只代表内容区域，最终视觉宽度还要加 padding 和 border；border-box 中 width/height 已经包含 content、padding、border，更符合日常布局预期。项目里常用全局 box-sizing:border-box，能降低计算布局尺寸的心智负担。但 margin 不属于盒子自身尺寸，还要注意 margin 折叠和 BFC。

## Q20. React Fiber 解决了什么问题？

`frequency: 212 | difficulty: 4 | tags: 前端、React、Fiber、渲染原理、八股`

**速记**

Fiber 把渲染工作拆成可中断的小单元，让 React 能调度优先级，避免长时间阻塞主线程。

**要点**

- 可中断渲染
- 优先级调度
- 时间切片基础
- render 阶段可调度
- commit 阶段同步

**易错**

- 不要说 Fiber 就是多线程
- 不要忽略 commit 阶段

**完整答**

传统同步渲染一旦开始就难以中断，组件树很大时会阻塞主线程，影响输入和动画。Fiber 将虚拟 DOM 节点表示为 Fiber 节点，并把渲染过程拆成可暂停、恢复、丢弃的工作单元。它为优先级调度、并发渲染、时间切片等能力打基础。提交阶段仍需要同步把变更应用到 DOM，所以 Fiber 不是让所有工作都异步，而是让 render 阶段可调度。

## Q21. 重排和重绘有什么区别？如何减少？

`frequency: 201 | difficulty: 3 | tags: 前端、浏览器、性能优化、八股`

**速记**

重排会重新计算布局，重绘只更新外观；减少布局读写交错，动画优先用 transform/opacity。

**要点**

- 布局变化触发重排
- 外观变化触发重绘
- 批量 DOM 操作
- transform/opacity 动画

**易错**

- 不要说重绘一定很轻
- 不要滥用 will-change

**完整答**

重排也叫回流，元素尺寸、位置、DOM 结构、字体等几何信息变化会触发布局重新计算；重绘是颜色、背景等视觉变化，不影响布局。重排通常比重绘更重。优化方式包括批量修改 DOM、避免频繁读取 offsetWidth 后立即写样式、使用 class 合并样式变更、动画使用 transform/opacity、长列表虚拟化。必要时可用 will-change，但不能滥用。

## Q22. 虚拟 DOM 和 Diff 的作用是什么？

`frequency: 200 | difficulty: 3 | tags: 前端、Vue、React、虚拟DOM、八股`

**速记**

虚拟 DOM 用 JS 对象描述 UI，Diff 用来找出新旧树差异，减少直接操作 DOM 的复杂度。

**要点**

- 声明式 UI
- 新旧树 Diff
- 批量更新
- key 标识身份

**易错**

- 不要说虚拟 DOM 一定最快
- 不要用 index 当动态列表 key

**完整答**

虚拟 DOM 并不一定比手写 DOM 操作更快，它的价值在于用声明式方式描述 UI，并通过 Diff 和批量更新把状态变化转成 DOM 变更。Diff 通常基于同层比较、key 标识节点身份等启发式策略，将复杂度控制在可接受范围。key 的作用是帮助框架识别节点复用和移动，错误使用 index 可能导致状态错乱。

## Q23. XSS 和 CSRF 的区别以及防护方式是什么？

`frequency: 194 | difficulty: 3 | tags: 前端、浏览器安全、XSS、CSRF、八股`

**速记**

XSS 是注入脚本执行，CSRF 是借用户登录态伪造请求；前者重在转义和 CSP，后者重在 token、SameSite 和校验来源。

**要点**

- XSS 是脚本注入
- CSRF 是伪造请求
- 输出转义/CSP
- Token/SameSite

**易错**

- 不要混淆攻击目标
- 不要只说过滤输入

**完整答**

XSS 攻击把恶意脚本注入页面，可能窃取 token、篡改页面或发起请求，防护包括输入校验、输出转义、避免 v-html/innerHTML、CSP、HttpOnly Cookie。CSRF 利用用户已登录状态诱导浏览器向目标站点发请求，防护包括 CSRF Token、SameSite Cookie、校验 Origin/Referer、关键操作二次确认。两者核心区别是 XSS 让脚本在站内执行，CSRF 是跨站伪造用户请求。

## Q24. GET 和 POST 有什么区别？

`frequency: 160 | difficulty: 1 | tags: 前端、网络、HTTP、八股`

**速记**

GET 通常用于获取资源，参数常在 URL；POST 通常用于提交数据，请求体承载数据。

**要点**

- 语义差异
- GET 幂等获取
- POST 提交处理
- 安全依赖 HTTPS

**易错**

- 不要把参数位置当唯一差别
- 不要说 POST 天然安全

**完整答**

GET 和 POST 语义不同：GET 应该是安全、幂等的资源获取；POST 常用于提交、创建或触发处理。GET 参数通常在 URL 上，容易被缓存和记录，长度受环境限制；POST 数据在 body 中，更适合提交较大或结构化数据。安全性不能简单说 POST 更安全，因为 HTTP 下 body 也可能被抓包，真正安全要靠 HTTPS 和鉴权。

## Q25. 线上白屏应该如何排查？

`frequency: 160 | difficulty: 4 | tags: 前端、白屏排查、性能优化、场景题`

**速记**

先确认影响范围和报错，再从资源加载、JS 异常、路由、接口、兼容性和发布回滚排查。

**要点**

- 确认影响范围
- 资源加载
- JS 运行时异常
- 接口和路由
- 回滚止血

**易错**

- 不要直接猜代码问题
- 不要忽略发布/CDN/兼容性

**完整答**

白屏排查要先看监控和用户反馈，确认是全量、部分浏览器、部分地区还是某个版本。技术上检查 HTML 是否返回正常、JS/CSS 是否 404 或被 CDN 缓存污染、控制台是否有运行时异常、接口是否阻塞首屏、路由配置是否错误、兼容性 polyfill 是否缺失。再结合 sourcemap、错误监控、性能监控和发布记录定位。应急上先回滚或切流，之后补充灰度、健康检查和告警。

## Q26. 什么是 BFC？它能解决什么问题？

`frequency: 156 | difficulty: 2 | tags: 前端、CSS、BFC、布局、八股`

**速记**

BFC 是独立的块级格式化上下文，常用于清除浮动、防止 margin 折叠和隔离布局影响。

**要点**

- 独立布局区域
- 清除浮动
- 阻止 margin 折叠
- 隔离浮动影响

**易错**

- 不要只背定义
- 不要把 BFC 当成万能布局方案

**完整答**

BFC 可以理解为页面中的独立布局区域，内部元素的布局不会影响外部。常见触发方式包括 overflow 非 visible、display: flow-root、float、position:absolute/fixed、inline-block、flex/grid item 等。典型作用是清除浮动导致的父容器高度塌陷，阻止相邻 margin 折叠，以及实现两栏布局时让文本区域不被浮动元素覆盖。回答时最好说出触发方式和实际使用场景。

## Q27. computed 和 watch 有什么区别？

`frequency: 154 | difficulty: 2 | tags: 前端、Vue、computed、watch、八股`

**速记**

computed 用于有缓存的派生值，watch 用于监听变化后执行副作用。

**要点**

- computed 有缓存
- computed 适合派生值
- watch 适合副作用
- watch 可异步

**易错**

- 不要在 computed 中写副作用
- 不要把 watch 当万能联动工具

**完整答**

computed 适合从响应式数据计算出一个新值，依赖不变时会复用缓存，应该保持纯函数思路。watch 适合监听数据变化后执行副作用，比如异步请求、埋点、手动同步外部状态，可配置 immediate、deep、flush 等。能用 computed 表达的派生状态不要滥用 watch，否则逻辑容易分散。

## Q28. v-if 和 v-show 有什么区别？

`frequency: 142 | difficulty: 2 | tags: 前端、Vue、条件渲染、八股`

**速记**

v-if 是条件渲染，不满足时不创建 DOM；v-show 始终渲染 DOM，只切换 display。

**要点**

- v-if 控制创建销毁
- v-show 控制 display
- v-if 适合低频
- v-show 适合高频

**易错**

- 不要只说一个显示一个隐藏
- 不要把 v-show 当懒加载

**完整答**

v-if 会根据条件真正创建或销毁 DOM/组件，初始成本低，但频繁切换成本高；v-show 无论条件如何都会先渲染，只通过 CSS display 控制显示隐藏，初始成本高但切换成本低。低频切换、权限控制、首次不需要渲染用 v-if；高频切换、Tab、弹窗内容保留用 v-show。

## Q29. CSS 选择器优先级如何计算？

`frequency: 130 | difficulty: 1 | tags: 前端、CSS、选择器、八股`

**速记**

优先级大致按 !important、内联样式、ID、类/属性/伪类、标签/伪元素排序，后写同级覆盖先写。

**要点**

- 内联样式
- ID/类/标签权重
- !important 谨慎使用
- 同权重后声明覆盖

**易错**

- 不要滥用 !important
- 不要忽略样式作用域设计

**完整答**

CSS 优先级用于决定多条规则同时命中时谁生效。通常可以按权重理解：内联样式高于选择器；选择器中 ID 权重高于类、属性、伪类，后者又高于标签和伪元素；同权重时后声明覆盖先声明。!important 会提高优先级，但工程中应谨慎使用。实际项目更推荐通过合理的 CSS 结构、BEM、CSS Modules 或 scoped 样式降低优先级冲突。

## Q30. var、let、const 有什么区别？

`frequency: 120 | difficulty: 1 | tags: 前端、JavaScript、变量声明、八股`

**速记**

var 是函数作用域且有声明提升；let/const 是块级作用域，有暂时性死区，const 声明后不能重新赋值。

**要点**

- 函数作用域 vs 块级作用域
- 声明提升和暂时性死区
- const 不能重新绑定
- 默认 const

**易错**

- 不要说 const 对象完全不可变
- 不要漏掉暂时性死区

**完整答**

var 声明会提升到函数作用域顶部，允许重复声明，容易带来作用域污染。let 和 const 是块级作用域，在声明前访问会触发暂时性死区，不能重复声明。const 限制的是绑定不能重新赋值，不代表对象内部属性不可变。实际项目中默认用 const，需要重新赋值时用 let，避免使用 var。

## Q31. Vue 组件通信有哪些方式？

`frequency: 120 | difficulty: 2 | tags: 前端、Vue、组件通信、八股`

**速记**

常见有 props/emit、ref、provide/inject、状态管理、事件总线等，优先保持单向数据流。

**要点**

- props/emit
- ref/defineExpose
- provide/inject
- Pinia/Vuex
- 单向数据流

**易错**

- 不要所有通信都用全局状态
- 不要滥用 ref 强耦合

**完整答**

父子组件通信优先用 props 向下传数据、emit 向上通知事件；父组件命令式调用子组件可用 ref，Vue3 子组件需要 defineExpose；跨层级可用 provide/inject；复杂全局状态用 Pinia/Vuex；兄弟组件可提升状态到共同父组件或状态管理。回答时要强调不要滥用事件总线和 ref，核心是数据流清晰、职责明确。

## Q32. 为什么选择前端？

`frequency: 120 | difficulty: 2 | tags: 前端、HR面、职业动机`

**速记**

从兴趣、能力匹配和岗位价值回答，体现你理解前端不只是写页面。

**要点**

- 说清兴趣来源
- 体现对前端复杂度的理解
- 结合项目经历
- 表达长期学习意愿

**易错**

- 不要说前端简单
- 不要只说喜欢好看的页面
- 不要贬低其他岗位

**完整答**

比较好的回答是把前端描述成连接用户体验和工程实现的位置。可以说自己喜欢能直接感知用户反馈的工作，同时前端又要求扎实的 JS、浏览器、工程化和性能优化能力。再结合项目说明你做过交互、组件、性能或可视化，感受到前端对业务效率和用户体验的影响。最后强调你愿意持续补齐计算机基础和工程能力，而不是只会写页面。

## Q33. React 中 useMemo 和 useCallback 有什么区别？

`frequency: 120 | difficulty: 3 | tags: 前端、React、Hooks、性能优化、八股`

**速记**

useMemo 缓存计算结果，useCallback 缓存函数引用，本质都依赖依赖数组。

**要点**

- useMemo 缓存值
- useCallback 缓存函数
- 依赖数组
- 配合 React.memo

**易错**

- 不要到处乱用造成复杂度
- 不要漏依赖导致旧闭包

**完整答**

useMemo 用于避免昂贵计算在每次渲染时重复执行，返回的是计算结果；useCallback 用于稳定函数引用，常配合 React.memo 减少子组件不必要渲染，返回的是函数本身。它们都有维护成本，依赖数组写错会导致旧值或重复计算。不是所有函数和计算都要缓存，只有在计算昂贵或引用稳定确实影响渲染时才值得使用。

## Q34. 长列表渲染如何优化？

`frequency: 120 | difficulty: 4 | tags: 前端、性能优化、虚拟列表、场景题`

**速记**

核心是只渲染可视区域和缓冲区，用虚拟列表减少 DOM 数量。

**要点**

- 减少 DOM 数量
- 可视区域渲染
- buffer 缓冲
- 动态高度缓存
- 滚动节流

**易错**

- 不要只说分页
- 不要忽略动态高度和滚动体验

**完整答**

长列表卡顿的根因通常是 DOM 节点过多、布局和绘制成本高、滚动事件频繁。常见方案是虚拟列表：根据滚动位置计算可视区域，只渲染可见项和少量 buffer，用占位高度维持滚动条。固定高度实现简单，动态高度要缓存测量结果。还可以配合分页、懒加载、节流滚动监听、图片懒加载和组件 memo。

## Q35. HTML 语义化有什么作用？

`frequency: 110 | difficulty: 1 | tags: 前端、HTML、八股`

**速记**

语义化让页面结构更清晰，有利于 SEO、可访问性、维护和浏览器解析。

**要点**

- 标签表达内容含义
- 提升可访问性
- 利于 SEO
- 便于维护

**易错**

- 不要把语义化只说成 SEO
- 不要认为语义化会自动提升性能

**完整答**

HTML 语义化是用合适的标签表达内容含义，比如 header、nav、main、article、section、footer。它的价值不只是代码好看，还包括搜索引擎更容易理解页面结构，读屏器等辅助工具更容易访问，团队维护时结构更清楚，也有利于统一样式和组件拆分。回答时可以举例：列表用 ul/li，表单字段用 label 关联 input，正文用 article/section，而不是全部 div。

## Q36. 如何实现元素水平垂直居中？

`frequency: 100 | difficulty: 1 | tags: 前端、CSS、布局、八股`

**速记**

常用 Flex/Grid 居中，也可以用绝对定位加 transform。

**要点**

- Flex 居中
- Grid place-items
- absolute + transform
- 根据场景选择

**易错**

- 不要只背一种方案
- 不要忽略未知宽高场景

**完整答**

现代项目优先用 Flex：父元素 display:flex; justify-content:center; align-items:center。Grid 可以用 place-items:center。若需要兼容特定场景，可用绝对定位：left:50%; top:50%; transform:translate(-50%,-50%)。如果元素尺寸固定，也可以用 margin 或 calc。面试回答要说明不同方案的前提，比如是否知道元素尺寸、是否需要响应式。

## Q37. == 和 === 有什么区别？

`frequency: 90 | difficulty: 1 | tags: 前端、JavaScript、类型转换、八股`

**速记**

== 会进行隐式类型转换，=== 不会，工程中优先使用 ===。

**要点**

- == 有隐式转换
- === 类型和值都比较
- null 和 undefined 是特殊情况
- 工程优先 ===

**易错**

- 不要只说三个等号更严格
- 不要乱背转换规则但解释不清

**完整答**

== 比较前会按规则做类型转换，比如字符串和数字、布尔值和数字、对象转原始值等，结果可能反直觉；=== 要求类型和值都相等，不会做隐式转换，因此可读性和安全性更好。面试时可以补充 null == undefined 为 true，但它们和其他值比较通常为 false。工程中除非明确需要兼容 null/undefined，否则优先使用 ===。

## Q38. 前端登录鉴权和 Token 续期怎么设计？

`frequency: 90 | difficulty: 4 | tags: 前端、登录鉴权、Token、场景题`

**速记**

常用 access token + refresh token，短期访问令牌失效后静默刷新，并处理并发刷新和失败退出。

**要点**

- access/refresh token
- 401 拦截
- 并发刷新队列
- 安全存储取舍
- 失败退出

**易错**

- 不要每个请求都刷新 token
- 不要忽略并发 401
- 不要只考虑功能不考虑安全

**完整答**

前端鉴权通常登录后保存 access token，用于接口认证；refresh token 生命周期更长，用来换取新的 access token。access token 过期时拦截 401，发起刷新请求，刷新成功后重放原请求；多个请求同时 401 时要用队列或锁避免重复刷新。存储上要权衡 XSS 和 CSRF 风险，敏感场景可用 HttpOnly Cookie 配合 CSRF 防护。刷新失败要清理状态并跳转登录。

## Q39. 前端监控需要采集哪些指标？

`frequency: 90 | difficulty: 4 | tags: 前端、前端监控、场景题`

**速记**

需要采集错误、性能、资源、接口、用户行为和环境信息，并能关联版本和用户影响范围。

**要点**

- 错误监控
- 性能指标
- 资源/接口监控
- 上下文信息
- sourcemap 和告警

**易错**

- 不要收集敏感信息
- 不要只有日志没有告警

**完整答**

前端监控一般包括 JS 运行时错误、Promise 未捕获错误、资源加载失败、接口错误和耗时、白屏检测、Web Vitals、页面停留和关键行为。每条日志应带上版本、路由、浏览器、设备、用户标识、traceId 等上下文，方便和后端链路关联。生产上还要做采样、脱敏、 sourcemap 映射、告警和看板，而不是只 console.log。

## Q40. Flex 如何实现左侧自适应、右侧固定 100px 的布局？

`frequency: 80 | difficulty: 2 | tags: 前端、CSS、Flex、场景题、布局`

**速记**

父容器 display:flex，左侧 flex:1 并设置 min-width:0，右侧 flex:0 0 100px。

**要点**

- 右侧固定 flex-basis
- 左侧 flex:1
- min-width:0 防溢出
- Grid 也可实现

**易错**

- 不要忘记长文本撑破布局
- 不要只说 calc，缺少响应式思路

**完整答**

推荐用 Flex 表达布局约束：父容器 display:flex；右侧设置 flex:0 0 100px 保证固定宽度；左侧设置 flex:1 占剩余空间，并加 min-width:0 防止长文本把容器撑开。若需要更严格的列布局，也可以用 grid-template-columns:minmax(0,1fr) 100px。面试时补充文本溢出、响应式和间距处理，会比只写 calc 更工程化。

## Q41. TypeScript 的 type 和 interface 有什么区别？

`frequency: 80 | difficulty: 2 | tags: 前端、TypeScript、八股`

**速记**

interface 更适合描述对象结构且可声明合并，type 更灵活，可定义联合、交叉、条件等类型。

**要点**

- interface 描述对象
- interface 可声明合并
- type 更灵活
- 联合/交叉类型

**易错**

- 不要说 type 一定比 interface 好
- 不要忽略团队规范

**完整答**

interface 主要用于描述对象、类实现和公共 API，支持同名声明合并和 extends 扩展。type 可以给任意类型起别名，支持联合类型、交叉类型、条件类型、映射类型等，更适合复杂类型表达。工程上对象模型和对外接口常用 interface，复杂组合和工具类型常用 type。两者很多场景可互换，关键是团队规范一致。

## Q42. nextTick 的作用是什么？

`frequency: 80 | difficulty: 2 | tags: 前端、Vue、nextTick、八股`

**速记**

nextTick 用来在 DOM 更新完成后执行回调，解决状态已变但 DOM 还没刷新的问题。

**要点**

- DOM 异步批量更新
- 等待下一轮 DOM 刷新
- 适合读取最新 DOM
- 不是强制刷新

**易错**

- 不要把 nextTick 当 setTimeout
- 不要滥用 DOM 操作

**完整答**

Vue 修改响应式数据后不会立刻同步更新 DOM，而是把更新放进队列批量处理。nextTick 会在本轮数据变更导致的 DOM 更新完成后执行回调，常用于获取最新 DOM 尺寸、滚动到新增元素、操作组件内部真实节点等。它不是用来强制刷新数据的，也不应该滥用来掩盖状态设计问题。

## Q43. SSR、CSR 和 SSG 有什么区别？

`frequency: 70 | difficulty: 3 | tags: 前端、渲染模式、性能优化、八股`

**速记**

CSR 在浏览器渲染，SSR 在服务端按请求渲染，SSG 在构建时生成静态 HTML。

**要点**

- CSR 浏览器渲染
- SSR 服务端渲染
- SSG 构建时生成
- SEO/首屏/成本取舍

**易错**

- 不要认为 SSR 一定更快
- 不要忽略服务端压力

**完整答**

CSR 首屏依赖 JS 下载和执行，交互灵活但首屏和 SEO 可能较弱；SSR 每次请求在服务端生成 HTML，首屏和 SEO 更好，但服务端压力和同构复杂度更高；SSG 在构建时生成静态页面，访问速度快、稳定性好，适合内容更新不频繁的页面。实际选择要看 SEO、首屏、更新频率、个性化和运维成本。

## Q44. v-model 的原理是什么？

`frequency: 57 | difficulty: 2 | tags: 前端、Vue、v-model、八股`

**速记**

v-model 是属性绑定和事件更新的语法糖，组件上 Vue3 默认是 modelValue + update:modelValue。

**要点**

- 属性绑定
- 事件更新
- Vue2 value/input
- Vue3 modelValue/update:modelValue

**易错**

- 不要说 v-model 是真正双向随便改
- 不要忽略组件 v-model

**完整答**

原生表单上 v-model 通常等价于绑定 value/checked 并监听 input/change 事件更新数据。组件上 Vue2 默认是 value + input，Vue3 默认是 modelValue + update:modelValue，也支持多个 v-model。它没有破坏单向数据流，子组件仍然通过事件通知父组件更新状态。

## Q45. 箭头函数和普通函数有什么区别？

`frequency: 33 | difficulty: 2 | tags: 前端、JavaScript、this、八股`

**速记**

箭头函数没有自己的 this、arguments 和 prototype，不能作为构造函数，this 来自外层词法作用域。

**要点**

- 箭头函数 this 词法绑定
- 不能 new
- 没有 arguments
- 适合回调

**易错**

- 不要说箭头函数 this 指向自己
- 不要在对象方法里盲目用箭头函数

**完整答**

普通函数的 this 取决于调用方式，可以被 call/apply/bind 改变，也可以作为构造函数使用。箭头函数的 this 在定义时从外层作用域捕获，没有 arguments，也没有 prototype，不能 new。项目中箭头函数适合回调中保持外层 this，但不适合作为对象方法、构造函数或需要动态 this 的场景。

# 按标签索引

说明：已省略数据集通用标签「前端」「八股」；其余标签均列出对应题号。

- **JavaScript**：Q4、Q9、Q11、Q12、Q13、Q16、Q17、Q30、Q37、Q45
- **Vue**：Q1、Q6、Q15、Q22、Q27、Q28、Q31、Q42、Q44
- **场景题**：Q8、Q10、Q16、Q25、Q34、Q38、Q39、Q40
- **性能优化**：Q10、Q16、Q21、Q25、Q33、Q34、Q43
- **CSS**：Q19、Q26、Q29、Q36、Q40
- **React**：Q1、Q18、Q20、Q22、Q33
- **浏览器**：Q3、Q8、Q9、Q14、Q21
- **布局**：Q26、Q36、Q40
- **网络**：Q2、Q14、Q24
- **HR面**：Q5、Q32
- **HTTP**：Q2、Q24
- **Hooks**：Q18、Q33
- **BFC**：Q26
- **CORS**：Q8
- **CSRF**：Q23
- **Fiber**：Q20
- **Flex**：Q40
- **HTML**：Q35
- **HTTP缓存**：Q3
- **Promise**：Q4
- **Token**：Q38
- **TypeScript**：Q41
- **Vite**：Q7
- **Webpack**：Q7
- **XSS**：Q23
- **computed**：Q27
- **nextTick**：Q42
- **this**：Q45
- **v-model**：Q44
- **watch**：Q27
- **事件循环**：Q9
- **前端监控**：Q39
- **原型链**：Q13
- **变量声明**：Q30
- **响应式原理**：Q15
- **垃圾回收**：Q12
- **工程化**：Q7
- **异步**：Q4
- **条件渲染**：Q28
- **框架对比**：Q1
- **浏览器安全**：Q23
- **深拷贝**：Q17
- **渲染**：Q14
- **渲染原理**：Q20
- **渲染模式**：Q43
- **登录鉴权**：Q38
- **白屏排查**：Q25
- **盒模型**：Q19
- **类型转换**：Q37
- **组件通信**：Q31
- **职业动机**：Q32
- **自我介绍**：Q5
- **虚拟DOM**：Q22
- **虚拟列表**：Q34
- **跨域**：Q8
- **选择器**：Q29
- **闭包**：Q11
- **首屏优化**：Q10
