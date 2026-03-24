# 博客维护说明

这份文档是给这个博客项目的日常维护用的。

当前博客技术栈：

- 静态站点生成器：Hugo
- 主题：Stack
- 托管：GitHub Pages
- 发布方式：GitHub Actions 自动部署

## 1. 项目结构

常用目录：

- `content/posts/`：文章目录
- `content/about/`：关于页
- `content/page/search/`：搜索页
- `content/page/archives/`：归档页
- `assets/img/avatar.png`：头像
- `hugo.toml`：站点配置
- `.github/workflows/hugo.yaml`：自动部署配置
- `preview.ps1` / `preview.cmd`：本地预览脚本

一篇文章的结构通常是：

```text
content/posts/your-post-slug/
  index.zh-cn.md
  index.en.md
  image1.png
  your-post-slug.assets/
```

说明：

- `your-post-slug` 建议用英文、短横线命名
- 中文文章放 `index.zh-cn.md`
- 英文文章放 `index.en.md`
- 图片和附件放在同一篇文章目录里

## 2. 新增中文文章

假设要写一篇新文章，slug 叫 `my-new-post`。

1. 新建目录：

```text
content/posts/my-new-post/
```

2. 新建文件：

```text
content/posts/my-new-post/index.zh-cn.md
```

3. 写入 Front Matter 示例：

```md
---
title: "你的文章标题"
date: 2026-03-25T12:00:00+08:00
slug: my-new-post
tags:
  - tag1
  - tag2
---

这里开始写正文。
```

4. 如果有图片，放在同目录里，然后在 Markdown 中引用：

```md
![](./image1.png)
```

如果你沿用旧文章风格，也可以保留：

```md
![](./my-new-post.assets/image1.png)
```

## 3. 中英双语怎么维护

目前不会自动翻译英文。

如果你只写中文：

- 只创建 `index.zh-cn.md`
- 英文站点不会自动生成这篇英文文章

如果你要双语：

1. 先写中文：`index.zh-cn.md`
2. 再补英文：`index.en.md`
3. 两个文件放在同一个目录下
4. 共用同一套图片资源

英文示例：

```md
---
title: "My New Post"
date: 2026-03-25T12:00:00+08:00
slug: my-new-post
tags:
  - tag1
---

English content goes here.
```

建议做法：

- 先写中文
- 再翻译成英文
- 英文标题、标签可以适当本地化，不必逐字直译

## 4. 本地预览

在项目根目录运行：

```powershell
.\preview.ps1
```

或者：

```bat
preview.cmd
```

预览地址：

- 中文首页：`http://127.0.0.1:1313/`
- 英文首页：`http://127.0.0.1:1313/en/`

如果修改了文章内容、图片或配置，Hugo 会自动刷新。

停止预览：

- 在终端按 `Ctrl + C`

## 5. 发布流程

日常发布流程：

1. 写文章或修改页面
2. 本地预览确认效果
3. 提交到 Git
4. 推送到 GitHub
5. GitHub Actions 自动构建
6. GitHub Pages 自动更新网站

常用 Git 命令：

```powershell
git add .
git commit -m "add new post"
git push
```

如果这是第一次推送，需要先把本地仓库关联到 GitHub 远程仓库。

## 6. 查看线上发布是否成功

去 GitHub 仓库页面查看：

1. `Actions`
2. 找到最新一次工作流
3. 如果是绿色对勾，说明发布成功
4. 如果失败，点进去看日志

GitHub Pages 的配置要确认：

1. 打开仓库 `Settings > Pages`
2. `Source` 选择 `GitHub Actions`

## 7. 常见维护项

### 修改站点名称和侧边栏说明

编辑：

- `hugo.toml`

重点看：

- `title`
- `[languages.zh-cn]`
- `[languages.en]`
- `[languages.zh-cn.params.sidebar]`
- `[languages.en.params.sidebar]`

### 修改关于页

编辑：

- `content/about/index.zh-cn.md`
- `content/about/index.en.md`

### 修改头像

替换：

- `assets/img/avatar.png`

建议：

- 尽量使用方形图片
- PNG/JPG 都可以

### 修改主题

当前主题目录：

- `themes/hugo-theme-stack-compat/`

如果只是写文章，通常不要改这个目录。

## 8. 图片和公式注意事项

### 图片

正文里推荐使用相对路径：

```md
![](./image1.png)
```

或者：

```md
![](./your-post.assets/image1.png)
```

不要随便写成站点绝对路径，比如：

```md
![](/image1.png)
```

除非你明确知道图片放在全站公共静态目录。

### 公式

当前站点已经启用 KaTeX。

行内公式示例：

```md
$E = mc^2$
```

块级公式示例：

```md
$$
\alpha = \frac{a}{b}
$$
```

如果公式显示异常，优先检查：

- `$` 是否成对
- `$$` 是否成对
- 是否混入了 Markdown 的强调符号 `*`

## 9. 排错

### 本地预览打不开

先确认你是不是已经启动了预览脚本：

```powershell
.\preview.ps1
```

如果提示端口占用：

- 关闭之前打开的 Hugo 预览窗口
- 或者终端里按 `Ctrl + C` 停掉旧服务再重启

### 图片不显示

检查：

1. 图片文件是否真的在文章目录里
2. Markdown 路径是否正确
3. 文件名大小写和后缀是否一致

### 公式不显示

检查：

1. 公式分隔符是否正确
2. 是否有不完整的 LaTeX 语法
3. 刷新页面后再看一次

### GitHub 发布失败

检查：

1. `.github/workflows/hugo.yaml` 是否还在
2. GitHub Pages 是否设置为 `GitHub Actions`
3. Actions 日志里报的是 Hugo 构建错误还是配置错误

## 10. 推荐维护习惯

- 每次发文前先本地预览
- slug 尽量保持简短稳定，发布后不要频繁改
- 图片文件名尽量清晰
- 中文和英文版本放在同一篇文章目录里
- 大改主题前先提交一次 Git，方便回退

## 11. 后续可扩展的方向

以后如果你想继续升级，可以考虑：

- 自动生成英文翻译草稿
- 增加评论系统
- 增加文章封面图
- 增加分类页
- 接入自定义域名
- 接入网站统计

如果后面你忘了怎么操作，优先看这份文档，再看 `README.md`。
