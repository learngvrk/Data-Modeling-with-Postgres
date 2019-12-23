SELECT * FROM pg_stat_activity
where datname = 'sparkifydb'

select pid, pg_terminate_backend(pid)
from pg_stat_activity
where pid in (29424)

REVOKE CONNECT ON DATABASE sparkifydb FROM public;

SELECT pid, pg_terminate_backend(pid) 
FROM pg_stat_activity 
WHERE 
    -- don't kill my own connection!
    pid <> pg_backend_pid()
    -- don't kill the connections to other databases
    AND datname = 'sparkifydb'
    ;

SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'sparkifydb'
  AND pid <> pg_backend_pid();
  
SELECT 
    pg_terminate_backend(pid) 
FROM 
    pg_stat_activity 
WHERE 
    -- don't kill my own connection!
    pid <> pg_backend_pid()
    -- don't kill the connections to other databases
    AND datname = 'sparkifydb';


-- Working, I guess! 
-- ###############################################################

UPDATE pg_database SET datallowconn = 'false' WHERE datname = 'sparkifydb';

SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'sparkifydb';

DROP DATABASE sparkifydb;

