
# Explore Quaternary

> 四叉树交互示例；当前为 Calcit / `@calcit/procs` 0.32.0 迁移候选。

## Calcit 0.32.0 迁移候选：使用者影响

CLI/procs 配对正式 0.32.0，需重新安装完整依赖图、生成 JS 并刷新。
UI 模块使用本地候选，已发布标签整图尚待验证。Less/More、分支与叶节点操作、
旧存档的开放 Map 合同、恢复后注册保存的顺序和真实 HUD 保持不变。

官方转换四处类型写法，19 个定义 schema 不变；完整 strict、原附带测试、
零动态方法与零弃用调用门禁保留，不增加强转、业务默认值或验证脚本。
依赖隔离统一为一小时，COS 内置校验和前端部署路径保持。

本地全部 200 个定义、完整 strict（diagnostics 为空）、原一项测试、零动态方法/
零弃用调用、构建及 immutable 安装通过。实际 More、分支展开、叶节点切换及
两棵树/展开分支/蓝色叶节点刷新恢复通过，warn/error 为空。独立评审的版本说明已修正。
本轮未验收 Less、分支清理、坏存档、HMR 或 60 秒定时器。
正式依赖整图和 PR/Linux CI 尚待验证。下方 0.31 说明为历史记录。

## 历史：0.31 使用者影响

本轮配对正式 CLI/procs 0.31.0；Reel 0.7.0-alpha.4、UI 0.9.0-alpha.4、
Respo 0.17.0-alpha.4 和传递 Router 0.9.0-alpha.3 仍是已发布的 alpha 模块，
不能视为稳定模块版本。js-ffi 使用正式 0.2.7，Vite 精确固定 8.3.3。升级后重新安装模块、重启开发服务并完整刷新，
不迁移或清空已有存档。
启动先完成原有存档读取、解析与 Map 解码，再首次渲染和注册保存回调/定时器；
恢复失败时中断启动，避免后续保存初始值覆盖原数据。保留 `workflow` key、未知字段、
树展开/收起及缺失字段行为，不添加业务默认值或强转。背景见 [#11](https://github.com/calcit-lang/explore-quaternary/issues/11)。
本轮不改变部署路径，也不把完整 strict 通过等同于所有异构边界已静态化。
此前迁移9处旧Option/Map调用；Less/More两个DOM回调按Respo实际EventHandler收紧事件/dispatch合同。
状态树producer真实支持Tag/数字/字符串混合key，两个组件继续保留开放Map，不能伪造Tag-only合同；
7处CSS值按原Respo规则改为等价String，真实 `hud!` 成功/错误展示完整保留，不替换成raise。
原恢复/保存顺序、树算法、缺失字段和原附着测试不变，不增加helper、强转或预算。

源码使用 `calcit.cirru` / `deps.cirru`，CI 禁止退役的 `compact.cirru` / `package.cirru`。
PR 前端资源按 `pr/<number>/<run-id>/<attempt>/` 隔离；Vite 与 COS Action v1.2.0
共用 base URL，上传公开校验仅用 Action 内置能力，不添加额外验证脚本。
生产前缀和原服务器部署路径不变。

演示：http://repo.calcit-lang.org/explore-quaternary/ 。

## 开发与验证

```bash
caps --strict --ci
corepack yarn install --immutable
caps verify --toolchain
calcit calcit.cirru --check-only --all-defs
calcit calcit.cirru fix --workflow strict --verify
calcit calcit.cirru test --require-match
yarn build
yarn dev
```

当前模块的依赖请求已对齐，CI 使用 strict Caps 解析，并要求零退役调用和零动态方法派发。
通过严格检查不代表全部类型债务已经完成。

Reel 使用泛型 `reel.typed/State<Enum, Map<Tag, Dynamic>>`，状态更新通过单个 Enum 操作派发。
游标、数字和叶节点 Bool 在开放状态入口校验；保留 `workflow` 存储键、原存档 Map 的未知字段、
分支收起时清理子状态的行为，以及缺失 `:size` 时 `update` 不补写的语义。
根状态和嵌套 UI 状态是实际的异构 Map，分支值仍是原来的 Bool/Tag，不伪造强转或泛型。
根状态Map的真实异构值仍保持Dynamic，不把数字、Bool/Tag分支和开放UI状态伪装成同质数据；
旧覆盖计数不代替本轮源码/类型检查，不宣称零类型债务。

移除未使用的 Lilac、Memof、Markdown 模块及旧导入。保留原定义内测试、全部定义检查与规范格式；
不增加项目专用验证 runner、质量预算或 concurrently。
COS action 内置检查生成 HTML 同域脚本/样式引用和公开字节/SHA-256，无额外项目脚本；生产前缀和服务器路径保持不变。
本PR不合并、部署或发版；合并仍会触发原Demo前端部署，需要另行确认。

此前官方Linux 0.30.1事务CI在改写前后均通过all-defs199项和原附着测试1项，
改写后完整strict、零退役调用/零动态方法门禁及JS/Vite构建通过；没有额外Node测试框架。
仍有8个定义的15处真实开放类型边界，保持原schema，不用类型计数假装全静态化。
同一CI静态产物在全新localhost实际验收Less/More、空子状态分支展开/收起、叶节点切换，
以及两棵树/展开分支/蓝色叶节点的真实刷新恢复，控制台无warning/error。
未验证坏存档、非空子状态丢弃、HMR、60秒定时器或全部旧存档形状，不能用正常恢复冒充这些证明。

开发先编译一次再启动 Vite；实时修改 Calcit 时另开终端运行 `calcit -w calcit.cirru`，
由 JS default entry 决定生成后端，不将一次性的 `js` 子命令与 watch 混用，也不增加 concurrently。

本轮仅补充 Respo 的 `dispatch-op` 入口绑定为 Enum，与原有 Enum 运行检查一致，
没有改动 dispatch/updater 或存档逻辑。新增的 DispatchOp 代表值不会派发。
0.31.0 本地全部定义200项、完整strict、原附着测试1项、零动态方法/弃用门禁、
immutable安装和JS/Vite构建通过。实际Less/More、空分支展开/收起、叶节点切换及
两棵树/蓝色叶节点刷新恢复通过，控制台无warning/error。
未重新验收坏存档、非空子状态丢弃、HMR或60秒定时器；这些限制仍保留。

## CI 工作流

https://github.com/calcit-lang/respo-calcit-workflow

## 许可证

MIT
