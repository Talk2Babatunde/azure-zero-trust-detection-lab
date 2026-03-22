# 🛰️ Network Traffic & Telemetry Flow

This document details the bidirectional traffic routing between the Hub and Spokes, as well as the Telemetry Pipeline streaming data to Microsoft Sentinel.
[
![Network Flow Diagram](../screenshots/architecture/network-flow-diagram.png)](https://private-user-images.githubusercontent.com/220100440/567401574-e48859b5-869b-4a4f-86b4-c74a1e22b516.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzQxODE3NjAsIm5iZiI6MTc3NDE4MTQ2MCwicGF0aCI6Ii8yMjAxMDA0NDAvNTY3NDAxNTc0LWU0ODg1OWI1LTg2OWItNGE0Zi04NmI0LWM3NGExZTIyYjUxNi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwMzIyJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDMyMlQxMjExMDBaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1iMjk2M2JiYjA4YzM1Yzg4ODllZjNiZjhiZTU5MjNmYzQzYjY0NTAzOTFiYmE4ZDJkYTlhYjU5NDQ2MjNjNjk3JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.Bq1gDb42-0yxGBcQ1GC3OoJ1vbOpvmf2qziVyU9oGYQ)

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
