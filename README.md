
# 🚀 SQL Mastery for Data Engineering
A comprehensive collection of SQL optimization techniques, indexes, and complex queries.

## 📊 SQL Indexing & Performance Tuning
Understanding how databases store and retrieve data efficiently using B-Trees.

### 🔍 Clustered vs Non-Clustered Indexes
- **Clustered Index:** Physically reorders the data in the table. Only one per table (usually the Primary Key).
- **Non-Clustered Index:** A separate structure (like a book index) that points to the actual data locations.

![SQL Indexing Diagram](clustered and non.png )

## ⚡ Performance Acid Test (Real-time Results)

Maine Brazilian E-Commerce dataset (Olist) par indexing test ki hai. Search speed mein 100% improvement achieve hui:

| Query Type | Column Name | Time (Before Index) | Time (After Index) |
|------------|-------------|---------------------|--------------------|
| Search by ID| `product_id` | 0.031 sec           | 0.000 sec          |
| Range Scan  | `product_length_cm`| 0.047 sec     | 0.000 sec          |


![SQL Performance Proof](./Screenshot%20(496).png)

---
*Follow my journey to becoming a Data Engineer!*
