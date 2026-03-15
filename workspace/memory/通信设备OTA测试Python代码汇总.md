# 📡 通信设备 OTA 测试 Python 代码汇总

> 整理日期: 2026-03-14
> 来源: GitHub, PyPI, 各仪器厂商

---

## ⭐ 主流仪器驱动库

### 1. rssd - R&S SCPI 驱动 (最推荐)
- **安装**: `pip install rssd`
- **GitHub**: https://github.com/mclim9/rssd
- **支持仪器**: FSW, VSA, VSG, VSE, NRP, OSP, VNA, NRQ
- **示例代码目录**: rssd/examples/

#### 关键测试脚本:

| 文件名 | 仪器 | 测试项 |
|--------|------|--------|
| FSW_ACLR_Timing.py | VSA | ACLR (频谱模式) |
| FSW_ACLR_IQ_Timing.py | VSA | ACLR (IQ分析模式) |
| FSW_CCDF.py | VSA | CCDF |
| FSW_IQCaptureTime.py | VSA | IQ捕获时间 |
| VSE_OFDM_1CC_K96.py | VSE | 单载波OFDM EVM (K96) |
| VSE_OFDM_MultiCC_K96.py | VSE | 多载波OFDM EVM |
| VST_5GNR_EVM.py | VSG+VSA | 5G NR EVM |
| VST_5GNR_K144_Read.py | VSG+VSA | 5G NR参数读取 |
| VST_WLAN_EVM.py | VSG+VSA | WLAN EVM扫描 |
| VST_Sweep.py | VSG+VSA | 频率扫描 |
| NRP_AvgPwr.py | NRP | 平均功率 |
| NRP_BufferedContAvg.py | NRP | 缓冲连续平均功率 |
| SMW_LoadArb.py | VSG | 加载Arb文件 |

---

### 2. PyMeasRF - 通用射频测量库
- **GitHub**: https://github.com/JAnderson419/PyMeasRF
- **安装**: `pip install PyMeasRF`
- **支持仪器**:
  - Keithley 2400 SMU - 电压源和测量
  - Keysight N5245A PNA-X - S参数测量
  - Keysight N9030A PXA - 信号分析
  - Keysight 33220A - 任意波形发生器

---

### 3. PyVISA - 通用仪器控制
- **官网**: https://pyvisa.readthedocs.io
- **安装**: `pip install pyvisa pyvisa-py`
- **说明**: 通用VISA库，支持GPIB/网口/USB控制各种仪器

---

### 4. RsInstrument - R&S官方Python驱动
- **GitHub**: https://github.com/Rohde-Schwarz/RsInstrument
- **文档**: https://rohde-schwarz.github.io/RsInstrument_PythonDocumentation/
- **PyPI**: `pip install RsInstrument`

---

## 📊 测试项对应代码

### 功率测量 (Power)
- `rssd/examples/FSW_*` - R&S频谱仪功率测量
- `PyMeasRF` - NRP功率传感器控制

### P1dB压缩点
- 使用 `RsInstrument` 或 `rssd` 配合功率扫描
- 参考: `rssd/examples` 中的功率扫描示例

### ACLR (邻道泄漏比)
- `rssd/examples/FSW_ACLR_Timing.py` ⭐
- `rssd/examples/FSW_ACLR_IQ_Timing.py`

### EVM (误差矢量幅度)
- `rssd/examples/VSE_OFDM_1CC_K96.py` - 5G NR EVM
- `rssd/examples/VST_5GNR_EVM.py` - 5G NR EVM (完整链路)
- `rssd/examples/VST_WLAN_EVM.py` - WLAN EVM
- MATLAB: https://www.mathworks.com/help/5g/ug/evm-measurement-of-5g-nr-downlink-waveforms.html

### 5G NR测试
- `rssd/examples/VST_5GNR_EVM.py`
- `rssd/examples/VST_5GNR_K144_Read.py`
- R&S Application Note: GFM313_3e_5G_NR_BaseStation_Tx_Tests.pdf

### S参数测量
- `PyMeasRF` - Keysight PNA-X驱动

### 天线/OTA测试
- **MilliBox**: https://millibox.org
  - 提供Python源码控制天线转台
  - 输出CSV格式的3D方向图数据

---

## 🛠️ 快速开始

### 安装依赖
```bash
pip install rssd
pip install pyvisa pyvisa-py
pip install RsInstrument  # 可选官方驱动
```

### 基本使用示例
```python
# ACLR测量示例 (rssd)
from rssd.VSA import VSA

fsw = VSA().open('192.168.1.1')
fsw.init_ACLR()
result = fsw.measure_ACLR()
print(f"ACLR: {result}")
```

---

## 📁 代码获取方式

1. **GitHub克隆完整示例**:
   ```bash
   # rssd示例
   pip install rssd
   python -c "import rssd; print(rssd.__path__)"
   ```

2. **直接下载**:
   - rssd: https://github.com/mclim9/rssd
   - PyMeasRF: https://github.com/JAnderson419/PyMeasRF

---

## 🔧 常用仪器IP (示例)

| 仪器 | 默认IP |
|------|--------|
| R&S FSW | 192.168.1.1 |
| R&S SMW | 192.168.1.2 |
| Keysight N9030A | 192.168.1.10 |
| R&S NRP | 192.168.1.20 |

---

## 📝 注意事项

1. **rssd库API可能会变化**，生产环境建议锁定版本:
   ```bash
   pip freeze > requirements.txt
   ```

2. **VISA驱动选择**:
   - Windows: NI-VISA
   - Linux/macOS: pyvisa-py (开源)

3. **GPIB控制**: 需要GPIB-网口转换器 (如Keysight E5810B)

---

*持续更新中...*
