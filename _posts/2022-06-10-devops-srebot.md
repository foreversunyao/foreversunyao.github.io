---
layout: post
title: "SRE bot"
date: 2022-06-10 12:25:06
description: Opsdroid, Slack, Jenkins, PD, Automation, SRE
tags: 
 - devops
---
[refer](https://opsdroid.dev)
**Opsdroid**
- features
```
Connector - A module to connect to a chat service like Slack.
Skill - Skills are functions/classes that you write that get called when something specific happens in your chat service.
Matcher - A trigger for your skill, like someone saying a phrase in the chat.
```
- example
```
from AutobotSkill import AutobotSkill
from opsdroid.matchers import match_regex

class HelloWorld(AutobotSkill):
    @match_regex(r"Hello")
    async def ping(self, event):
        await event.respond("World")
```


**Libraries**
```
pdpyras -> pagerduty
opsdroid
slack-sdk
python-jenkins
ldap3
emoji
```
