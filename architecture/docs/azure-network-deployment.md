# 03 - Azure Network Deployment: Infrastructure Configuration

## 🌐 Network Segmentation Strategy
The infrastructure was deployed across three Virtual Networks (VNets) with non-overlapping address spaces. This ensures that routing can be managed centrally and that we have a clean environment for monitoring inter-VNet traffic.

### VNet Configuration Table
| VNet Name | Address Space | Subnet Name | Subnet Range | Role |
| :--- | :--- | :--- | :--- | :--- |
| **vnet-hub-security** | 10.0.0.0/16 | snet-hub-mgmt | 10.0.1.0/24 | Centralized Security (Sentinel/LAW) |
| **vnet-spoke-app** | 10.1.0.0/16 | snet-app-prod | 10.1.1.0/24 | Public-Facing Workload (Target 1) |
| **vnet-spoke-client** | 10.2.0.0/16 | snet-client-int | 10.2.1.0/24 | Internal User Simulation (Target 2) |

Figure 5 — VNet peering configuration enabling communication between hub and spoke networks.
---

## 🔗 VNet Peering & Routing
To enable the "Hub-and-Spoke" model, **Virtual Network Peering** was established between the Hub and each Spoke. 

- **Hub to Spoke-App:** Bi-directional peering to allow telemetry to flow from the app to the Log Analytics Workspace.
- **Hub to Spoke-Client:** Bi-directional peering for management and log ingestion.
- **Spoke-to-Spoke:** Communication is **disabled**. This enforces a Zero-Trust boundary where Spokes cannot talk to each other directly, preventing lateral movement that bypasses the Hub.

---

## 🛡️ Network Security Groups (NSG)
Each VNet is protected by an NSG acting as a stateful firewall. For this lab, I specifically configured:
* **Allow RDP (3389):** Restricted to specific source IPs to simulate a management entry point (and to provide an attack surface for the brute-force simulation).
* **Allow Outbound (Log Ingestion):** Ensuring the Azure Monitor Agent (AMA) can communicate with the Hub's Log Analytics Workspace on Port 443 (HTTPS).

---

## 🚀 Implementation Steps
1. **VNet Creation:** Scripted the deployment of all three VNets using the Azure Portal/CLI.
2. **Subnetting:** Segmented each VNet to allow for future scalability (e.g., adding a dedicated Database subnet).
3. **Peering Setup:** Configured peering with "Allow Forwarded Traffic" settings to simulate a transit hub environment.

Figure 4 — Creation of virtual networks in Azure representing the hub and two spoke environments.

---
*Next Step: Proceed to [04-Centralized Logging](./04-centralized-logging.md) to see how telemetry is captured across these networks.*