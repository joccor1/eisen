# Lab 3: 进阶作业 — 与 GitHub Copilot 对话完成挑战

---

## 作业 1: 为本项目添加 AGENTS.md

**任务**: 在本仓库根目录创建一个 `AGENTS.md` 文件,并让它真正发挥作用。

**要求**:

- 通过与 Copilot 对话,搞清楚以下问题:
  - `AGENTS.md` 是什么?它和 `README.md`、`.github/copilot-instructions.md` 有什么区别?
  - AI 编码代理(如 Copilot)在什么时机会读取这个文件?它能带来什么价值?
  - 一个高质量的 `AGENTS.md` 通常包含哪些内容(项目结构说明、约定、常用命令等)?
- 结合本仓库的实际情况(labs 目录、scenarios 目录的用途),让 Copilot 帮你起草一份 `AGENTS.md`,再自己审阅和修改
- 完成后进行验证:向 Copilot 提出一个与项目结构相关的问题,观察它的回答是否利用了 `AGENTS.md` 中的信息

**提交物**: 仓库根目录的 `AGENTS.md` 文件,以及一段简短说明——你认为这个文件对 AI 辅助开发的最大价值是什么。

---

## 作业 2: 在 VS Code 中添加 MCP Server 并调用

**任务**: 了解 MCP(Model Context Protocol),在 VS Code 中配置至少一个 MCP Server,并在 Copilot Chat 中成功调用它提供的工具。

**要求**:

- 通过与 Copilot 对话,搞清楚以下问题:
  - MCP 是什么?它解决了什么问题?MCP Server 与 Copilot 的关系是什么?
  - VS Code 中配置 MCP Server 有哪几种方式(如 `mcp.json`、扩展市场安装)?
- 自选一个 MCP Server 完成配置,例如:
  - GitHub MCP Server(操作 issue、PR)
  - Playwright MCP Server(浏览器自动化)
  - 文件系统、时间等官方示例 Server
- 在 Copilot Chat 的 Agent 模式下发起一个会触发该 MCP Server 工具调用的请求,确认调用成功并观察返回结果

**提交物**: MCP Server 的配置内容(如 `mcp.json` 片段),以及一次成功调用的截图或对话记录。

---

## 作业 3: 在 VS Code 中添加 Plugin 并使用其中的 Skill

**任务**: 了解 Copilot 的 Plugin(插件)与 Skill(技能)机制,为你的 VS Code 安装一个 Plugin,并在对话中触发其中的 Skill。

**要求**:

- 通过与 Copilot 对话,搞清楚以下问题:
  - Copilot 的 Skill 是什么?它和 MCP Server 提供的工具有什么区别?
  - Plugin 是如何组织和分发 Skill 的?
  - Skill 是如何被触发的?`SKILL.md` 中的描述(description)起什么作用?
- 挑选并安装一个你感兴趣的 Plugin(例如包含文档处理、代码审查或效率工具类 Skill 的插件)
- 在 Copilot Chat 中用自然语言发起一个能触发该 Skill 的请求,确认 Skill 被正确加载和执行
- 思考:如果要为本仓库的实验场景编写一个自定义 Skill,你会怎么设计它的触发描述和内容?

**提交物**: 安装的 Plugin 名称、触发 Skill 的提示词与执行结果,以及你对自定义 Skill 的设计思路(几句话即可)。

---

## 作业 4: 为 GitHub Copilot 添加 Custom Agent

**任务**: 了解 Copilot 的 Custom Agent(自定义代理)机制,在 VS Code 中创建一个自定义 Agent,并理解它与 Skill 的使用场景差异。

**要求**:

- 通过与 Copilot 对话,搞清楚以下问题:
  - Custom Agent 是什么?`.agent.md` 文件放在哪里、包含哪些配置(如 description、tools、模型限制)?
  - 如何在 Copilot Chat 中切换或调用一个 Custom Agent(如 `@` 提及、Agent 下拉菜单)?
  - **Custom Agent 与 Skill 的使用场景有什么区别?** 例如:
    - Skill 是被动加载的领域知识,由对话内容自动触发;Agent 是一个可主动选择的"角色",可以限定工具集、系统提示和工作方式
    - 什么样的需求适合封装成 Skill(如某类文档的操作指南)?什么样的需求适合做成 Agent(如"代码审查员"、"只读探索者"这类固定工作流角色)?
- 动手创建一个与本仓库相关的 Custom Agent,例如一个"实验助教"Agent:熟悉 labs 和 scenarios 目录,只允许读取文件和回答问题,不允许修改代码
- 在 Copilot Chat 中调用你的 Agent,验证它按照定义的角色和限制工作

**提交物**: 你的 `.agent.md` 文件内容、一次调用效果的记录,以及一段简短总结——用你自己的话说明 Agent 与 Skill 各自适合什么场景。

---

## 作业 5: 为 GitHub Copilot 添加 Hook

**任务**: 了解 Copilot 的 Hook(钩子)机制,在 VS Code 中配置至少一个 Hook,并观察它在会话中的实际效果。

**要求**:

- 通过与 Copilot 对话,搞清楚以下问题:
  - Hook 是什么?它在 Copilot 的工作流中的哪些时机被触发(如会话开始、工具调用前后、提交前)?
  - Hook 的配置文件放在哪里?如何定义触发条件和要执行的命令?
  - Hook 适合哪些场景?例如:工具调用前做安全检查、编辑文件后自动运行格式化或测试、阻止对敏感文件的修改
- 动手配置一个简单的 Hook,例如:
  - 在每次编辑文件后自动运行 lint 或格式化
  - 在工具调用前记录日志,或阻止对某个目录的写入
- 触发该 Hook 并观察效果,确认它按预期执行

**提交物**: Hook 的配置内容、触发效果的记录,以及你认为 Hook 在团队协作中最有价值的一个应用场景。

---

