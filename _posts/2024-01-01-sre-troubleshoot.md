---
layout: post
title: "SRE - troubleshoot"
date: 2025-02-01 06:25:06
description: troubleshoot, root cause , on-call
tags: 
 - sre
---

# personal experience
triage -> where is it ? what's the impact ? incident level and workflow 
root cause -> history, metrics/log, recent changes, machine/process metrics, is it the cause or the effect ?
migitate -> revert/rollback, extend, simple fix(avoid huge change) 
resolve(software way) -> issue sample(log,evidence), reproduce(state ->input+logic->new state), code and test

war room -> update progress

1. Identify the problem
a. gather information
b. reproduce the problem
c. determine recent change

2. Establish a theory of root cause
a. bottom-up
b. top-down

3. Attempt a fix based on finds
a. make one change at a time and test
b. have a rollback plan

4. Document the solution

