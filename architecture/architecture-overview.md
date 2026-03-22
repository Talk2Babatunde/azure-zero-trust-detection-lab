# 🏛️ Architecture Overview: Zero-Trust Hub-and-Spoke

This document provides a high-level blueprint of the Azure infrastructure engineered for this project. The architecture utilizes a **Hub-and-Spoke topology** across multiple regions to isolate workloads, centralize security management, and enforce strict Zero-Trust access controls.

<img width="1920" height="892" alt="image98" src="https://github.com/user-attachments/assets/2565f462-bfaa-4fc2-a78d-0be7bbda7c8e" />


---

## 🏗️ Architectural Blueprint

The infrastructure is segmented into three primary Virtual Networks (VNets) deployed across distinct Azure regions to simulate a distributed enterprise environment.

<img width="1893" height="672" alt="image45" src="https://github.com/user-attachments/assets/1e39e39e-1668-4d52-a141-6c78680aa1ce" />


      Figure 1 — Hub-and-Spoke Zero-Trust Architecture with centralized monitoring and security services deployed in the hub network.

### 📂 Resource Organization
* **Subscription:** Visual Studio Enterprise / Personal Pay-As-You-Go
* **Resource Group:** `hub-and-spoke-topology`
* **Regions deployed:** US West 2 (Hub) and West US (Spokes)

---

## 🧩 Core Components

### 🛡️ 1. The Hub VNet (`hub-vnet`)
The Hub acts as the centralized transit and security inspection point. It does not host standard user applications.
* **Log Analytics Workspace (`law-zero-trust-soc`):** The central data lake for telemetry.
* **Microsoft Sentinel:** Cloud-native SIEM overlaid on the LAW for detection engineering.
* **Azure Bastion Subnet:** Secure, browser-based RDP/SSH access (no Public IPs on VMs).
* **Virtual Network Gateway Subnet:** Secure site-to-site or point-to-site connectivity.

### 🖥️ 2. Spoke 1 VNet (`spoke1-vnet`)
Isolated network environment hosting tier-1 production workloads.
* **Workload:** `app-vm1` (Windows Server Application).
* **Security Control:** Outfitted with Network Security Groups (NSGs) and the Azure Monitor Agent (AMA).

### 💻 3. Spoke 2 VNet (`spoke2-vnet`)
Isolated network environment hosting internal client systems or test labs.
* **Workload:** `client-vm2` (Windows Server Client).
* **Security Control:** Protected by NSGs and monitored via the AMA agent.

---

## ⚙️ Key Engineering Concepts Applied

### 🔒 1. Micro-Segmentation & VNet Peering
Spokes cannot communicate directly with each other (No Mesh). All East-West traffic between `spoke1` and `spoke2` must traverse the peering into the Hub, establishing a deterministic network chokepoint.

<img width="1920" height="892" alt="image37" src="https://github.com/user-attachments/assets/b77085ae-102e-47d1-bdcf-3ee0d098730c" />


### 📜 2. Zero-Trust Access (Least Privilege)
No virtual machines are assigned Public IP addresses. Administrative access is strictly routed through **Azure Bastion** or internal gateways, drastically reducing the external attack surface.

### 📡 3. Regional Fault Tolerance
By deploying Spokes in separate regions from the Hub, the architecture mirrors enterprise availability standards, proving capability in managing multi-region latency and routing tables.



    
