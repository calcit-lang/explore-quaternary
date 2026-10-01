
# Explore Quaternary

> 基于 Calcit 0.27.0 与 Respo 的四叉树交互示例。浏览器宿主调用统一使用 `js-ffi.browser`。

源码使用 `calcit.cirru` / `deps.cirru`，CI 禁止退役的 `compact.cirru` / `package.cirru`。
PR 前端资源按 `pr/<number>/<run-id>/` 隔离；Vite 与 COS Action v1.1.1
共用 base URL，上传公开校验仅用 Action 内置能力，不添加额外验证脚本。
生产前缀和原服务器部署路径不变。

演示：http://repo.calcit-lang.org/explore-quaternary/ 。

### 开发与验证

```bash
caps --ci
corepack yarn install --immutable
calcit calcit.cirru --check-only
calcit calcit.cirru analyze check-public --ns app.main --ns app.comp.container --ns app.updater --ns app.config --ns app.schema --summary-only
calcit calcit.cirru test --require-match
fnm exec --using v24.4.1 yarn build
```

已发布 Reel/Markdown 的传递版本请求仍有冲突，当前 CI 使用非严格 Caps 解析；
不宣称严格依赖解析或全部类型债务已经完成。

### CI 工作流

https://github.com/calcit-lang/respo-calcit-workflow

### 许可证

MIT
