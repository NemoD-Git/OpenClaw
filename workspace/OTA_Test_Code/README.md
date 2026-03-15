# OTA 测试代码包使用指南

## 📁 代码包位置

```
OTA_Test_Code/
├── rssd/                      # R&S Python SCPI驱动库 (主仓库)
│   └── rssd/
│       ├── examples/           # 测试脚本 (58个示例)
│       │   ├── VSA_*.py       # 频谱分析仪测试
│       │   ├── VSG_*.py       # 信号源测试
│       │   ├── VST_*.py       # 完整收发测试
│       │   └── 5GNR_*.py      # 5G NR测试
│       ├── OTA/               # OTA暗室驱动
│       │   ├── ATS1000.py     # R&S ATS1000转台控制
│       │   └── ATS1800.py     # R&S ATS1800转台控制
│       └── NRP/               # 功率计驱动
```

## 🚀 快速开始

### 1. 安装依赖
```bash
cd OTA_Test_Code/rssd
pip install -e .
```

### 2. 修改仪器IP
编辑测试脚本，开头的IP配置:
```python
SMW_IP = '192.168.1.114'  # 信号源
FSW_IP = '192.168.1.109'  # 频谱仪
```

### 3. 运行示例
```bash
# ACLR测试
python rssd/examples/VSA_ACLR_Timing.py

# 5G NR EVM测试  
python rssd/examples/5GNR_SMW_CMP_FSW_EVM.py
```

## 📊 常用测试脚本

| 测试项 | 脚本 | 说明 |
|--------|------|------|
| **ACLR** | `VSA_ACLR_Timing.py` | 邻道泄漏比 |
| **EVM** | `5GNR_SMW_CMP_FSW_EVM.py` | 5G NR EVM |
| **CCDF** | `VSA_CCDF.py` | 互补累积分布函数 |
| **5G NR** | `VST_NR5G_EVM.py` | 5G NR收发测试 |
| **功率扫描** | `VSG_Power_Sensor_Sweep.py` | 功率vs频率 |
| **WLAN EVM** | `VST_WLAN_EVM.py` | WLAN EVM测试 |

## 📋 环境要求

- Python 3.7+
- 网络连接仪器的VISA驱动 (pyvisa-py 或 NI-VISA)
- 仪器: R&S FSW, SMW, NRP等

## 🔧 常用仪器默认IP

| 仪器 | 默认IP |
|------|--------|
| R&S FSW | 192.168.1.1 |
| R&S SMW | 192.168.1.2 |
| R&S NRP | 192.168.1.20 |

---
更多信息见: `memory/通信设备OTA测试Python代码汇总.md`
