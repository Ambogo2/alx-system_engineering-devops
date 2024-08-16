# POSTMORTEM

## Issue Summary ⛔
* **Duration:** August 16, 2024, 2:00 PM - 3:30 PM GMT
* __Impact:__ Our file management system which handles over 100,
000 users went down.50% of users were unable to access the platform since data processing was delayed.
* __Root cause:__ Misconfiguration of the database connection pool following a routine deployment, leading to exhaustion of available connections and subsequent timeouts.

## Root Cause Analysis 🔎
The root cause of the outage was traced to a recent change in the database configuration during a routine deployment. Specifically, the connection pool size was reduced, which inadvertently caused connection exhaustion as incoming requests exceeded the available connections. The lack of adequate testing in the staging environment allowed the configuration change to be deployed without detection of the potential impact on the live system.
Contributing factors include:

* Lack of automated tests for connection pool size and performance in high-load scenarios.
* Limited rollback protocols, leading to delays in reverting the problematic configuration.
* Insufficient monitoring alerts for connection pool metrics, which could have detected the issue earlier.
## Resolution and Recovery 📝
The incident was resolved by:

1. Mitigation: The on-call engineer increased the connection pool size in real-time to alleviate the connection exhaustion issue, restoring partial service.
2. Rollback: A full rollback of the faulty configuration was initiated once the root cause was identified, returning the system to a stable state.
3. Monitoring Enhancements: Additional metrics were added to the monitoring dashboard to track connection pool health and identify similar issues more proactively in the future.
4. Post-Incident Testing: New tests were added to ensure that changes to critical system components such as the database configuration are properly validated in the staging environment before deployment.

The system was fully operational by 3:30 PM GMT, and user access was restored across all services.


## Next Steps ⏭️
1. Improved Testing: Implement automated tests for connection pool configuration and scalability to ensure better validation of system changes.
2. Enhanced Monitoring: Deploy more granular database performance monitoring to detect connection pool usage and alert when thresholds are exceeded.
3. Review Rollback Process: Review and streamline the rollback process to reduce downtime during future incidents.