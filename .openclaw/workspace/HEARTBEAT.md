# Smart Heartbeat Checklist

## Progress-Based Monitoring Rules
- Read `progress_state.json` first. Only act on stalled or errored tasks.
- Do NOT scan all files or folders. Only check state files.
- If all tasks show recent progress (updated within last heartbeat interval), reply HEARTBEAT_OK.
- If a task is stalled (no progress for 2+ heartbeat cycles), report which task and why.
- If an error is logged, summarize it in one sentence.
- Keep responses under 200 tokens to minimize cost.

## Checks (in order)
1. Read `progress_state.json` — check `last_updated` timestamps
2. If any task `status` is `"error"`, report it
3. If any task `status` is `"stalled"` or unchanged for 2+ cycles, flag it
4. If a task `status` is `"completed"`, note it once then clear
5. If nothing needs attention: reply HEARTBEAT_OK

## Cost Rules
- Use the cheapest available model (Groq Llama3)
- Max 3 tool calls per heartbeat run
- Max 2000 tokens per heartbeat response
- Do not trigger reasoning chains unless progress is stalled
