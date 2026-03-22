# 🛰️ Network Traffic & Telemetry Flow

This document details the bidirectional traffic routing between the Hub and Spokes, as well as the Telemetry Pipeline streaming data to Microsoft Sentinel.

![Network Flow Diagram](../screenshots/architecture/network-flow-diagram.png)

---

## 🚦 Traffic Flow Analysis

| Traffic Type | Pathway | Security Control |
| :--- | :--- | :--- |
| **Ingress (Internet to App)** | External ➔ Hub ➔ Spoke 02 | Traffic hits the Hub perimeter first. No direct public internet access is permitted on the Spoke workloads. |
| **Lateral Movement (East-West)** | Spoke 03 (Client) ➔ Hub ➔ Spoke 02 (App) | To move from the test client to the application server, traffic must traverse VNet Peering through the Hub transit. |
| **Telemetry Pipeline (South-North)** | Spoke Workloads ➔ Azure Monitor Agent ➔ Hub LAW | Standard Event logs (such as Audit Failure 4625) bypass local persistence and stream directly via the AMA to the central Log Analytics Workspace. |

---

## 🛡️ Zero-Trust Design Validation

By forcing East-West traffic (lateral movement between Spoke 02 and Spoke 03) through the Hub, we establish a deterministic chokepoint. This ensures that an adversary cannot pivot between workloads without crossing a monitored boundary.
