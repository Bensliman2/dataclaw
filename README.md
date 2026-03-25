# DataClaw

An autonomous reasoning agent for data infrastructure. Connect **any** technology — databases, APIs, filesystems, message queues, servers — and interact with them through natural language.

No static tools. No per-technology hardcoding. The agent figures out how to connect, builds what it needs, and learns from every interaction.

## How It Works

```
You: "show me the top customers by revenue"

DataClaw:
  1. Detects your database from connections config
  2. Writes and executes the SQL query
  3. Returns formatted results

You: "list kafka topics"

DataClaw:
  1. Detects Kafka (messaging type — no built-in tool for this)
  2. Generates a connector using kafka-python
  3. Writes ephemeral code to list topics
  4. Executes it against your real Kafka cluster
  5. Returns the topic list
  6. Asks: "Save as reusable skill? [y/N]"
```

## Install

```bash
pip install dataclaw
```

**Optional extras** (install only what you need):

```bash
pip install dataclaw[ssh]        # SSH server support (paramiko)
pip install dataclaw[kafka]      # Kafka support (kafka-python)
pip install dataclaw[mongodb]    # MongoDB support (pymongo)
pip install dataclaw[redis]      # Redis support
pip install dataclaw[mysql]      # MySQL support
pip install dataclaw[snowflake]  # Snowflake support
pip install dataclaw[all]        # Everything
```

## Setup

### Step 1 — Initialize config

```bash
dataclaw init
```

This creates `~/.dataclaw/` with template config files.

### Step 2 — Configure your LLM

Edit `~/.dataclaw/settings.yaml` and uncomment **one** LLM option:

**Option A — Local LLM (Ollama):**

```yaml
model:
  orchestrator:
    provider: ollama
    model: llama3.1        # or any model you have
    temperature: 0.2
  builder:
    provider: ollama
    model: llama3.1
    temperature: 0.2
```

Requires [Ollama](https://ollama.com) installed with a model pulled (`ollama pull llama3.1`).

**Option B — API-based LLM (OpenAI, Anthropic, etc.):**

```yaml
model:
  orchestrator:
    provider: openai               # or: anthropic
    model: gpt-4o-mini             # or: claude-sonnet-4-20250514
    api_key_env: OPENAI_API_KEY    # env var name from .env
    temperature: 0.2
  builder:
    provider: openai
    model: gpt-4o-mini
    api_key_env: OPENAI_API_KEY
    temperature: 0.2
```

Then add your API key to `~/.dataclaw/.env`:

```
OPENAI_API_KEY=sk-...
```

### Step 3 — Add your data sources

Edit `~/.dataclaw/connections.yaml`:

```yaml
technologies:

  my_postgres:
    type: database
    driver: psycopg2
    access_level: read          # read | write | admin
    connection:
      host: localhost
      port: 5432
      database: mydb
      user: ${POSTGRES_USER}
      password: ${POSTGRES_PASSWORD}

  my_api:
    type: api
    driver: requests
    access_level: read
    connection:
      base_url: https://api.example.com
      api_key: ${MY_API_KEY}
```

Add credentials to `~/.dataclaw/.env`:

```
POSTGRES_USER=myuser
POSTGRES_PASSWORD=mypassword
MY_API_KEY=...
```

### Step 4 — Start

```bash
dataclaw
```

## Usage

### Natural language prompts

Just describe what you want:

```
> list all tables in my database
> show the schema of the users table
> count rows in the orders table
> what airflow DAGs are running?
> list kafka topics
> show files on the SSH server
```

### Slash commands

Quick actions that bypass the LLM:

| Command                    | Description                          |
|----------------------------|--------------------------------------|
| `/status`                  | System health check                  |
| `/connections`             | Show configured data sources         |
| `/schemas [db]`            | List database schemas                |
| `/tables [db]`             | List all tables                      |
| `/describe <table> [db]`   | Show table columns and types         |
| `/count <table> [db]`      | Count rows in a table                |
| `/sample <table> [db]`     | Show 5 sample rows                   |
| `/tools`                   | List agent-built tools               |
| `/skills`                  | List reusable skills                 |
| `/config`                  | View/edit runtime settings           |
| `/help`                    | Show all commands                    |

### Multi-database support

When you have multiple databases configured, DataClaw asks which one you mean:

```
> list tables

  Multiple databases found:
  1. main_db (localhost:5432, read)
  2. analytics_db (localhost:5433, write)
  Which one? > 1
```

Or specify directly: `/tables main_db`

## Supported Technologies

| Type         | Examples                          | How DataClaw connects           |
|-------------|-----------------------------------|----------------------------------|
| **database** | PostgreSQL, MySQL, SQLite, Snowflake | Built-in `run_query` tool (SQL) |
| **api**      | REST APIs, Airflow, any HTTP      | Built-in `call_api` tool (HTTP) |
| **filesystem** | Local files, project dirs       | Built-in `read_files` tool      |
| **messaging** | Kafka, RabbitMQ                  | Auto-generated connector + code |
| **server**   | SSH, remote machines              | Auto-generated connector + code |
| **cloud**    | AWS, GCP, Azure                   | Auto-generated connector + code |

For database, API, and filesystem types, DataClaw uses **bootstrap tools** — generic tools that work instantly with any provider.

For messaging, server, and cloud types, DataClaw **generates connectors on the fly** using the LLM, then writes and executes code against them.

## Skills

When DataClaw successfully runs code against a non-bootstrap technology (Kafka, SSH, etc.), it asks if you want to save it as a **skill** — a reusable pattern with metadata.

Skills are NOT executed directly. They are code templates that get injected into the LLM prompt so it generates better code next time. Think of them as "proven recipes" the agent learns from.

```
> list kafka topics
  ... (success) ...
  Save as reusable skill? [y/N] y
  Skill saved: kafka/list_topics

# Next time, the agent uses the saved pattern to generate correct code instantly
> list kafka consumer groups
  ... (uses list_topics skill as reference → generates correct code on first try)
```

## Security

- **Tiered access**: `read` blocks all writes, `write` allows data changes but blocks DDL, `admin` allows everything
- **Credentials**: Stored in `~/.dataclaw/.env`, never logged or displayed
- **Sandboxing**: Write/admin tools run in Docker containers with restricted network
- **Validation**: All generated code goes through AST analysis — blocks dangerous imports, eval, exec, subprocess

## Test Environment

Want to try DataClaw with real data? See [`envi-test/`](./envi-test/) for a Docker Compose setup with PostgreSQL, Airflow, Kafka, SSH, and sample data.

## Requirements

- Python 3.11+
- An LLM (local via Ollama or API-based)
- Docker (optional, for sandbox and test environment)

## License

MIT
