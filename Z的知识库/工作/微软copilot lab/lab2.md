# Lab 2: GitHub Copilot 实战场景练习

## 实验目标

本实验基于 `scenarios` 文件夹中的各类真实场景,带你逐一体验 GitHub Copilot 在日常开发中的核心能力,包括:代码解释、生成注释、代码翻译、格式转换、代码重构、文档生成、Notebook 数据分析、视觉识别和网页抓取等。

## 前置条件

- 已完成 **Lab 1**:安装 VS Code、登录 GitHub 账号并确认 Copilot Chat 可以正常使用

> 💡 **通用技巧**:
>
> - 在 Copilot Chat 中输入 `#file` 可以引用具体文件,输入 `/` 可以查看斜杠命令(如 `/explain`、`/fix`)。
> - 把文件从资源管理器拖拽到聊天面板,也可以将其加入聊天上下文。

---

## 场景 1: 格式转换(change-format)

**目录**: `scenarios/change-format`

让 Copilot 在不同数据格式之间转换,提示词可参考该目录下的 `prompt.md`。

1. 打开 `scenarios/change-format/cities.csv`,在 Copilot Chat 中输入:

   ```text
   based on the information in cities.csv, create a table in a new markdown file
   ```

   (也可以用中文:`根据 #file:cities.csv 的内容,在一个新的 markdown 文件中生成表格`)

2. 打开 `scenarios/change-format/sourcejson.txt`(一段未格式化的 JSON),在 Copilot Chat 中输入:

   ```text
   update the content in sourcejson.txt with good format
   ```

   (中文:`把 #file:sourcejson.txt 中的 JSON 内容格式化为规范缩进的格式`)

3. 进阶练习:让 Copilot 把 CSV 转成 JSON、YAML 或 SQL INSERT 语句

**预期结果**: CSV 数据被转换为整齐的 Markdown 表格;JSON 文件被格式化为带缩进的规范格式。

---

## 场景 2: 更换实现语言并修复 Bug(change-language)

**目录**: `scenarios/change-language`

结合注释驱动开发与跨语言改写。

1. 打开 `scenarios/change-language/utils.py`,阅读 `generate_random_password` 函数(一个根据注释需求生成随机密码的函数)
2. 在 Copilot Chat 中输入:

   ```text
   分析 #file:utils.py 中的密码生成函数是否完全满足文件头部注释中列出的需求,有没有潜在问题?
   ```

3. 让 Copilot 用其他语言重写该函数:

   ```text
   用 C# 重写这个密码生成函数,满足注释中的全部需求,并避免递归重试的写法
   ```

4. 对比生成结果与原实现的差异(例如是否改用循环、是否保证每类字符至少出现一次)

**预期结果**: Copilot 能指出原实现的问题(如递归重试效率低、可能包含空格字符的边界问题),并给出更健壮的目标语言实现。

---

## 场景 3: 代码解释(explain)

**目录**: `scenarios/explain`

让 Copilot 帮你快速读懂陌生代码。

1. 打开 `scenarios/explain/github_api_wrapper.ts`
2. 在 Copilot Chat 中输入:

   ```text
   解释这个文件的功能和整体结构
   ```

3. 也可以选中某一个方法(如 `createOrganization`),按 `Ctrl+I` 打开内联聊天,输入 `/explain`,查看针对选中代码的解释
4. 继续追问细节,例如:

   ```text
   这个类使用了什么第三方库?调用 GitHub API 时是如何处理错误的?
   ```

**预期结果**: Copilot 输出对 `GitHubOrgManager` 类的功能说明,包括其使用 Octokit 调用 GitHub API、各方法的用途以及错误处理方式。

---

## 场景 4: 生成注释(generate-comment)

**目录**: `scenarios/generate-comment`

让 Copilot 为缺少注释的代码自动生成规范的文档注释。

1. 打开 `scenarios/generate-comment/car.ts`,可以看到该文件几乎没有注释
2. 选中整个 `Car` 类,按 `Ctrl+I` 打开内联聊天,输入:

   ```text
   为这个类和所有方法生成 TSDoc 格式的注释
   ```

