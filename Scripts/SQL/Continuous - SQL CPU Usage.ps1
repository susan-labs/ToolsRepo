DECLARE @initial_cpu_usage bigint,
        @final_cpu_usage bigint;

-- Get initial CPU usage
SELECT @initial_cpu_usage = cpu_time
FROM sys.dm_exec_requests
WHERE session_id = @@SPID;

-- Wait for 30 seconds
WAITFOR DELAY '00:00:30';

-- Get final CPU usage
SELECT @final_cpu_usage = cpu_time
FROM sys.dm_exec_requests
WHERE session_id = @@SPID;

-- Calculate the difference in CPU usage
SELECT 
    @initial_cpu_usage AS InitialCPUUsage,
    FORMAT(@initial_cpu_usage / 1000.0, 'N2') + ' seconds' AS InitialCPUUsageSeconds,
    FORMAT(@initial_cpu_usage / (1000.0 * 60), 'N2') + ' minutes' AS InitialCPUUsageMinutes,
    
    @final_cpu_usage AS FinalCPUUsage,
    FORMAT(@final_cpu_usage / 1000.0, 'N2') + ' seconds' AS FinalCPUUsageSeconds,
    FORMAT(@final_cpu_usage / (1000.0 * 60), 'N2') + ' minutes' AS FinalCPUUsageMinutes,
    
    (@final_cpu_usage - @initial_cpu_usage) AS CPUUsageDifference,
    FORMAT((@final_cpu_usage - @initial_cpu_usage) / 1000.0, 'N2') + ' seconds' AS CPUUsageDifferenceSeconds,
    FORMAT((@final_cpu_usage - @initial_cpu_usage) / (1000.0 * 60), 'N2') + ' minutes' AS CPUUsageDifferenceMinutes;
