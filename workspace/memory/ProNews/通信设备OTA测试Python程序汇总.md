# 通信设备空口（OTA）测试 Python 程序汇总

**整理日期：2026年3月13日**

---

## 一、概述

本文档汇总了业界经过实践检验的通信设备空口（Over-The-Air, OTA）测试 Python 程序，重点关注网口/GPIB 接口的测试方案，涵盖功率、P1dB、ACLR、EVM 等关键测试项。

---

## 二、主流仪器厂商 Python 驱动

### 2.1 Rohde & Schwarz

| 库/工具 | 描述 | 接口 | 链接 |
|---------|------|------|------|
| **RsInstrument** | 官方 SCPI 驱动，支持几乎所有 R&S 仪器 | TCP/IP, GPIB, USB | https://github.com/Rohde-Schwarz/RsInstrument |
| **rssd** | 社区维护的 R&S SCPI 驱动 | TCP/IP, GPIB | https://github.com/mclim9/rssd |
| **rs_fsl** | R&S FSL 频谱分析仪 Python 接口 | TCP/IP | https://github.com/bleykauf/rs_fsl |

> 来源：GitHub, R&S 官方文档
> https://rsinstrument.readthedocs.io/en/latest/

---

### 2.2 Keysight (原 Agilent)

| 库/工具 | 描述 | 接口 | 链接 |
|---------|------|------|------|
| **PyArbTools** | Keysight 信号源波形创建与控制 | TCP/IP, GPIB, USB | https://github.com/morgan-at-keysight/pyarbtools |
| **PyMeasRF** | RF 器件测量模块（功率、EVM等） | TCP/IP, GPIB | https://github.com/JAnderson419/PyMeasRF |
| **rssd (RS 兼容)** | 也支持部分 Keysight 仪器 | TCP/IP, GPIB | https://github.com/mclim9/rssd |

> 来源：Keysight GitHub, PyPI

---

### 2.3 其他厂商

| 库/工具 | 描述 | 接口 | 链接 |
|---------|------|------|------|
| **PyVISA** | 通用仪器控制框架（支持 GPIB/网口/USB） | GPIB, TCP/IP, USB | https://pyvisa.readthedocs.io/ |
| **PyVISA-py** | 纯 Python VISA 实现 | GPIB, TCP/IP, USB | https://github.com/pyvisa/pyvisa-py |
| **pymeasure** | 开源仪器控制框架 | TCP/IP, GPIB, USB | https://github.com/pymeasure/pymeasure |

> 来源：PyVISA 官方文档

---

## 三、测试项专用程序

### 3.1 功率测量

| 程序/库 | 描述 | 测试项 | 接口 | 链接 |
|---------|------|--------|------|------|
| **rssd.FSW** | R&S FSW 频谱仪功率测量 | 功率、ACLR | TCP/IP, GPIB | https://github.com/mclim9/rssd |
| **Mini-Circuits USB 功率计** | 功率传感器控制 | 输出功率 | USB | https://blog.minicircuits.com/rf-amplifier-and-filter-testing-with-mini-circuits-power-sensors/ |
| **PyMeasRF** | RF 器件功率测量 | 功率扫描 | TCP/IP, GPIB | https://github.com/JAnderson419/PyMeasRF |

> 来源：Mini-Circuits Blog (2024年11月)

---

### 3.2 P1dB 压缩点测量

| 程序/库 | 描述 | 测试项 | 接口 | 链接 |
|---------|------|--------|------|------|
| **PyMeasRF** | 功率扫描测量 P1dB | P1dB | TCP/IP, GPIB | https://github.com/JAnderson419/PyMeasRF |
| **python-rfdesigner** | RF 系统级联分析，可设置 P1dB 参数 | 功率预算分析 | N/A | https://github.com/fronzbot/python-rfdesigner |
| **Mini-Circuits 测试方案** | P1dB 自动测量 | P1dB | USB | https://blog.minicircuits.com/rf-signal-quality-measurements-third-order-intercept-point-ip3-and-power-at-1-db-compression-p1db/ |

> 来源：Mini-Circuits Blog (2025年11月)

---

### 3.3 ACLR（邻道功率泄漏比）测量

| 程序/库 | 描述 | 测试项 | 接口 | 链接 |
|---------|------|--------|------|------|
| **rssd.FSW_ACLR** | R&S FSW ACLR 测量 | ACLR | TCP/IP, GPIB | https://github.com/mclim9/rssd |
| **rssd.FSW_ACLR_IQ_Timing** | IQ 分析仪模式 ACLR | ACLR | TCP/IP, GPIB | https://pypi.org/project/rssd/ |
| **PyMeasRF** | 支持 ACLR 测量 | ACLR | TCP/IP, GPIB | https://github.com/JAnderson419/PyMeasRF |

> 来源：PyPI rssd 文档

---

