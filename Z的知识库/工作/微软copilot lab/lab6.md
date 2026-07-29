# Lab 6: 使用 GitHub Copilot SDK 构建 PPT 生成网站

## 实验目标

本实验将综合运用前两个实验的成果：

- 复用 Lab 4 中完成的 PPT 内容生成、审查和最终文件生成工作流
- 使用 Lab 5 中学习的 Superpowers 软件开发流程设计、规划和实现网站
- 使用 GitHub Copilot SDK 在后端运行 Agent 工作流
- 构建一个前后端分离的网站，让用户通过对话描述 PPT 内容并可以下载生成结果

完成本实验后，你将能够：

- 理解 GitHub Copilot SDK 的基本架构与核心对象
- 将 Skill、Custom Agent 和文件生成能力嵌入应用程序
- 设计前后端分离的 Agent 应用
- 使用 Superpowers 完成需求澄清、实施规划、TDD 开发和最终验证

> ⚠️ **模型提示**：GitHub Copilot SDK 属于更新较快的 Agent 框架。建议使用较新的前沿模型，避免模型因训练数据较旧而虚构已经变更的类、方法或配置。

---

## GitHub Copilot SDK 简介

[GitHub Copilot SDK](https://github.com/github/copilot-sdk) 用于把 GitHub Copilot Agent 的能力嵌入应用和服务。应用不需要自行实现完整的 Agent 循环；SDK 可以复用 Copilot CLI 背后的 Agent Runtime，处理模型交互、规划、工具调用、文件操作、会话和事件等能力。

它支持 TypeScript/Node.js、Python、Go、.NET、Java 和 Rust。本实验建议后端使用 TypeScript/Node.js，因为它可以与前端共享类型，并且官方包 `@github/copilot-sdk` 会自动携带所需的 Copilot CLI 运行时。

其基本架构可以理解为：

```text
PPT 网站后端
  ↓
SDK Client
  ↓ JSON-RPC
Copilot CLI Agent Runtime
  ↓
模型、Skill、Custom Agent 与工具
```

在 TypeScript SDK 中，建议重点理解以下概念：

- `CopilotClient`：管理 Agent Runtime 的连接与生命周期
- `CopilotSession`：代表一次可持续多轮交互的 Agent 会话
- `createSession()`：配置模型、Skill、Custom Agent、工具和权限策略
- `send()` / `sendAndWait()`：向会话发送用户要求
- `session.on(...)`：订阅流式回复、工具执行、空闲和子 Agent 等事件
- `defineTool()`：把应用自身的受控能力暴露给 Agent
- `skillDirectories`：让会话加载指定目录中的 Skill
- `customAgents`：向会话注册有独立提示词和工具范围的专用 Agent
- `onPermissionRequest`：决定文件、命令、网络或自定义工具调用能否执行
- `disconnect()` / `stop()`：释放会话和 Client 资源


### 开发前的理解练习

先在 GitHub Copilot Chat 中输入：

```text
请根据 https://github.com/github/copilot-sdk 的最新文档，解释 GitHub Copilot SDK 的工作原理、Client 与 Session 的生命周期、消息和事件模型、Skill 与 Custom Agent 的加载方式，以及权限控制。
```

---

## 要构建的网站

你要创建一个前后端分离的 PPT 生成网站。用户在前端输入演示目标和要求，后端使用 GitHub Copilot SDK 驱动 Lab 4 的工作流，最终返回可下载的 `.pptx` 文件。

整体流程应保持 Lab 4 中的质量闭环：

```text
用户在网页提交 PPT 要求
  ↓
后端创建生成任务与 Copilot Session
  ↓
内容生成 Skill 创建 PPT 内容文件
  ↓
Review Agent 审查分页、内容与叙事
  ↓
未通过 → 根据意见修改 → 再次审查
  ↓
通过后调用设计与 PPT 生成能力
  ↓
验证 PPT 文件并提供下载
```

网站至少应包含以下能力：

### 最低要求

- 一个对话式输入区域，用于填写 PPT 的目标、主题和具体要求
- 生成成功后提供 PPT 下载入口

可以进一步加入受众、页数、语言、风格、演讲时长和参考资料等结构化字段，但不要用表单限制自然语言对话的表达能力。

---
