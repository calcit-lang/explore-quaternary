# Explore Quaternary

四叉树交互示例：[Demo](http://repo.calcit-lang.org/explore-quaternary/)。

## 0.32.1 迁移候选：使用者影响

CLI 与 `@calcit/procs` 配对正式 **0.32.1**。升级后重新安装完整模块图、生成 JS 并完整刷新，避免混用旧缓存；不迁移或清空已有存档。应用版本仍为 0.0.2，本 PR 不发布模块。

模块使用已发布的 Respo 0.17.1、UI 0.9.0、JS FFI 0.2.9、Reel 0.7.0-alpha.5，传递 Router 0.9.0-alpha.4；Reel/Router 仍含 alpha，不宣称整图均已正式版。已通过真实 Caps strict 发布依赖解析与 toolchain 校验，模块不可变源码与此前测试一致；最新 main 未变化且无重复迁移 PR，远端 CI 仍待执行。

官方 formatter 迁移四处类型存储写法；四个 DOM 回调的派发提示收紧为真实单 Enum/Unit，不再声明 Dynamic/rest 调用。19 个原定义的 schema、原附带测试和运行逻辑保持；收紧提示前后的全部浏览器构建产物逐字节相同。Less/More、树展开/收起、叶节点 Bool/Tag、缺失 `:size` 时不补值及真实 `hud!` 保留。根状态和嵌套 UI 状态确为异构 Map，保留未知字段，不用强转或同质 Map 声明掩盖边界。`DispatchOp` 仅为入口绑定真实 Enum 类型，代表值不派发。

保留 `workflow` 存档键；启动先读取、解析和检查存档，再渲染、注册 watch/保存。恢复失败时中断启动，避免初始状态覆盖原文；背景见 [#11](https://github.com/calcit-lang/explore-quaternary/issues/11)。本轮不修改恢复/保存顺序。

## 开发与验证

使用 Node.js 24、Yarn 4.18.0、Caps 0.1.1。npm 发布等待一小时，无包豁免。
源码仅为 `calcit.cirru` / `deps.cirru`；不提交 `js-out/`、`dist/` 或退役的 compact/package Snapshot。

```bash
caps --strict --ci
corepack yarn install --immutable
caps verify --toolchain
calcit --check-only --all-defs
calcit fix --workflow strict --verify
calcit test --require-match
corepack yarn build
corepack yarn dev
```

CI 保留 all-defs、完整 strict（必须 passed 且 diagnostics 为空）、原测试、零动态方法和零弃用调用门禁，不新增项目验证脚本、强转、预算豁免或 concurrently。实时 Calcit 开发另开终端运行 `calcit -w calcit.cirru`。

本轮本地 200 个定义、完整 strict、原一项附带测试、dynamic-method=0、deprecated-call=0、immutable 安装和 JS/Vite 构建通过。本轮 0.32.1 实际页面已验证 More 创建第二棵测试树、分支展开、叶节点变蓝以及刷新恢复，控制台无 warn/error。没有执行 Less 或 x 清理操作；坏存档、非空子状态清理、HMR 和 60 秒定时保存未复验。

## 前端部署

主站资源前缀为 `https://cos-sh.tiye.me/calcit-lang/explore-quaternary/`；PR 使用 `pr/<number>/<run-id>/<attempt>/` 隔离路径。Vite 与 COS action v1.2.0 使用相同 base URL，仅上传 dist，通过 action 内置 verify 校验，不增加额外脚本。

生产 rsync 仅在 main 执行，原 `/web-assets/repo/calcit-lang/explore-quaternary` 路径保持。创建 PR 可上传隔离前端预览；本轮不合并、不部署生产、不发布 tag/npm。

## 许可证

MIT
