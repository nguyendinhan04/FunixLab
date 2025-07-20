USE CDC_asm1_cs2
GO

-- Check sa has owner_sid permissions, if not then change db owner.
IF (select SUSER_SNAME(owner_sid) from sys.databases WHERE NAME='CDC_asm1_cs2') <> 'sa'
BEGIN
   EXEC sp_changedbowner 'sa'
END
GO
 
-- Check SourceDB is not already CDC enabled, if not then enable CDC for the database
if (select is_cdc_enabled from sys.databases WHERE NAME='CDC_asm1_cs2') = 'false'
BEGIN
   EXEC sys.sp_cdc_enable_db
END
GO
 