use AdventureWorksDW2022
select * from dimdate 

-- alternative table for practice
SELECT * INTO DimDate_Practice FROM DimDate;
-- create partition
CREATE PARTITION FUNCTION pf_DimDate_3Years (DATE)
AS RANGE LEFT FOR VALUES (
    '2006-12-31', -- Pehla cut: 2004, 2005, 2006 isme aayega
    '2009-12-31', -- Doosra cut: 2007, 2008, 2009 isme aayega
    '2012-12-31'  -- Teesra cut: 2010, 2011, 2012 isme aayega. (2013, 2014 aakhri hisse mein jayenge)
);

select * from sys.partition_functions;

-- create filegroup

alter database adventureworksdw2022 add filegroup fg_2006; 
alter database adventureworksdw2022 add filegroup fg_2009; 
alter database adventureworksdw2022 add filegroup fg_2012; 
alter database adventureworksdw2022 add filegroup fg_2014; 

select * from sys.filegroups

-- create data file

alter database AdventureWorksDW2022 add file
( 
name = p_2006,
filename = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\p_2006.ndf'
)
to filegroup fg_2006

alter database AdventureWorksDW2022 add file
( 
name = p_2009,
filename = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\p_2009.ndf'
)
to filegroup fg_2009 ;

alter database AdventureWorksDW2022 add file
( 
name = p_2012,
filename = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\p_2012.ndf'
)
to filegroup fg_2012;


alter database AdventureWorksDW2022 add file
( 
name = p_2014,
filename = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\p_2014.ndf'
)
to filegroup fg_2014 

-- create partition scheme
create partition scheme schemebypartition
as partition pf_DimDate_3Years
to (fg_2006,fg_2009,fg_2012,fg_2014);
-- connect with table 
CREATE CLUSTERED INDEX idx_DimDate_Partition
ON DimDate_Practice(FullDateAlternateKey)
ON schemebypartition(FullDateAlternateKey);




