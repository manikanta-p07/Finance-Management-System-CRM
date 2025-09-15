# 📘 Finance Management System – Phase 2: Salesforce Org Setup & Configuration

This document explains the setup and configuration completed in **Phase 2** for the Finance Management System project. The goal of this phase was to set up a Salesforce Developer Org, configure a custom app, and create the required objects, fields, and permissions.

---

## 🔹 Step 1: Salesforce Developer Org
- Signed up for a free **Salesforce Developer Edition** at [developer.salesforce.com](https://developer.salesforce.com/signup).  
- Verified email and logged in successfully at [login.salesforce.com](https://login.salesforce.com).  
- Accessed **Lightning Experience Dashboard**.  

---

## 🔹 Step 2: Created a Custom Lightning App
- Created **Finance Management System App** in **App Manager**.  
- Added navigation items: Members, Contributions, Auctions, Notifications.  
- Made the app visible to standard profiles.  

---

## 🔹 Step 3: Created Custom Objects & Fields
### 1. Member
- Fields: Member ID (Auto Number), Phone, Email, Address, Join Date, Status, Is Premium Member? (Checkbox), KYC ID, Total Contributions.  

### 2. Contribution
- Fields: Contribution ID (Auto Number), Member (Lookup), Amount, Payment Date, Mode of Payment, Status, Late Payment? (Checkbox), Transaction ID.  

### 3. Auction
- Fields: Auction Name, Auction Date, Winner (Lookup), Bid Amount, Payout Amount, Is Closed? (Checkbox), Remarks.  

### 4. Notification
- Fields: Notification ID (Auto Number), Related Member (Lookup), Notification Type, Date, Status, High Priority? (Checkbox).  

---

## 🔹 Step 4: Created Tabs
- Tabs created for **Members, Contributions, Auctions, Notifications**.  
- Added these tabs into the **Finance Management System App** navigation bar.  

---

## 🔹 Step 5: Profiles & Permission Sets
- **Profiles**:  
  - Admin – Full access  
  - Manager – Read/Edit access for key objects  
  - Agent – Create/Edit Members & Contributions  
- **Permission Sets**:  
  - Finance Manager Access – Extra privileges assigned to Fund Managers.  

---

## ✅ Deliverables for Phase 2
- Salesforce Developer Org setup completed.  
- Finance Management System App created.  
- Four custom objects configured with fields.  
- Tabs added for navigation.  
- Profiles and permission sets created.  
- Screenshots stored in `/Phase2_Salesforce_Setup/screenshots/`.  

---

## 📂 Repository Structure
