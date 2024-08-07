---
layout: post
title: "PagerDuty - incident response"
date: 2023-05-11 12:25:06
description: pagerduty, incident response process
tags: 
 - sre
---

[refer](https://response.pagerduty.com)

- being on-call
1. being on-call
2. alerting principles

- before an incident
1. what is an incident
2. severity levels
3. different roles for incidents
4. incident call etiquette
5. complex incidents

- during an incident
1. during an incident
2. security incident response

- after an incident
1. after an incident
2. postmortem process
3. postmorterm template
4. effective postmortems


- practice
```
Roles:
    Incident commander -> coordinating
    Scribe -> timeline and records decisions
    Drivers -> engineers involed in fixing the issue


incident management lifecycle:
    1. start comms(identify level, roles assigned) 
    2. contain and fix(find ways to restore/rollback,keep evidence) 
    3. resolve and review(verify, stakeholders, post-mortem)


tools:
    slack(incident-bot)
    attribution(owner: slack channel, slack_aliases, emails, app_id, radar, pagerduty_service_id, runbook, stakeholders)
```

- in real life
oncall -> first responder(oncall) 
firefighter -> incident channel, live call, rollout blocks(notify leader on next action)
comms -> sending periodic updates , escalating, get more firefighters
scribe -> document incident, recording any incidents for future reference
leader -> should not be firefighter, coordinate, keep people focused, care for the participants(not in good state, tired), take decisions, high level viewing
