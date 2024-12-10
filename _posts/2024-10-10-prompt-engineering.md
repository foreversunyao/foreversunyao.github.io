---
layout: post
title: "Prompt Engineering"
date: 2024-10-10 12:25:06
description: OpenAI, Prompt Engineering, chatGPT, Generative AI, Code Assistants
tags:
 - ai
---

# Prompt Engineering 
Process of carefully crafting the input text to generative AI model; iterative refinement
Prompt Engineering requires an understanding of how AI models process information. Developers must know the capabilities and limitations of the AI tools they are using to craft effective prompts. This understanding ensures that the AI is leveraged within its optimal operational parameters, avoiding misinterpretations or incorrect outputs.

# Best Practices
1. Clarity and Precision
2. Context matters
3. Iterative Refinement
4. Feedback Integration

# Examples for various use cases
[reference](https://platform.openai.com/docs/guides/prompt-engineering#tactic-ask-the-model-to-adopt-a-persona)

# Example for coding
1. Introduction: Set up the context for which you're chatting in. It helps to give the AI an imaginary ‘role’ to think of themselves in. e.g. “Act as a software engineer. You're an expert in Python and …”
2. Task: e.g. “I want you to develop software to manage my record collection.”
3. Contextual Information: e.g. “I want it to be a web based application written in Python.”
4. Instructions: e.g. “I want you to generate the code to write the program.”
5. Closing: e.g. “I want to host it as an AWS Lambda function.”

```
Act as a software engineer. 
You're an expert in Python and AWS technologies. 
I want you to develop software to manage my record collection. 
Make it a web based application written in Python. 
Generate the code for the program, and I want to host it as a Lambda function.
```
# Example for troubleshooting
1. System prompt
2. User prompt
3. Completion
4. Iterative prompting
```
You are an expert in all aspects of Linux troubleshooting. I am a technical professional;
speak to me in tech language.

My Ubuntu 18.04 mail server experienced a kernel panic:
invalid opcode: 0000

Please help me troubleshoot the problem.

<reponse>

Tell me more about some_driver.c:1134

Give me a script of mock network traffic/rsync 
```

# tools
GPT
Claude
Copilot
Cursor
