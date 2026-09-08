# Resume published-provider migration / 恢复正式依赖迁移

Tracks calcit-lang/calcit#748. Replayed preserved migration 3f52f12 onto
unchanged authoritative main 95f6300 in a fresh worktree; the dirty shared
checkout remains untouched. The staged Snapshot conversion and behavior
changes remain the prior reviewed checkpoint, not a manual Snapshot rewrite.

Consume published Reel 0.6.19, Markdown 0.4.33, UI 0.7.19, Respo 0.16.95,
Lilac 0.5.9 and memof 0.0.31. Strict Caps resolves eight modules including
router 0.8.13 and js-ffi 0.1.12 without conflicts. Restore readable exact
Action tags at the same revisions (checkout v5.1.0, setup-node v5.0.0,
setup-calcit v1.4.0, action-rsyncer v2.0.0), verified via GitHub tag refs.

使用全新 worktree 复用旧迁移，更新为当前一致的正式依赖版本，解除旧版
Respo 的冲突。保持版本 0.0.1 与既有质量基线，不修改共享目录。

Validation: exact Calcit/procs 0.13.77, immutable Yarn, strict Caps/toolchain,
canonical Snapshot no diff, init/reload check-only, unchanged quality gate,
dynamic methods 0, deprecated calls 0, JS generation, Node 24/Vite production
build. No attached tests are defined (discovery returned 0, not test coverage).
Browser smoke on localhost: initial one tree, More adds a second tree, Less
returns to one, with no browser error logs. Existing get-env mode warning is
unchanged. No deployment or publication was run locally.

本地浏览器验证 More/ Less 增减行为且无运行错误；原有 mode 环境提示保留。
没有将零条测试发现当作测试覆盖，也未执行部署或发布。