3. 查看并接受 Copilot 生成的注释
4. 再打开 `scenarios/generate-comment/cities.cs`,对比参考:这是一个已经带有完整 XML 文档注释的 C# 文件。尝试在 Copilot Chat 中输入:

   ```text
   参考 #file:cities.cs 的注释风格,为 #file:car.ts 生成注释
   ```

**预期结果**: `car.ts` 中的类、构造函数、getter/setter 等都获得了风格统一、内容准确的文档注释。

---

## 场景 5: 生成 Markdown 文档(generate-md)

**目录**: `scenarios/generate-md`

让 Copilot 为代码自动生成项目文档,提示词可参考该目录下的 `prompt.md`。

1. 打开 `scenarios/generate-md/controller.rb`
2. 在 Copilot Chat 中输入:

   ```text
   Generate documentation from #file:controller.rb, display in md format
   ```

   (中文:`根据 #file:controller.rb 生成 API 文档,用 Markdown 格式展示`)

3. 让 Copilot 把生成的文档保存为新文件:

   ```text
   把上面的文档保存到 scenarios/generate-md/controller.md
   ```

**预期结果**: Copilot 生成一份结构清晰的 Markdown 文档,包含控制器中各接口/方法的说明、参数和返回值。

---

## 场景 6: Jupyter Notebook 数据分析(jupyter-notebook)

**目录**: `scenarios/jupyter-notebook`

让 Copilot 帮你创建 Notebook 并分析数据,提示词可参考该目录下的 `prompt.md`。

1. 确保已安装 Python 环境及 VS Code 的 Python / Jupyter 扩展
2. 在 Copilot Chat 中输入:

   ```text
   create a new notebook to analyze llm_comparison_dataset.csv
   ```

   (中文:`创建一个新的 notebook 来分析 #file:llm_comparison_dataset.csv 数据集`)

3. 运行 Copilot 生成的 Notebook 单元格,查看数据概览与可视化图表
4. 把 Notebook 中生成的图表拖拽到 Copilot Chat 的上下文中,输入:

   ```text
   分析这张图表中的数据,有哪些值得注意的结论?
   ```

5. 也可以打开现成的 `scenarios/jupyter-notebook/llm_analysis.ipynb`,让 Copilot 解释或扩展其中的分析

**预期结果**: Copilot 自动生成包含数据加载、清洗、统计和可视化的 Notebook,并能基于图表图片给出数据洞察。

---

## 场景 7: 代码重构 — 修复问题代码(refactor)

**目录**: `scenarios/refactor`

该目录包含多个存在典型问题的文件,逐一让 Copilot 找出问题并修复。

| 文件 | 问题类型 | 建议提示词 |
| --- | --- | --- |
| `SqlInjection.java` | SQL 注入漏洞 | `找出这个文件中的安全漏洞并修复` |
| `xss.js` | XSS 跨站脚本漏洞 | `这段代码有什么安全问题?请修复` |
| `nullptr.cpp` | 空指针解引用 | `找出这段 C++ 代码中的空指针问题并修复` |
| `BogoSort.java` | 算法效率极低 | `分析这个排序算法的时间复杂度,并改写为高效算法` |
| `slow.sql` | SQL 查询性能差 | `优化这个 SQL 查询的性能` |
| `duplicate.cs` | 大量重复代码 | `消除这个文件中的重复代码` |
| `ImageProcess.cs` | 资源未释放/性能问题 | `检查这个文件中的资源管理问题并重构` |
| `dom.js` | 频繁 DOM 操作 | `优化这段代码的 DOM 操作性能` |
| `Dockerfile` | 镜像构建不规范 | `按照最佳实践优化这个 Dockerfile,减小镜像体积` |

操作步骤(以 `SqlInjection.java` 为例):

1. 打开文件,通读代码
2. 在 Copilot Chat 中输入建议提示词
3. 查看 Copilot 的分析与修复方案,应用修改
4. 追问:`还有其他可以改进的地方吗?`

**预期结果**: Copilot 能准确识别每个文件中的安全漏洞、性能瓶颈或坏味道,并给出符合最佳实践的修复代码(如参数化查询、输出转义、`using` 语句、多阶段构建等)。

---

