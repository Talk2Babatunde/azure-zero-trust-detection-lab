
# 🏛️ Hub-and-Spoke Network Topology

This project utilizes a **Hub-and-Spoke** network architecture to enforce a Zero-Trust security model. Instead of allowing all networks to talk to each other directly (Mesh), all traffic is routed through a centralized Hub where security monitoring and firewall policies are enforced.

<img width="1920" height="892" alt="image9" src="https://github.com/user-attachments/assets/d9644e58-bd91-48b0-991d-8b02a2264a94" />

    Figure — Azure Network Manager overview showing centralized Hub-and-Spoke topology configuration.


---

## 🗺️ Logical Topology

Below is the visual representation of how the Virtual Networks (VNets) and Virtual Machines are connected:

```text
          [ 🌐 Internet ]
                 │
        ┌─────────────────┐
        │  HUB (VNet 01)  │
        │ (Security & Ops)│
        └────────┬────────┘
                 │
        ┌────────┴────────┐
        │                 │
┌──────────────┐   ┌──────────────┐
│ SPOKE 02     │   │ SPOKE 03     │
│ (App Server) │   │ (Client VM)  │
└──────────────┘   └──────────────┘
