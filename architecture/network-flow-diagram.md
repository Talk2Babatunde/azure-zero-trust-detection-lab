# 🛰️ Network and Telemetry Flow Diagram

This document illustrates the architectural flow of network traffic and security telemetry within our multi-region Azure environment. It highlights the centralized logging mechanism and zero-trust routing constraints.


<img width="1376" height="768" alt="image68" src="https://github.com/user-attachments/assets/dbfaf96e-b4d0-43dd-8356-c84b7a3a4e51" />

     I designed the architecture so that compute is isolated in the Spokes, but intelligence is centralized in the Hub. By using DCRs and the AMA agent, I verify that an audit failure on a remote Spoke is immediately actionable in Microsoft Sentinel, giving us real-time visibility without exposing the workloads to the public internet.

---

## 🚦 Architectural Traffic Streams

<img width="1920" height="892" alt="image4" src="https://github.com/user-attachments/assets/1e6b85d2-9d9c-4177-a198-c2fdfa3ea1d4" />


### 1. The Telemetry Pipeline (North-South Flow)
* **Mechanism:** Data Collection Rules (DCRs) push specific Windows Event logs via the Azure Monitor Agent (AMA) installed on isolated Spoke VMs.
* **Routing:** Logs traverse VNet Peerings into the Hub VNet.
* **Storage and Analysis:** Logs are ingested into the central Log Analytics Workspace (`hub-law`) for **Microsoft Sentinel** correlation and alerting.

### 2. The Management Plane (Secure Inbound Access)
* **Azure Bastion:** Provides secure, browser-based RDP access to the VMs without exposing public ports (like 3389) to the internet.
* **VPN Gateway:** Serves as a secure tunnel for administrator traffic to enter the Hub environment.

### 3. Lateral Movement Boundaries (East-West Flow)
* **Isolation:** The `spoke1-vnet` and `spoke2-vnet` are not peered directly together.
* **Enforcement:** Network Security Groups (NSGs) act as local micro-perimeters, ensuring lateral movement between Spokes must be forced through the Hub and monitored by Microsoft Sentinel.

---

## (The Zero-Trust Advantage)

By utilizing this specific Hub-and-Spoke model with standard logging pipelines, we achieve:
1. **Reduced Costs:** We share a single Microsoft Sentinel instance and Azure Firewall instance across the enterprise rather than deploying them per Spoke.
2. **Deterministic Chokepoints:** An attacker who compromises `client-vm2` cannot reach `app-vm1` without crossing a monitored VNet peering, triggering high-fidelity alerts.