### 3.4 EVM（误差矢量幅度）测量

| 程序/库 | 描述 | 测试项 | 接口 | 链接 |
|---------|------|--------|------|------|
| **rssd.VSE_OFDM** | R&S VSE OFDM EVM 测量 | EVM (5G NR, LTE, WiFi) | TCP/IP, GPIB | https://pypi.org/project/rssd/ |
| **rssd.VST_5GNR_EVMSpeed** | 5G NR EVM 速度测试 | 5G NR EVM | TCP/IP, GPIB | https://pypi.org/project/rssd/ |
| **EVM-trace-analyzer** | EVM 轨迹分析 | EVM 后处理分析 | N/A | https://github.com/hwfrog/EVM-trace-analyzer |
| **PyMeasRF** | 支持多种 EVM 测量 | EVM | TCP/IP, GPIB | https://github.com/JAnderson419/PyMeasRF |

> 来源：GitHub, PyPI

---

### 3.5 5G NR / WiFi 测试

| 程序/库 | 描述 | 测试项 | 接口 | 链接 |
|---------|------|--------|------|------|
| **py3gpp** | 5G NR 仿真库 | 波形生成 | N/A | https://github.com/catkira/py3gpp |
| **toolkit5G** | 5G 工具箱 | 链路仿真、EVM 计算 | N/A | https://gigayasawireless.github.io/toolkit5G/ |
| **Red Pitaya** | 信号发生器/矢量分析 | 基础 OTA 测试 | 网口 | https://gist.github.com/geggo/baf1b9b804056c1766a39cca50c16e95 |

> 来源：GitHub, 5G-Toolkit 文档

---

## 四、综合测试方案

### 4.1 典型测试系统架构

```
[Python PC] ←→ [网口/GPIB] ←→ [信号源] → [DUT] → [频谱仪/VSA] ←→ [Python PC]
                          ↑                                       ↓
                     [功率计] ←─────────────────────────────────┘
```

### 4.2 推荐的测试流程库

| 用途 | 推荐库 | 说明 |
|------|--------|------|
| 仪器控制 | RsInstrument / PyVISA | 底层通信 |
| 功率测量 | rssd / PyMeasRF | 包含 ACLR、EVM |
| 数据处理 | NumPy, SciPy | 信号分析 |
| 自动化测试 | pytest, LabVIEW | 测试框架 |

---

## 五、PyPI 综合测试库

| 库名 | 功能 | 链接 |
|------|------|------|
| **rssd** | R&S 仪器综合驱动（功率、ACLR、EVM） | https://pypi.org/project/rssd/ |
| **pyarbtools** | Keysight 信号源控制 | https://github.com/morgan-at-keysight/pyarbtools |
| **PyMeasRF** | RF 器件综合测量 | https://github.com/JAnderson419/PyMeasRF |
| **pymeasure** | 通用仪器自动化 | https://github.com/pymeasure/pymeasure |

---

## 六、参考资料

### 6.1 官方文档

1. **RsInstrument Python 官方指南**
   https://rsinstrument.readthedocs.io/en/latest/StepByStepGuide.html

2. **Keysight Python 自动化入门**
   https://docs.keysight.com/kkbopen/getting-started-automate-keysight-instruments-using-python-3-9-845872587.html

3. **R&S GitHub 示例**
   https://github.com/Rohde-Schwarz/RsInstrument

### 6.2 技术博客

1. **Mini-Circuits RF 放大器测试**
   https://blog.minicircuits.com/rf-amplifier-and-filter-testing-with-mini-circuits-power-sensors/

2. **Mini-Circuits P1dB & IP3 测量**
   https://blog.minicircuits.com/rf-signal-quality-measurements-third-order-intercept-point-ip3-and-power-at-1-db-compression-p1db/

3. **Keysight 5G NR OTA 测试**
   https://www.keysight.com/blogs/en/inds/2019/09/30/overcoming-5g-nr-mmwave-signal-quality-challenges

### 6.3 GitHub 资源

1. **Rohde-Schwarz/RsInstrument**
   https://github.com/Rohde-Schwarz/RsInstrument

2. **mclim9/rssd**
   https://github.com/mclim9/rssd

3. **JAnderson419/PyMeasRF**
   https://github.com/JAnderson419/PyMeasRF

4. **morgan-at-keysight/pyarbtools**
   https://github.com/morgan-at-keysight/pyarbtools

---

## 七、注意事项

1. **接口选择**：
   - GPIB：经典稳定，但需要 GPIB 卡
   - 网口（TCP/IP）：现代主流，推荐使用
   - USB：便携，但距离受限

2. **VISA 库**：建议安装 PyVISA 或 PyVISA-py 作为统一通信层

3. **仪器兼容性**：部分高级功能（如 5G NR EVM）需要授权license

---

*本汇总基于2024-2026年公开资料整理，具体使用请参考各库官方文档。*