## 场景 8: 代码翻译(translation)

**目录**: `scenarios/translation`

让 Copilot 把源文件翻译成其他编程语言的实现。

1. 打开 `scenarios/translation/cities.cs`(一个使用组合关系的 C# 示例,包含 `Car`、`Person`、`City` 等类)
2. 在 Copilot Chat 中输入:

   ```text
   把 #file:cities.cs 翻译成 Python 实现,保持相同的类结构和注释
   ```

3. 将生成的 Python 代码保存为 `cities.py`,检查类结构、方法与原文件是否一致
4. 再尝试翻译成其他语言,例如:

   ```text
   把 #file:cities.cs 翻译成 Java / TypeScript / Go 实现
   ```

**预期结果**: Copilot 生成语义等价的目标语言代码,类之间的组合关系、方法逻辑和文档注释都被正确保留。

---

## 场景 9: 视觉识别 — 从图片生成代码(vision)

**目录**: `scenarios/vision`

体验 Copilot 的多模态能力:根据图片(数据库 ER 图、架构图、报错截图、UI 截图)完成代码相关任务。该目录下提供了 4 张图片,逐一把图片粘贴或拖拽到 Copilot Chat 的输入框中,配合下面的示例提示词进行练习。

### 1. `entity.png` — 数据库 ER 图生成建表脚本

这是一张数据库实体关系图(AdventureWorks 的 Person 模式)。粘贴图片后输入:

```text
create SQL script to implement the following database in MSSQL
```

(中文:`根据图中的数据库关系图,生成 MSSQL 建表脚本,包含主键、外键和索引`)

检查生成的脚本:表结构、字段类型、主键/外键关系是否与图中一致。

### 2. `arch.png` — 架构图解读与部署配置

这是一张 Azure Kubernetes Service(AKS)的系统架构图。粘贴图片后输入:

```text
解释这张架构图中各组件的作用和数据流向,并生成对应的 Kubernetes 部署 YAML 示例
```

进一步追问:`这个架构在安全性和可用性方面有哪些可以改进的地方?`

### 3. `error.png` — 根据报错截图定位问题

这是一张 Python 运行时报错(Traceback)的终端截图。粘贴图片后输入:

```text
分析这个报错的原因,并给出修复建议和修复后的代码
```

观察 Copilot 能否从截图中识别出异常类型(`AttributeError: 'NoneType' object has no attribute 'split'`)、出错位置,并给出健壮的空值处理方案。

### 4. `web.png` — 根据 UI 截图生成前端页面

这是一张仓库管理系统首页的网页截图。粘贴图片后输入:

```text
根据这张截图生成对应的 HTML + CSS 页面,布局、导航栏和卡片样式尽量与截图一致
```

把生成的页面保存为 `index.html`,在浏览器中打开,对比与截图的相似度,再通过多轮追问让 Copilot 调整细节。

**预期结果**: Copilot 能准确识别图片中的实体关系、架构组件、报错信息和页面布局,分别生成可执行的 SQL 脚本、部署配置、Bug 修复方案和前端页面代码。

---

## 场景 10: 网页抓取与总结(web-fetch)

**目录**: `scenarios/web-fetch`

让 Copilot 抓取网页内容并结合最新资料回答问题,提示词可参考该目录下的 `prompt.md`。

1. 在 Copilot Chat 中输入:

   ```text
   fetch https://modelcontextprotocol.io/introduction and summarize
   ```

   (中文:`获取 https://modelcontextprotocol.io/introduction 的内容并总结`)

2. 再尝试结合网页内容生成代码:

   ```text
   fetch https://learn.microsoft.com/en-us/entra/identity-platform/v2-oauth2-auth-code-flow , and write sample code to use oauth2 for entra id
   ```

   (中文:`获取 https://learn.microsoft.com/en-us/entra/identity-platform/v2-oauth2-auth-code-flow 的内容,并编写使用 OAuth2 授权码流程接入 Entra ID 的示例代码`)

3. 观察 Copilot 是否引用了网页中的关键信息(如端点 URL、参数说明)

**预期结果**: Copilot 抓取指定网页并给出准确摘要,生成的示例代码与官方文档中的流程和参数保持一致。
