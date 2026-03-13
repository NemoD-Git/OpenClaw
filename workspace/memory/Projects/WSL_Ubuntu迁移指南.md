# WSL Ubuntu 从 C 盘迁移到 D 盘指南

**文档版本：2026.03.13**

---

## 一、迁移方法选择

### 方法对比

| 方法 | 优点 | 缺点 | 适用场景 |
|------|------|------|----------|
| **wsl --export/import** (推荐) | 官方方法，安全可靠 | 需要停机操作 | 所有用户 |
| **wsl --manage --move** (最新) | 最简单，一行命令 | 需要 WSL 2.3.11+ | WSL版本较新的用户 |

---

## 二、操作步骤（方法一：export/import）

### 步骤 1：检查当前状态

在 **Windows PowerShell** 或 **CMD** 中执行：

```powershell
# 查看当前 WSL 列表
wsl --list -v

# 查看 Ubuntu 占用的空间
Get-AppxPackage -Name "*Ubuntu*" | Select PackageFamilyName
```

### 步骤 2：停止 WSL

```powershell
# 停止正在运行的 Ubuntu（如果正在运行）
wsl -t Ubuntu

# 或者停止所有 WSL
wsl --shutdown
```

### 步骤 3：导出 WSL（备份）

```powershell
# 创建备份目录
mkdir D:\wsl_backup

# 导出 Ubuntu 到 D 盘
wsl --export Ubuntu D:\wsl_backup\ubuntu.tar
```

> ⏱️ 导出时间取决于 Ubuntu 的大小，可能需要 10-30 分钟

### 步骤 4：注销原 WSL

```powershell
# 注销原来的 Ubuntu（这会删除 C 盘上的数据）
wsl --unregister Ubuntu
```

⚠️ **注意：此步骤不可逆，确保第3步导出完成后再执行！**

### 步骤 5：导入到 D 盘

```powershell
# 创建目标目录
mkdir D:\wsl\Ubuntu

# 导入并指定为 WSL 2
wsl --import Ubuntu D:\wsl\Ubuntu D:\wsl_backup\ubuntu.tar --version 2
```

### 步骤 6：设置默认用户

```powershell
# 查看系统中的用户
ubuntu config --default-user 你的用户名
```

### 步骤 7：验证

```powershell
# 验证是否成功
wsl --list -v

# 启动测试
wsl
```

---

## 三、操作步骤（方法二：新版本内置命令）

如果你的 WSL 版本 >= 2.3.11，可以使用更简单的方法：

```powershell
# 查看当前 WSL 版本
wsl --version

# 直接移动（推荐）
wsl --manage Ubuntu --move D:\wsl\Ubuntu
```

> 📎 来源：Reddit (2025年1月)
> https://www.reddit.com/r/wsl2/comments/1i3awjz/move_wsl2_distribution_to_another_drive/

---

## 四、对已有软件的影响

### ✅ 不受影响

| 软件/配置 | 影响 | 说明 |
|----------|------|------|
| **VS Code (Cloud Code)** | 无影响 | 只要 WSL 迁移后能正常运行，Cloud Code 继续可用 |
| **OpenClaw** | 无影响 | 配置文件在用户目录，迁移后重新配置路径即可 |
| **npm/node 全局包** | 无影响 | 跟随系统用户目录 |
| **SSH 密钥** | 无影响 | 在 ~/.ssh 目录下 |

### ⚠️ 需要重新配置

| 项目 | 说明 |
|------|------|
| **WSLg (图形界面)** | 可能需要重新安装驱动 |
| **VS Code Remote 插件** | 可能需要重新连接 |
| **Windows  Terminal 配置** | 可能需要重新添加 |

---

## 五、注意事项

### ⚠️ 重要提醒

1. **备份！** 迁移前确保重要数据已备份
2. **停机时间** 迁移过程中 WSL 将不可用
3. **磁盘空间** D 盘需要有足够的空间（至少等于当前 Ubuntu 大小）
4. **路径不要有中文** 避免路径问题
5. **关闭所有 WSL 实例** 迁移前确保没有 WSL 在运行

### 📋 迁移前检查清单

- [ ] 重要文件已备份
- [ ] D 盘空间充足
- [ ] 记录当前用户名
- [ ] 记录已安装的软件列表（可选）
- [ ] 关闭所有 WSL 实例

---

## 六、参考文献

1. **GitHub - WSL迁移官方指南**
   https://github.com/LpCodes/Moving-WSL-Distribution-to-Another-Drive

2. **Super User - WSL2迁移**
   https://superuser.com/questions/1550622/move-wsl2-file-system-to-another-drive

3. **Windows OS Hub - WSL迁移教程**
   https://woshub.com/move-wsl-another-drive-windows/

4. **Reddit - WSL2新版本移动命令**
   https://www.reddit.com/r/wsl2/comments/1i3awjz/move_wsl2_distribution_to_another_drive/

5. **ShareUs - 3种方法移动WSL**
   https://www.shareus.com/computer/3-ways-to-move-wsl-distro-to-another-drive.html

---

## 七、迁移后的建议

1. **更新 VS Code Remote** - 重新连接 WSL
2. **测试 OpenClaw** - 确认 Gateway 正常运行
3. **清理 C 盘** - 迁移完成后可删除 C 盘的旧文件

---

*本指南基于 2024-2025 年最新实践整理*
