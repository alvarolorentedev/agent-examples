from prompt_toolkit import prompt
from agno.agent import Agent
from agno.models.groq import Groq

agent = Agent(
    model=Groq(id="llama-3.1-8b-instant"),
    markdown=True,
)


def start_cli():
    while 1:
        user_input = prompt('>')
        if user_input == 'q':
            break
        agent.print_response(user_input, stream=True)

start_cli()