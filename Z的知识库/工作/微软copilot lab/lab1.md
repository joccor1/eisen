# Lab 1: 安装 VS Code、登录 GitHub 账号并初次使用 GitHub Copilot

## 实验目标

完成本实验后,你将能够:

- 在本地计算机上安装 Visual Studio Code
- 在 VS Code 中安装 GitHub Copilot 扩展
- 使用 GitHub 账号登录并激活 GitHub Copilot
- 在 Copilot Chat 中发出第一个聊天命令,确认 GitHub Copilot 可以正常使用

## 前置条件

- 一台可以联网的计算机(Windows、macOS 或 Linux)
- 一个 GitHub 账号(如果没有,请先前往 [https://github.com/signup](https://github.com/signup) 注册)
- GitHub 账号已开通 Copilot 访问权限(个人可使用 Copilot Free 免费计划,或订阅 Copilot Pro / 企业分配的 Copilot Business 席位)

---

## 步骤 1: 安装 Git 和 Node.js

后续实验会使用 Git 管理代码版本,并使用 Node.js 运行 JavaScript/TypeScript 项目和相关开发工具。

### 1. 安装 Git

根据你的操作系统选择安装方式:

- **Windows**: 访问 [https://git-scm.com/download/win](https://git-scm.com/download/win),下载安装程序并按默认选项完成安装
- **macOS**: 在终端运行 `xcode-select --install`,或从 [https://git-scm.com/download/mac](https://git-scm.com/download/mac) 选择安装方式
- **Linux**: 使用系统包管理器安装,例如 Ubuntu/Debian 运行 `sudo apt update && sudo apt install git`

安装完成后,重新打开终端并运行:

```text
git --version
```

如果终端显示 Git 版本号,说明安装成功。首次使用时可以继续配置提交身份:

```text
git config --global user.name "你的名字"
git config --global user.email "你的 GitHub 邮箱"
```

### 2. 安装 Node.js

访问 [https://nodejs.org/](https://nodejs.org/),下载并安装 **LTS(长期支持)** 版本。Node.js 安装程序会同时安装 npm 包管理器。

> 💡 **提示**: 如果需要在多个 Node.js 版本之间切换,可以使用版本管理工具,例如 Windows 上的 nvm-windows,或 macOS/Linux 上的 nvm。

安装完成后,重新打开终端并依次运行:

```text
node --version
npm --version
```

如果两个命令都能显示版本号,说明 Node.js 和 npm 已安装成功。安装 VS Code 后,还需要在 VS Code 的新终端中再次运行以上命令,确认其能够识别 Git、Node.js 和 npm。

## 步骤 2: 安装 Visual Studio Code

1. 打开浏览器,访问 VS Code 官方下载页面: [https://code.visualstudio.com/download](https://code.visualstudio.com/download)
2. 根据你的操作系统选择对应的安装包:
   - **Windows**: 下载 `User Installer (x64)` 版本
   - **macOS**: 下载 `.zip` 版本(区分 Intel 芯片与 Apple Silicon)
   - **Linux**: 下载 `.deb` 或 `.rpm` 包
3. 运行安装程序,按照向导完成安装:
   - Windows 用户建议勾选 **"添加到 PATH"** 和 **"通过 Code 打开"** 相关选项
4. 安装完成后启动 VS Code,确认可以看到欢迎页面

> 💡 **提示**: 如果需要中文界面,可以在扩展市场安装 `Chinese (Simplified) Language Pack` 扩展。

## 步骤 3: 安装 GitHub Copilot 扩展

1. 在 VS Code 左侧活动栏点击 **扩展** 图标(或按快捷键 `Ctrl+Shift+X`,macOS 为 `Cmd+Shift+X`)
2. 在搜索框中输入 `GitHub Copilot`
3. 找到由 **GitHub** 发布的 **GitHub Copilot** 扩展,点击 **Install(安装)**
   - 安装时会自动附带安装 **GitHub Copilot Chat** 扩展,提供聊天功能
4. 安装完成后,VS Code 右下角状态栏会出现 Copilot 图标

> 💡 **提示**: 最新版本的 VS Code 已内置 Copilot 入口,无需安装。

## 步骤 4: 登录 GitHub 账号并激活 Copilot

1. 安装扩展后,VS Code 右下角会弹出提示,要求登录 GitHub 账号;也可以点击右下角 **账户** 图标(头像),选择 **"Sign in with GitHub to use GitHub Copilot"**
2. 浏览器会自动打开 GitHub 授权页面:
   - 如果尚未登录 GitHub,先输入用户名和密码登录
   - 在授权页面点击 **Authorize Visual-Studio-Code(授权)**
3. 授权完成后,浏览器会提示返回 VS Code,点击 **打开 Visual Studio Code**
4. 回到 VS Code,确认登录成功:
   - 点击左下角 **账户** 图标,可以看到你的 GitHub 用户名
   - 状态栏中的 Copilot 图标不再显示错误标记

> ⚠️ **常见问题**:
>
> - 如果提示没有 Copilot 访问权限,请访问 [https://github.com/settings/copilot](https://github.com/settings/copilot) 检查并开通 Copilot(可选择免费的 Copilot Free 计划)。
> - 如果是企业账号,请联系管理员确认已为你分配 Copilot Business/Enterprise 席位。
> - 公司网络环境下如遇登录失败,请检查代理或防火墙设置。

## 步骤 5: 在 Copilot Chat 中发出第一个聊天命令

现在验证 GitHub Copilot 是否可以正常使用。

1. 打开 Copilot Chat 聊天面板,可以使用以下任意一种方式:
   - 按快捷键 `Ctrl+Alt+I`(macOS 为 `Cmd+Ctrl+I`)
   - 点击 VS Code 顶部标题栏中的 **Copilot 图标**,选择 **Open Chat**
2. 在聊天输入框中输入你的第一个命令,例如:

   ```text
   你好,请介绍一下你自己,你能帮我做什么?
   ```

3. 按回车发送,等待 Copilot 回复
4. 如果 Copilot 返回了自我介绍和功能说明,说明 GitHub Copilot 已经可以正常使用 🎉
5. 观察聊天对话框的功能，尝试使用不同模型进行问答

你还可以继续尝试以下命令,进一步体验 Copilot 的能力:

```text
用 Python 写一个判断素数的函数
```

```text
/help
```

> 💡 **提示**: 在聊天框中输入 `/` 可以查看内置的斜杠命令(如 `/explain`、`/fix`、`/tests` 等),输入 `@` 可以查看可用的聊天参与者(如 `@workspace`、`@terminal` 等)。
