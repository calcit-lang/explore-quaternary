# Upgrade to Calcit 0.13.77 / 升级到 Calcit 0.13.77

## English

- Migrated the last executable legacy Snapshot to canonical `calcit.cirru` with the Calcit 0.13.77 CLI and removed the retired duplicate `compact.cirru`.
- Added exact Calcit, module, Yarn, and JavaScript dependency metadata while preserving package version `0.0.1` and the quaternary exploration behavior.
- Updated the small application to current Option, Map-field, tagged-operation, Reel, and JavaScript FFI contracts.
- Added a reviewed per-definition static-quality baseline for this legacy application and hardened CI with immutable actions, least privilege, strict Caps, immutable Yarn, canonical formatting, and production build gates.
- Published Respo 0.16.90 still blocks normal check-only and JavaScript code generation at `respo.core/decorate-defcomp` (tracked by `calcit-lang/calcit#670`). With the merged post-fix Respo source temporarily linked, check-only, the no-growth quality baseline, dynamic-method limit 0, JavaScript generation, and the Node 24/Vite production build all pass; the project link was restored afterward.

## 中文

- 使用 Calcit 0.13.77 CLI 将最后有效的旧 Snapshot 迁移为规范 `calcit.cirru`，并删除退役的重复 `compact.cirru`。
- 补充精确的 Calcit、模块、Yarn 与 JavaScript 依赖元数据，同时保持包版本 `0.0.1` 和四元结构探索行为不变。
- 将这个小应用更新到当前的 Option、Map 字段读取、tagged operation、Reel 与 JavaScript FFI 契约。
- 为存量应用加入按定义审阅的静态质量 baseline，并用不可变 Action、最小权限、strict Caps、immutable Yarn、规范格式和生产构建门禁加固 CI。
- 已发布的 Respo 0.16.90 仍会在 `respo.core/decorate-defcomp` 阻断常规 check-only 和 JavaScript 生成（由 `calcit-lang/calcit#670` 跟踪）。临时链接已合并修复后的 Respo 源码时，check-only、无增长质量 baseline、动态方法上限 0、JavaScript 生成以及 Node 24/Vite 生产构建全部通过；随后已恢复项目依赖链接。
