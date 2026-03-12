When datasets scale to millions or billions of rows, standard indexing alone is often insufficient. In this phase, I implemented physical storage-level optimization using SQL Server (T-SQL).

🧪 Scenario: Managing 10+ Years of Historical Data
Using the AdventureWorksDW2022 database, I partitioned the DimDate table based on the "Year" to physically separate data into distinct segments. This significantly optimizes range-based queries by allowing the database engine to scan only relevant partitions.

🛠️ Step-by-Step Implementation:
Table Replication for Testing: To ensure data integrity, I created a staging table for practice using the SELECT * INTO DimDate_Practice command.

Partition Function: I created a partition function named pf_DimDate_3Years based on the FullDateAlternateKey (Logical DateKey) column, defining boundary values for 2006, 2009, and 2012.

Filegroup Configuration: I created 4 distinct Filegroups (fg_2006 to fg_2014) to logically organize the data storage.

Secondary Data Files (.ndf): I allocated secondary data files (.ndf) for each Filegroup, allowing the data to be physically distributed across the disk.

Partition Scheme: I developed a partition scheme to map the logical Partition Function to the physical Filegroups.

Table Integration: In the final step, I applied a Clustered Index to the DimDate_Practice table, effectively migrating the data onto the newly created Partition Scheme.

**SQL Implementation Code:**
-- 1. Create duplicate table for practice
SELECT * INTO DimDate_Practice FROM DimDate;

-- 2. Create Partition Function (Defining range boundaries)
CREATE PARTITION FUNCTION pf_DimDate_3Years (DATE)
AS RANGE LEFT FOR VALUES ('2006-12-31', '2009-12-31', '2012-12-31');

-- 3. Add Filegroups to the database
ALTER DATABASE AdventureWorksDW2022 ADD FILEGROUP fg_2006;
ALTER DATABASE AdventureWorksDW2022 ADD FILEGROUP fg_2009;
ALTER DATABASE AdventureWorksDW2022 ADD FILEGROUP fg_2012;
ALTER DATABASE AdventureWorksDW2022 ADD FILEGROUP fg_2014;

-- 4. Allocate physical .ndf files to respective Filegroups
ALTER DATABASE AdventureWorksDW2022 ADD FILE (NAME = p_2006, FILENAME = 'C:\...\p_2006.ndf') TO FILEGROUP fg_2006;
ALTER DATABASE AdventureWorksDW2022 ADD FILE (NAME = p_2009, FILENAME = 'C:\...\p_2009.ndf') TO FILEGROUP fg_2009;
ALTER DATABASE AdventureWorksDW2022 ADD FILE (NAME = p_2012, FILENAME = 'C:\...\p_2012.ndf') TO FILEGROUP fg_2012;
ALTER DATABASE AdventureWorksDW2022 ADD FILE (NAME = p_2014, FILENAME = 'C:\...\p_2014.ndf') TO FILEGROUP fg_2014;

-- 5. Create Partition Scheme (Mapping Function to Filegroups)
CREATE PARTITION SCHEME schemebypartition
AS PARTITION pf_DimDate_3Years
TO (fg_2006, fg_2009, fg_2012, fg_2014);

-- 6. Apply Clustered Index to bind the table to the Partition Scheme
CREATE CLUSTERED INDEX idx_DimDate_Partition
ON DimDate_Practice(FullDateAlternateKey)
ON schemebypartition(FullDateAlternateKey);

**The Result:**
By implementing partitioning, the SQL Server engine no longer needs to perform a full table scan for year-specific queries. Instead, it utilizes Partition Pruning to touch only the relevant filegroups, drastically reducing disk I/O and query execution time.
