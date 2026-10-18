
# Explore Quaternary

> 基于 Calcit 0.30.1-alpha.4 与正式 Respo 模块的四叉树交互示例。编译器与 `@calcit/procs` 使用同一个预发布版本；不是 0.30.1 正式版。

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
calcit calcit.cirru --check-only --all-defs
calcit calcit.cirru fix --workflow strict --verify
calcit calcit.cirru test --require-match
yarn build
yarn dev
```

正式 Respo 模块的传递版本请求仍有差异，当前 CI 使用非严格 Caps 解析；
不宣称严格依赖解析或全部类型债务已经完成。CI 同时要求零退役调用和零动态方法派发。

Reel 使用泛型 `reel.typed/State<Enum, Map<Tag, Dynamic>>`，状态更新通过单个 Enum 操作派发。
游标、数字和叶节点 Bool 在开放状态入口校验；保留 `workflow` 存储键、原存档 Map 的未知字段、
分支收起时清理子状态的行为，以及缺失 `:size` 时 `update` 不补写的语义。
根状态和嵌套 UI 状态是实际的异构 Map，分支值仍是原来的 Bool/Tag，不伪造强转或泛型。
现有覆盖报告为 10 个 full / 8 个 partial / 0 个 none；仍有 15 处 schema Dynamic 边界，不宣称零类型债务。

移除未使用的 Lilac、Memof、Markdown 模块及旧导入。保留原定义内测试、全部定义检查与规范格式；
不增加项目专用验证 runner、质量预算或 concurrently。
COS action 内置检查生成 HTML 同域脚本/样式引用和公开字节/SHA-256，无额外项目脚本；生产前缀和服务器路径保持不变。

开发先编译一次再启动 Vite；实时修改 Calcit 时另开终端运行 `calcit calcit.cirru js -w`，不增加 concurrently。

### CI 工作流

https://github.com/calcit-lang/respo-calcit-workflow

### 许可证

MIT
