# Enterprise Active Directory Lab  
*A complete, enterprise-style Windows domain environment for cybersecurity, system administration, and blue-team training.*

---

## Overview  
This project is a fully functional **Active Directory enterprise lab** built using **VirtualBox**, **Windows Server**, and **Windows 11**.  

The purpose of this lab is to simulate a real corporate environment used for:

- Identity & Access Management (IAM)
- Domain Controller administration
- Group Policy management
- Privilege & account lifecycle operations
- Blue-team monitoring and detection engineering
- Cybersecurity learning, homelab architecture, and skill development

This repo includes:

- PowerShell automation scripts
- User generation workflow
- Names list for bulk AD account creation
- Lab documentation and structure

---

## Lab Architecture  

+------------------------------------------------+
| Enterprise Network |
+------------------------------------------------+
|
| Internal VirtualBox Network
|
| DC01 (Server) |
| - Domain Controller |
| - DNS Server |
| - Static IP: 172.16.0.1


|
|  Domain Join / User Auth
|

|   CLIENT01 (Win11) |
| - Domain-Joined PC |
| - DHCP (from host) |


### **Why this structure?**  
This mirrors real-world enterprise AD deployments:

- The **Domain Controller** owns the authoritative DNS zone.  
- The internal network is isolated from the internet for security.  
- Clients authenticate and receive policies from the DC.  
- Scripts automate identity creation just like IAM teams do in production.

---

## Network Configuration

### **Domain Controller (DC01)**  
| Setting | Value |
|--------|--------|
| OS | Windows Server |
| NIC | Internal Network |
| IP | `172.16.0.1` |
| Subnet | `255.255.255.0` |
| Gateway | *(blank)* |
| DNS | `127.0.0.1` |

### **Client (Windows 11)**  
| Setting | Value |
|--------|--------|
| NIC | Internal Network |
| IP | DHCP or static |
| DNS | `172.16.0.1` |
| Domain | `yourdomain.local` |

---

## PowerShell Automation  

### **User Creation Script**  
Located at:  

This script:

- Reads names from `names.txt`
- Parses first/last names
- Generates usernames
- Sets default passwords
- Places users inside a dedicated OU
- Creates accounts at scale (10–10,000 accounts)

This simulates real IAM workflows used by:

- IT Operations  
- Identity Governance teams  
- Enterprise support engineers  
- SOC analysts investigating identity misuse  

---

## 📄 Files in This Repository

| File | Purpose |
|------|---------|
| `Create_Users.ps1` | PowerShell script for automated user creation |
| `names.txt` | List of names imported by the script |
| `.gitignore` | Prevents system or temp files from being committed |
| `README.md` | Project documentation |

---

## Learning Objectives

By building this lab, you practice and demonstrate:

### **✔ Active Directory Fundamentals**
- OUs  
- Users  
- Groups  
- Authentication  
- Group Policy  

### **✔ Windows Server Administration**
- DNS  
- Static networking  
- Role installation  
- Security hardening  

### **✔ Infrastructure Architecture**
- Enterprise-style network isolation  
- Internal DNS resolution  
- Host-to-VM vs. VM-to-VM communication  

### **✔ Cybersecurity Use Cases**
- Blue team monitoring  
- Incident response testing  
- Credential abuse simulations  
- Detection engineering baselines  

---

## Future Expansions

You can expand this lab with:

- Group Policies for hardening  
- A SIEM (Splunk, Elastic, Wazuh)  
- Windows Event Forwarding  
- Additional client machines  
- Vulnerable VMs for attack simulation  
- Automated GPO deployment scripts  

---

## Author  
**Alex Rodriguez**  
Cybersecurity Professional & Security Advisor  
Building clean, modular, enterprise-grade labs for real-world learning.

---
