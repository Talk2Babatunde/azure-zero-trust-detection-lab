# 02 - Architecture Design: Hub-and-Spoke Security Topology

## 🌐 The Design Philosophy
The lab environment utilizes a **Hub-and-Spoke topology**, the gold standard for enterprise cloud networking. This design enforces **Network Segmentation** and **Centralized Egress/Ingress**, which are core pillars of a Zero-Trust strategy.

---

## 🏛️ Component Breakdown

### 1. The Hub VNet (Security & Management)
The Hub acts as the "Central Nervous System" of the environment. By centralizing services here, we reduce the attack surface of the spokes and ensure a single point of truth for security telemetry.
* **Microsoft Sentinel:** The SIEM/SOAR platform providing the analytical layer.
* **Log Analytics Workspace (LAW):** The centralized repository where all Spoke logs are aggregated via Data Collection Rules (DCR).
* **Virtual Network Gateway:** Controls how external traffic (Internet/VPN) enters the environment.

### 2. The Spoke VNets (Isolated Workloads)
Spokes are isolated "islands" that host specific business functions. They cannot communicate with each other directly; they must go through the Hub.
* **Spoke 1 (Prod-App-Tier):** Hosts the simulated public-facing server (the entry point for the attacker).
* **Spoke 2 (Internal-User-Tier):** Hosts the simulated internal workstation (the target for lateral movement).

---

## 🔒 Security Controls & Flow
To ensure "Visibility at Every Stage," the following controls were implemented:

| Control | Implementation | Purpose |
| :--- | :--- | :--- |
| **VNet Peering** | Non-transitive peering to the Hub | Prevents Spokes from talking to each other directly. |
| **Network Security Groups (NSG)** | Micro-segmentation | Restricts traffic to specific ports (e.g., 3389 for RDP) only from known sources. |
| **Centralized Logging** | Azure Monitor Agent (AMA) | Ensures that even if a Spoke VM is compromised and logs are cleared locally, the data is already safe in the Hub. |

---

## 🗺️ Visual Representation
Below is the logical flow of the architecture, demonstrating how an attacker entering through the Internet must pass through the Hub's monitoring layer before reaching the sensitive Spoke workloads.

![Hub and Spoke Architecture](./architecture/hub-spoke-architecture.png)

---
*Next Step: Explore [03-Azure Network Deployment](./03-azure-network-deployment.md) to see the configuration of these VNets and Peering settings.*

![Hub Spoke Diagram](../architecture/hub-spoke-topology.png)

Figure 3 — Hub-and-Spoke topology showing centralized monitoring and segmented workload networks.

🏛️ architecture/
vnet-manager-topology.png: A screenshot of the Azure Virtual Network Manager visual topology showing the Hub connected to the two Spokes.

network-peering-status.png: A shot of the "Peerings" blade in the Hub VNet showing the "Connected" status for both spokes.

🖥️ vm-deployment/
vm-inventory.png: A shot of the "Virtual Machines" list in Azure, showing HUB-SRV01, APP-SRV01, and CLIENT01 all in "Running" status.

effective-routes.png: From the CLIENT01 Network Interface, a shot of the Effective Routes showing the peering routes to the other VNets.

📊 logging/
law-overview.png: The "Overview" page of your Log Analytics Workspace showing the data ingestion charts.

ama-heartbeat.png: A KQL query result for Heartbeat | summarize count() by Computer to prove the agents are talking to the Hub.

🛡️ sentinel/
sentinel-dashboard.png: The main Sentinel Overview page showing active incidents and events.

analytics-rules-list.png: A shot of your "Analytics" blade showing your custom KQL rules active and mapped to MITRE tactics.

⚔️ attack-simulation/
powershell-bruteforce.png: A shot of your simulate-bruteforce.ps1 script running in the terminal.

security-event-log.png: Open Event Viewer on the target VM (APP-SRV01) showing the red "Audit Failure" (Event ID 4625) entries.

🔍 detections/
kql-detection-result.png: A screenshot of your detect-rdp-bruteforce.kql query returning results after your simulation.

incident-investigation-graph.png: (CRITICAL) The "Investigation" graph in Sentinel showing the link between the Attacker IP, the compromised VM, and the Key Vault.