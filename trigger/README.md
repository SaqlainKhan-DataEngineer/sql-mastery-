# trigger
# 📉 Automated Price Audit System using SQL Triggers

## 📌 Project Overview
In dynamic e-commerce environments (like Amazon or Flipkart), product prices change frequently. Keeping a history of these changes is critical for analytics and auditing. 
This project implements an **Automated Trigger System** in MySQL that monitors the `Products` table. Whenever a price is updated, the system automatically logs the **Old Price**, **New Price**, and the **Timestamp** into a separate Audit Log table.

## 🛠️ Key Concepts Implemented
- **SQL Triggers:** Used `AFTER UPDATE` triggers to automate data logging without manual intervention.
- **Data Auditing:** Capturing `OLD` (pre-update) and `NEW` (post-update) values to maintain historical data integrity.
- **Automation:** Eliminating the need for application-level logging code.

## 📂 Database Schema

### 1. Main Table (`Products`)
Stores the current state of products.
| Column | Type | Description |
| :--- | :--- | :--- |
| `ProductID` | INT | Primary Key |
| `ProductName` | VARCHAR | Name of the item (e.g., iPhone 15) |
| `Price` | INT | Current selling price |

### 2. Audit Table (`Price_Logs`)
Automatically populated by the Trigger.
| Column | Type | Description |
| :--- | :--- | :--- |
| `LogID` | INT | Auto-incrementing Log ID |
| `ProductID` | INT | ID of the product changed |
| `Old_Price` | INT | Price *before* the update |
| `New_Price` | INT | Price *after* the update |
| `Change_Date` | DATETIME | Exact time of change (`NOW()`) |

## 💻 Logic & Code
The system uses the following logic to track changes:
1.  **Event:** An `UPDATE` command is executed on the `Products` table.
2.  **Trigger Execution:** The database fires the `price_update_monitor` trigger.
3.  **Action:** The trigger extracts the previous price (`OLD.Price`) and the new price (`NEW.Price`) and inserts a record into `Price_Logs`.

```sql
CREATE TRIGGER price_update_monitor
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO Price_Logs (ProductID, Old_Price, New_Price, Change_Date)
    VALUES (NEW.ProductID, OLD.Price, NEW.Price, NOW());
END;
