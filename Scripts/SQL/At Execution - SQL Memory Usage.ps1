DECLARE @initial_memory_usage bigint,
        @final_memory_usage bigint;

-- Get initial memory usage
SELECT @initial_memory_usage = physical_memory_in_use_kb
FROM sys.dm_os_process_memory;

-- Wait for 30 seconds
WAITFOR DELAY '00:00:30';

-- Get final memory usage
SELECT @final_memory_usage = physical_memory_in_use_kb
FROM sys.dm_os_process_memory;

-- Calculate the difference in memory usage
SELECT 
    @initial_memory_usage AS InitialMemoryUsageKB,
    FORMAT(@initial_memory_usage / 1024.0, 'N2') + ' MB' AS InitialMemoryUsageMB,
    FORMAT(@initial_memory_usage / (1024.0 * 1024.0), 'N2') + ' GB' AS InitialMemoryUsageGB,
    
    @final_memory_usage AS FinalMemoryUsageKB,
    FORMAT(@final_memory_usage / 1024.0, 'N2') + ' MB' AS FinalMemoryUsageMB,
    FORMAT(@final_memory_usage / (1024.0 * 1024.0), 'N2') + ' GB' AS FinalMemoryUsageGB,

    (@final_memory_usage - @initial_memory_usage) AS MemoryUsageDifferenceKB,
    FORMAT((@final_memory_usage - @initial_memory_usage) / 1024.0, 'N2') + ' MB' AS MemoryUsageDifferenceMB,
    FORMAT((@final_memory_usage - @initial_memory_usage) / (1024.0 * 1024.0), 'N2') + ' GB' AS MemoryUsageDifferenceGB;