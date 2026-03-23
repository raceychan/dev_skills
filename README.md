# dev_skills

这是一个自定义 OpenClaw skills 仓库。

你把 skill 目录放在这个仓库根目录下，只要目录内有 `SKILL.md`，它就会被识别为一个可迁移的 skill。

## 仓库结构

示例：

```bash
/dev_skills
  /requirement-to-plan
    SKILL.md
    /references
  /requirement-to-tech-spec
    SKILL.md
  /scripts
    migrate-skills.sh
  Makefile
```

## 最常用的用法

进入仓库根目录后执行：

```bash
make skills
```

这条命令会：

1. 自动分析宿主机上的 OpenClaw 安装位置
2. 自动找到对应的 `skills` 目录
3. 把当前仓库中的 skills 迁移过去

## 预览模式

如果你想先看它会做什么，不真正改文件：

```bash
make skills-dry-run
```

## 底层脚本

`make skills` 实际调用的是：

```bash
./scripts/migrate-skills.sh
```

你也可以直接执行脚本。

## 脚本参数

```bash
./scripts/migrate-skills.sh --dry-run
./scripts/migrate-skills.sh --target /opt/homebrew/lib/node_modules/openclaw/skills
./scripts/migrate-skills.sh --no-delete
```

参数说明：

- `--dry-run`：只预览，不写入
- `--target DIR`：手动指定目标 skills 目录
- `--no-delete`：迁移时不删除目标目录里那些“本仓库不存在”的文件

## 自动探测逻辑

脚本会优先尝试：

1. 从 `openclaw` 可执行文件反查安装目录
2. 常见全局安装路径，例如：
   - `/opt/homebrew/lib/node_modules/openclaw`
   - `/usr/local/lib/node_modules/openclaw`
   - 一些 nvm / volta / asdf 的 Node 全局目录

探测到安装根目录后，脚本会把目标设为：

```bash
<openclaw_install_root>/skills
```

## 注意事项

- 只有**仓库根目录下**、且**包含 `SKILL.md`** 的目录会被当成 skill 迁移
- `scripts/`、`.git/` 等非 skill 目录会自动跳过
- 脚本使用 `rsync` 进行同步
- 默认会做“同步式迁移”；如果目标 skill 目录下存在而仓库里不存在的文件，可能会被删除。若不希望删除，请使用：

```bash
./scripts/migrate-skills.sh --no-delete
```

## 推荐发布流程

1. 在这个仓库里修改或新增 skill
2. 提交并 push
3. 在目标机器上拉取最新代码
4. 执行：

```bash
make skills
```
