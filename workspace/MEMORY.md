# MEMORY.md - 长期记忆

> 最后更新：2026-03-23

## 身份

- 名字：**sihq**（2026-03-27 由 Nemo 命名）
- AI助手，通信/RF专业背景
- 务实、高效、直接

## 关于Nemo

- 通信工程师（射频/微波/天线）
- WSL2 Ubuntu + VSCode + OpenClaw
- 喜欢动手折腾、追求效率
- 偏好直截了当的沟通方式

## 技术积累

### Speculative Decoding（推测解码）— 深度理解 ⭐
详见 `memory/2026-03-23.md`

### Mixture of Experts（MoE）架构 — 深度理解 ⭐
详见 `memory/2026-03-24.md`

**核心洞见**：MoE = Router（调度器）+ Expert（资源单元）+ 稀疏激活。本质是把"知识容量"和"推理成本"解耦，和通信系统的资源管理（调度器/资源块分配）高度同构。关键问题：专家坍缩、负载均衡、细粒度专家+共享专家隔离。

### AI/ML 在 RF/天线设计中的应用 — 深度理解 ⭐
详见 `memory/2026-03-25.md`

**核心洞见**：AI+RF 的本质是代理模型（降低仿真成本）+ 多目标优化（处理耦合参数空间）+ 端到端设计生成。对通信工程师最有价值的方向：PA 行为建模（宽带信号 EVM/ACLR 预测）、OTA 测量效率提升（主动学习减少测量点）、毫米波阵列波束优化。RF 工程师的竞争优势 = 懂物理 + 会用 ML 工具，而非单纯被替代。

### 已学习的技能

- node-connect: 配对失败排查
- feishu全系列: 云文档/知识库/多维表格
- weather: 天气查询
- oracle: prompt bundling
- self-improvement: 持续改进框架
- academic-deep-research: 深度研究方法论
- find-skills / clawhub: 技能管理

## 工具配置

- 搜索: ~/.openclaw/search.sh (Tavily) + Brave web_search备用
- TTS: sag (ElevenLabs)
- Feishu: 已配置全量权限

## 正在进行的任务

### 相控阵天线培训PPT（进行中）
- 来源报告：相控阵天线研究报告 V305（最新）
- 输出：26页PPT，培训时长约60分钟
- 位置：~/.openclaw/workspace/reports/ppt_output/
- 定时打磨：每5小时基于最新报告自动更新
- 结束时间：2026-04-10 09:00（自动停止）
- Cron ID: f5fddb25-6e3f-4bb9-acd0-77e3e784c514

## 关键决策记录

- (持续更新)
