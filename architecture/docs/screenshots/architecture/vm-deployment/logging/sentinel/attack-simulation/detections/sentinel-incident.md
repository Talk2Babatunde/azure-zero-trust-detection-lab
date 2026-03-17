// Title: Sentinel Incident Impact Summary
// Strategy: Aggregates incident data to show the most targeted hosts and most common attack tactics.
SecurityIncident
| summarize IncidentCount = count() by Severity, Title
| sort by Severity desc