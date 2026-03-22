
# 🏛️ Hub-and-Spoke Network Topology

This project utilizes a **Hub-and-Spoke** network architecture to enforce a Zero-Trust security model. Instead of allowing all networks to talk to each other directly (Mesh), all traffic is routed through a centralized Hub where security monitoring and firewall policies are enforced.

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
