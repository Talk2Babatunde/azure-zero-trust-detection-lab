# 09 - Lessons Learned & Visibility Gap Analysis

## 💡 The "Aha!" Moments
Building this lab provided critical insights into the reality of cloud security operations that a textbook cannot teach. 

### 1. The Latency of Cloud Telemetry
I learned that "Real-Time" detection in the cloud often has a 2-to-5 minute ingestion delay. 
* **Lesson:** Detection logic must account for this "ingestion lag." Automated responses (SOAR) need to be designed with the understanding that the attacker might have moved to the next stage by the time the alert triggers.

### 2. The Danger of Default Logging
One of the biggest takeaways was realizing that **Azure does not log everything by default.** * **The Gap:** I noticed that successful RDP logins weren't appearing in Sentinel initially because the specific "Security" stream wasn't enabled in the Data Collection Rule (DCR). 
* **The Fix:** I had to pivot from the legacy agent to the **Azure Monitor Agent (AMA)** and manually define the XPATH queries for the specific Event IDs I needed.

---

## 🛠️ Challenges Overcome

| Challenge | Technical Solution |
| :--- | :--- |
| **Silent Failures** | I used KQL `Heartbeat` checks to identify when a Spoke VM stopped sending logs due to a VNet peering misconfiguration. |
| **Alert Fatigue** | Initially, my brute-force query triggered an alert for every 3 failed logins. I tuned this to **10 attempts in 5 minutes** to ensure the SOC only sees high-fidelity threats. |
| **RBAC Propagation** | I learned that Azure IAM changes can take a few minutes to propagate. This taught me the importance of "Explicit Verification" in a Zero-Trust model. |

---

## 🚀 Future Roadmap (Scalability)
If I were to take this lab to a "Production" level, my next steps would be:
1.  **Infrastructure as Code (IaC):** Deploying the entire Hub-and-Spoke network using **Terraform** or **Bicep** for consistency.
2.  **Automated Response:** Creating a Sentinel **Playbook** (Logic App) to automatically disable a compromised user account or block an attacking IP in the NSG.
3.  **Multi-Cloud Expansion:** Replicating this detection logic in **AWS** using Amazon GuardDuty and Security Lake.

---
## 🏁 Conclusion
This project reinforced that **Detection Engineering is a continuous cycle.** As adversaries evolve their techniques (moving from RDP to Session Hijacking), our telemetry collection and KQL logic must evolve with them. 

*Project completed March 2026.*