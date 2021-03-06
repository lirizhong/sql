﻿SELECT
	to_char(CURRENT_TIMESTAMP - query_start, 'DD HH24:MI:SS.MS') as query_time
	,to_char(CURRENT_TIMESTAMP - backend_start, 'DD HH24:MI:SS.MS') as client_conn_time
	,to_char(CURRENT_TIMESTAMP - xact_start, 'DD HH24:MI:SS.MS') as transaction_time
	,to_char(CURRENT_TIMESTAMP - state_change, 'DD HH24:MI:SS.MS') as state_change_time
	,state, waiting, datname, pid, usename, application_name, client_addr, backend_start, xact_start, query_start, state_change, query
--	,pg_terminate_backend(pid)
--	,CASE
--		WHEN CURRENT_TIMESTAMP - query_start > interval '1 minute'
--			THEN 'terminate: ' || pg_terminate_backend(pid)
--		ELSE 'ok'
--	END as terminated
FROM pg_stat_activity
WHERE
	1=1
	AND state NOT IN ('idle')
	AND pid != pg_backend_pid()
--	AND state = 'active'
--	AND '10.0.17.32' = client_addr
ORDER BY
--	query_time DESC
--	client_conn_time DESC
--	transaction_time DESC
--	state_change_time DESC
	transaction_time DESC, query_time DESC
/

SELECT pg_terminate_backend(7796)
/

REINDEX TABLE bo_document_base
/

VACUUM VERBOSE ANALYZE bo_document_base
/
