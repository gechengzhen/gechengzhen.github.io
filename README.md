# Hugo Stack 双语博客

这个仓库已经整理成一个可部署到 GitHub Pages 的 Hugo 博客，当前使用 `Stack` 主题，并支持中文和英文双语内容。

## 当前结构

- `content/posts/<slug>/index.zh-cn.md` 或 `index.en.md`
- `content/posts/<slug>/*.assets/`
- `content/page/archives/`
- `content/page/search/`
- `themes/hugo-theme-stack-compat/`
- `.github/workflows/hugo.yaml`

## 写文章

单语言文章：

1. 新建目录 `content/posts/your-post-slug/`
2. 新建 `index.zh-cn.md` 或 `index.en.md`
3. 把图片放进同目录，正文里继续用相对路径即可

中英双文：

1. 在同一个目录下放 `index.zh-cn.md`
2. 再放 `index.en.md`
3. 两篇文章共用同一套图片资源

示例：

```text
content/posts/my-first-post/
  index.zh-cn.md
  index.en.md
  cover.jpg
```

## 本地预览

这个项目已经带了本地 Hugo 可执行文件和启动脚本。

PowerShell:

```powershell
.\preview.ps1
```

或直接运行：

```bat
preview.cmd
```

启动后访问：

- 中文首页：`http://127.0.0.1:1313/`
- 英文首页：`http://127.0.0.1:1313/en/`

## 部署到 GitHub Pages

1. 在 GitHub 新建仓库
2. 把当前目录推上去
3. 打开 `Settings > Pages`
4. 将 `Source` 设为 `GitHub Actions`
5. 保持默认分支为 `main`

以后每次 push，GitHub 会自动构建并发布。

## 建议你接下来改的内容

- 把 `hugo.toml` 里的站点标题和侧边栏文案改成你自己的
- 把 `content/about/index.zh-cn.md` 和 `content/about/index.en.md` 改成个人简介
- 如果你有自己的头像，可以替换 `assets/img/avatar.png`
