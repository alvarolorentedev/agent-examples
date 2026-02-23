# Example Agents

## Agents

### Basic Agent

```python
from agno.agent import Agent
from agno.models.groq import Groq

agent = Agent(
    model=Groq(id="openai/gpt-oss-20b"),
    markdown=True,
)
```

### Plus instruction

```python
from agno.agent import Agent
from agno.models.groq import Groq

agent = Agent(
    model=Groq(id="openai/gpt-oss-20b"),
    role="your are an ghost writter for a technology related blog",
    instructions=[
        "start with an introduction section",
        "end with an conclusion section",
    ],
    markdown=True,
)
```

### Plus Tools

```python
from agno.agent import Agent
from agno.models.groq import Groq
from agno.tools.duckduckgo import DuckDuckGoTools

agent = Agent(
    model=Groq(id="openai/gpt-oss-20b"),
    role="your are an ghost writter for a technology related blog",
    instructions=[
        "you always investigate online to get contextual information using the tools at your disposition",
        "yo share links to important information",
        "start with an introduction section",
        "end with an conclusion section",
    ],
    tools=[DuckDuckGoTools()],
    markdown=True,
)
```

### Plus RAG

```python
from agno.agent import Agent
from agno.models.groq import Groq
from agno.knowledge.knowledge import Knowledge
from agno.vectordb.lancedb import LanceDb
from agno.vectordb.search import SearchType
from agno.knowledge.embedder.voyageai import VoyageAIEmbedder

vector_db = LanceDb(
    table_name="tech",
    uri="/tmp/lancedb",
    search_type=SearchType.keyword,
    embedder=VoyageAIEmbedder(),
)

knowledge = Knowledge(
    vector_db=vector_db,
)

knowledge.insert(
        url="https://assets.codeclubau.org/assets/Run-an-AI-image-generator-on-your-Raspberry-Pi.pdf"
)

agent = Agent(
    model=Groq(id="openai/gpt-oss-20b"),
    role="your are an ghost writter for a technology related blog",
    instructions=[
        "you always investigate online to get contextual information using the tools at your disposition",
        "yo share links to important information",
        "start with an introduction section",
        "end with an conclusion section",
    ],
    knowledge=knowledge,
    markdown=True,
)
```

### Plus Memory

```python
from agno.agent import Agent
from agno.models.groq import Groq
from agno.tools.duckduckgo import DuckDuckGoTools
from agno.db.sqlite import SqliteDb

db = SqliteDb(db_file="tmp/agents.db")

agent = Agent(
    model=Groq(id="openai/gpt-oss-20b"),
    role="your are an ghost writter for a technology related blog",
    instructions=[
        "you always investigate online to get contextual information using the tools at your disposition",
        "yo share links to important information",
        "start with an introduction section",
        "end with an conclusion section",
    ],
    db=db,
    add_history_to_context=True,
    num_history_runs=3,
    markdown=True,
)
```

### Plus cache

```python
from agno.agent import Agent

agent = Agent(
    model=Groq(id="openai/gpt-oss-20b", cache_response=True),
    role="your are an ghost writter for a technology related blog",
    instructions=[
        "start with an introduction section",
        "end with an conclusion section",
    ],
    markdown=True,
)
```

## Teams

```python
from agno.agent import Agent
from agno.team import Team
from agno.models.groq import Groq
from agno.tools.hackernews import HackerNewsTools
from agno.tools.duckduckgo import DuckDuckGoTools

model=Groq(id="openai/gpt-oss-20b", cache_response=True)
hn_researcher = Agent(model=model, name="HackerNews Researcher", tools=[HackerNewsTools()])
ddg_researcher = Agent(model=model, name="DuckDuckGo Researcher", tools=[DuckDuckGoTools()])

team = Team(
    model=Groq(id="openai/gpt-oss-20b", cache_response=True),
    members=[hn_researcher, ddg_researcher],
    add_history_to_context=True,
    markdown=True,
)
```

## Workflows

```python
from agno.agent import Agent
from agno.models.groq import Groq
from agno.workflow import Workflow
from agno.tools.duckduckgo import DuckDuckGoTools

model=Groq(id="openai/gpt-oss-20b", cache_response=True)

researcher = Agent(name="Researcher", model=model, tools=[DuckDuckGoTools()])
writer = Agent(name="Writer", model=model, instructions="Write engaging content")

workflow = Workflow(
    name="Content Workflow",
    steps=[researcher, writer],
)

```