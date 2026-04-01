# 🔐 Zero Trust Security Model Implementation

## 📌 Overview

This project applies a Zero Trust security model within a Microsoft Azure environment. The design assumes that no user, device, or network is inherently trusted — even if it exists inside the network boundary. All access is continuously verified, monitored, and restricted based on least privilege principles.

---

## 🧠 Core Principles Applied

### 1. Verify Explicitly

All access attempts are logged and monitored using Microsoft Sentinel and Log Analytics. Authentication and activity events are analyzed to detect anomalies such as failed login attempts, suspicious sign-ins, and abnormal behavior patterns.

---

### 2. Least Privilege Access

Access to resources is controlled using Role-Based Access Control (RBAC) in Microsoft Entra ID. Users and services are granted only the permissions required to perform their tasks, reducing the risk of privilege abuse and lateral movement.

---

### 3. Assume Breach

The environment is designed with the assumption that an attacker can gain initial access. Detection mechanisms are implemented to identify multi-stage attack behavior, including:

* Brute-force login attempts
* Successful compromise of a virtual machine
* Privilege escalation via role assignment
* Unauthorized access to sensitive resources

---

## 🌐 Network Segmentation (Hub-and-Spoke)

A Hub-and-Spoke architecture is used to isolate workloads and enforce centralized inspection:

* The **Hub VNet** acts as the security and monitoring layer
* **Spoke VNets** host workloads and are segmented to prevent direct lateral movement
* All traffic is logically routed through the Hub for visibility and control

---

## 🌍 Controlled External Access

To simulate real-world attack scenarios, virtual machines are assigned Public IP addresses. Access is restricted using Network Security Groups (NSGs), allowing only authorized connections while enabling detection of external threats such as RDP brute-force attacks.

In a production Zero Trust environment, this exposure would be removed and replaced with secure access mechanisms such as Azure Bastion or private endpoints.

---

## 📊 Centralized Monitoring & Detection

All logs from virtual machines, identity systems, and Azure resources are ingested into a Log Analytics Workspace and analyzed using Microsoft Sentinel. Custom detection rules (KQL) are used to correlate events across multiple attack stages into a single incident.

---

## 🎯 Security Outcomes

* Reduced attack surface through controlled access
* Improved visibility across identity, network, and endpoint activity
* Detection of multi-stage attacker behavior
* Alignment with modern Zero Trust architecture principles

---

## ✅ Summary

This implementation demonstrates how Zero Trust principles can be applied in a cloud-native environment to detect, contain, and respond to advanced threats through segmentation, least privilege, and continuous monitoring.
