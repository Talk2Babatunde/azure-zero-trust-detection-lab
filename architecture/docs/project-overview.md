# 01 - Project Overview: Azure Zero-Trust Detection Lab

## 🎯 The Problem Statement
Modern cloud environments are frequently compromised through identity-centric attacks and misconfigured infrastructure rather than traditional perimeter exploits. Standard logging often creates "telemetry silos" where individual events seem benign, but when correlated, they reveal a sophisticated compromise.

## 🚀 Project Vision
This project simulates a realistic multi-stage cloud intrusion inside a Microsoft Azure tenant. The goal is to demonstrate how a **Zero-Trust monitoring architecture** can detect attacker activity at every stage of the lifecycle—from initial access to data exfiltration.

<img width="1920" height="892" alt="image" src="https://github.com/user-attachments/assets/79796bed-c57d-412d-9f95-90f7e54b2611" />

     *Figure — Azure Network Manager deployment view showing successful rollout of Hub-and-Spoke connectivity configurations across multiple regions, supporting centralized control and segmentation within the Zero Trust architecture.*



The environment was engineered to replicate enterprise cloud infrastructure using a **Hub-and-Spoke network topology**, ensuring that workloads are isolated while security controls remain centralized.

---

## 🛠️ Project Scope
- **Architecture:** Deployment of a Hub VNet (Security) and Spoke VNets (Workloads) with VNet peering.
- **Telemetry Ingestion:** Configuration of the Azure Monitor Agent (AMA) and Data Collection Rules (DCR) to stream security events.
- **Detection Engineering:** Creating custom KQL analytics rules in Microsoft Sentinel to catch "Living off the Land" techniques.
- **Threat Simulation:** Execution of an automated attack script mimicking an adversary moving from RDP brute-force to Key Vault access.

---

## 🏗️ The Lab Architecture
The lab follows a professional cloud security blueprint:
* **Hub VNet:** Host to the Log Analytics Workspace and Microsoft Sentinel (The "Brain").
* **Spoke 1 (App Tier):** A Linux/Windows server representing a public-facing application.
* **Spoke 2 (Management Tier):** An internal administrative workstation.
* **Azure Key Vault:** Centralized storage for sensitive application secrets.

---

## 🧪 Key Questions Solved
1.  **Visibility:** Can we detect a successful login that followed 50 failed attempts?
2.  **Privilege Abuse:** Can we alert when an account is assigned a high-privilege role outside of business hours?
3.  **Data Protection:** Can we detect when a user accesses a Secret in Key Vault that they have never accessed before?

---
*Next Step: View the [02-Architecture Design](./02-architecture-design.md) for a deep dive into the network flow.*
