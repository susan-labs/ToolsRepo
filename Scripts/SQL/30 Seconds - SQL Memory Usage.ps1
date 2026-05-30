-- Wait for 30 seconds to capture active queries
WAITFOR DELAY '00:00:30';

-- Query top 10 SQL processes consuming the most memory
SELECT TOP 10 
    s.session_id,
    r.status,
    r.cpu_time,  -- CPU time in milliseconds
    r.logical_reads,
    r.reads,
    r.writes,
    r.total_elapsed_time / (1000 * 60) AS ElapsedTimeMin,  -- Convert to minutes
    mg.requested_memory_kb,  -- Requested memory in KB
    FORMAT(mg.requested_memory_kb / 1024.0, 'N2') + ' MB' AS RequestedMemoryMB,
    FORMAT(mg.requested_memory_kb / (1024.0 * 1024.0), 'N2') + ' GB' AS RequestedMemoryGB,
    SUBSTRING(st.text, 
              (r.statement_start_offset / 2) + 1,
              ((CASE r.statement_end_offset
                    WHEN -1 THEN DATALENGTH(st.text)
                    ELSE r.statement_end_offset
               END - r.statement_start_offset) / 2) + 1) AS StatementText,
    COALESCE(QUOTENAME(DB_NAME(st.dbid)) + N'.' + 
             QUOTENAME(OBJECT_SCHEMA_NAME(st.objectid, st.dbid)) + N'.' + 
             QUOTENAME(OBJECT_NAME(st.objectid, st.dbid)), '') AS CommandText,
    r.command,
    s.login_name,
    s.host_name,
    s.program_name,
    s.last_request_end_time,
    s.login_time,
    r.open_transaction_count
FROM sys.dm_exec_sessions AS s
JOIN sys.dm_exec_requests AS r ON r.session_id = s.session_id
LEFT JOIN sys.dm_exec_query_memory_grants AS mg ON mg.session_id = s.session_id  -- Memory grants
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS st
WHERE r.session_id != @@SPID
ORDER BY mg.requested_memory_kb DESC;  -- Sort by highest memory usage
