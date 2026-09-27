
# Explore Quaternary

> 基于 Calcit 0.24.3 与 Respo 的四叉树交互示例。浏览器宿主调用统一使用 `js-ffi.browser`。

演示：http://repo.calcit-lang.org/explore-quaternary/ 。

### 开发与验证

```bash
caps --ci --strict
corepack yarn install --immutable
calcit calcit.cirru --check-only
calcit calcit.cirru analyze check-public --ns app.main --ns app.comp.container --ns app.updater --ns app.config --ns app.schema --summary-only
calcit calcit.cirru test --require-match
fnm exec --using v24.4.1 yarn build
```

### CI 工作流

https://github.com/calcit-lang/respo-calcit-workflow

### 许可证

MIT
