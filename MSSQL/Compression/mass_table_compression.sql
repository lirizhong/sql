EXEC sp_MSforeachtable @command1 = 'alter table ? REBUILD WITH (DATA_COMPRESSION = PAGE);'