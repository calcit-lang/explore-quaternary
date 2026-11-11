# Explore Quaternary

四叉树交互示例：[Demo](http://repo.calcit-lang.org/explore-quaternary/)。

## 使用者影响

请配对使用 Calcit 与 `@calcit/procs` **0.41.0**，重新安装依赖并构建。Less/More、展开与收起、原存档格式和页面错误提示沿用原行为。树编辑使用具名动作，只更新对应字段。

正式模块为 Respo 0.19.5、UI 0.15.2、JS FFI 0.2.13、Reel 0.11.0，传递 Router 0.12.2。界面操作和 Reel 调试控制分别使用类型化回调，内部用 `Op | Reel.Control` 分发。快捷键和面板操作继续适用。树分支使用 `Bool | Tag`，缺失字段通过 `Option` 表达。原状态 Map 中的额外字段继续保留。

保留 `workflow` 存档键；启动先读取、解析和检查存档，再渲染、注册 watch/保存。恢复失败时中断启动，避免初始状态覆盖原文；背景见 [#11](https://github.com/calcit-lang/explore-quaternary/issues/11)。

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

## 前端部署

主站资源前缀为 `https://cos-sh.tiye.me/calcit-lang/explore-quaternary/`；PR 使用 `pr/<number>/<run-id>/<attempt>/` 隔离路径。Vite 与 COS action v1.2.0 使用相同 base URL，仅上传 dist，通过 action 内置 verify 校验，不增加额外脚本。

生产 rsync 仅在 main 执行，原 `/web-assets/repo/calcit-lang/explore-quaternary` 路径保持。同仓库 PR 可上传隔离前端预览；fork PR 只执行检查和构建，不上传 COS 预览。本轮不合并、不部署生产、不发布 tag/npm。

## 许可证

MIT
