
# Explore Quaternary

> 基于 Calcit 0.27.0 与 Respo 的四叉树交互示例。浏览器宿主调用统一使用 `js-ffi.browser`。

源码使用 `calcit.cirru` / `deps.cirru`，CI 禁止退役的 `compact.cirru` / `package.cirru`。
PR 前端资源按 `pr/<number>/<run-id>/<attempt>/` 隔离；Vite 与 COS Action v1.2.0
共用 base URL，上传公开校验仅用 Action 内置能力，不添加额外验证脚本。
生产前缀和原服务器部署路径不变。

演示：http://repo.calcit-lang.org/explore-quaternary/ 。

### 开发与验证

```bash
caps --ci
corepack yarn install --immutable
caps verify --toolchain
calcit calcit.cirru --check-only
calcit calcit.cirru analyze check-public --ns app.main --ns app.comp.container --ns app.updater --ns app.config --ns app.schema --summary-only
calcit calcit.cirru test --require-match
yarn build
yarn dev
```

已发布 Reel/Markdown 的传递版本请求仍有冲突，当前 CI 使用非严格 Caps 解析；
不宣称严格依赖解析或全部类型债务已经完成。

Memof 升级到兼容正式 0.0.36，不新增模块 hash 或机械降级 alpha。原定义内测试、严格入口、全部业务 namespace 公开定义检查及规范格式保留，精简重复诊断报告。COS action 内置检查生成 HTML 同域脚本/样式引用和公开字节/SHA-256，无额外项目脚本；生产前缀和服务器路径保持不变。

开发先编译一次再启动 Vite；实时修改 Calcit 时另开终端运行 `calcit calcit.cirru js -w`，不增加 concurrently。

### CI 工作流

https://github.com/calcit-lang/respo-calcit-workflow

### 许可证

MIT
