# OpenClaw Custom

A customized [OpenClaw](https://github.com/openclaw/openclaw) deployment with frugal multi-provider LLM routing, smart heartbeat monitoring, and verified ClawHub skills.

## Features

- **Frugal Multi-Provider LLM Routing**: Routes tasks to the most cost-effective provider
  - Coding tasks -> DeepSeek Coder (low cost, high quality code)
  - Reasoning tasks -> Anthropic Claude Sonnet (strongest reasoning)
  - Quick responses -> Llama 3.3 70B via Groq (fastest inference)
  - General tasks -> Mistral Large (balanced cost/quality)
  - Fallback -> OpenAI GPT-4o-mini (reliable backup)
- **Smart Progress-Based Heartbeat**: Only triggers reasoning when tasks are stalled
- **Token Budget Management**: Conservative defaults to minimize API costs
- **Verified ClawHub Skills**: Productivity skills pre-configured
- **Railway Deployment**: One-click deploy with persistent storage

## Quick Start

### 1. Clone and configure

```bash
git clone https://github.com/pidcue1-star/OpenClaw-Custom-d472d168.git
cd OpenClaw-Custom-d472d168
cp .env.example .env
# Edit .env with your actual API keys
```

### 2. Deploy to Railway

```bash
npm install -g @railway/cli
railway login
railway init
railway volume add --mount /data
railway up
```

### 3. Access

- Setup wizard: `https://<your-domain>/setup`
- Control UI: `https://<your-domain>/openclaw`

## LLM Routing Configuration

| Task Type  | Provider       | Model                    | Why                        |
|-----------|----------------|--------------------------|----------------------------|
| Coding    | DeepSeek       | deepseek-coder           | Cost-effective coding      |
| Reasoning | Anthropic      | claude-sonnet-4-5        | Best reasoning quality     |
| Quick     | Groq           | llama-3.3-70b-versatile  | Fastest inference          |
| General   | Mistral        | mistral-large-latest     | Balanced cost/quality      |
| Fallback  | OpenAI         | gpt-4o-mini              | Reliable backup            |
| Vision    | Google         | gemini-2.0-flash         | Free tier friendly         |

## Smart Heartbeat

The heartbeat system checks `progress_state.json` instead of scanning all files:
- Only triggers reasoning if a task is stalled (no progress for 2+ cycles)
- Uses cheap Groq Llama3 model for heartbeat checks
- Limits: max 6 steps, max 3 tool calls, max 2000 tokens per run
- Active hours: 06:00-23:00 UTC

## ClawHub Skills

Pre-configured verified skills:
- `gemini` - Google Gemini integration
- `github` - GitHub repository management
- `coding-agent` - Code assistance
- `clawhub` - Skill management
- `healthcheck` - System health monitoring

## Files

- `.openclaw/openclaw.json` - Main configuration (JSON5)
- `.openclaw/workspace/HEARTBEAT.md` - Heartbeat checklist
- `.openclaw/workspace/progress_state.json` - Task progress state
- `.env.example` - Environment variable template
- `railway.json` - Railway deployment config
- `Dockerfile` - Container build (from upstream OpenClaw)

## Security

- All API keys stored in environment variables, never in config files
- Gateway protected with authentication token
- Sandbox mode enabled for non-main agents
- Setup wizard password-protected
