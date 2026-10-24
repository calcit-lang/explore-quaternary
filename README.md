
# Explore Quaternary

> 基于正式 Calcit / `@calcit/procs` 0.30.1 的四叉树交互示例。

## 使用者影响

本轮继续配对正式 0.30.1，并更新 Reel 0.6.42、UI 0.8.1、Respo 0.16.126、js-ffi 0.2.6，
传递 Router 0.8.38，Vite 精确固定 8.3.3。升级后重新安装模块、重启开发服务并完整刷新，
不迁移或清空已有存档。
启动先完成原有存档读取、解析与 Map 解码，再首次渲染和注册保存回调/定时器；
恢复失败时中断启动，避免后续保存初始值覆盖原数据。保留 `workflow` key、未知字段、
树展开/收起及缺失字段行为，不添加业务默认值或强转。背景见 [#11](https://github.com/calcit-lang/explore-quaternary/issues/11)。
本轮不改变部署路径，也不把完整 strict 通过等同于所有异构边界已静态化。
迁移9处旧Option/Map调用；Less/More两个DOM回调按Respo实际EventHandler收紧事件/dispatch合同。
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

当前正式模块的依赖请求已对齐，CI 使用 strict Caps 解析，并要求零退役调用和零动态方法派发。
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

开发先编译一次再启动 Vite；实时修改 Calcit 时另开终端运行 `calcit -w calcit.cirru`，
由 JS default entry 决定生成后端，不将一次性的 `js` 子命令与 watch 混用，也不增加 concurrently。

## CI 工作流

https://github.com/calcit-lang/respo-calcit-workflow

## 许可证

MIT
