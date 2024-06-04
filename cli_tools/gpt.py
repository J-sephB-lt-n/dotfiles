#!/usr/bin/env python
"""
A CLI interface to openAI models

To make this script available everywhere:
    1. Put this script into ~/cli_tools/gpt.py
    2. Add the following lines to the bottom of your run commands file
        (e.g. .bashrc or .zshrc):
        export PATH=$PATH:~/cli_tools
        chmod +x ~/cli_tools/*

For usage instructions run:
    $ gpt.py --help
"""

import argparse

import openai

arg_parser = argparse.ArgumentParser(
    description="A CLI interface to openAI models",
    formatter_class=argparse.ArgumentDefaultsHelpFormatter,
)
arg_parser.add_argument(
    "-p",
    "--prompt",
    help="Prompt to give to the language model",
    required=True,
    type=str,
)
arg_parser.add_argument(
    "-m",
    "--model_name",
    help="Name of model, passed to the openAI API",
    required=False,
    type=str,
    default="gpt-4o",
)
arg_parser.add_argument(
    "-o",
    "--max_output_tokens",
    help="Limit output to this many tokens (e.g. to control cost)",
    required=False,
    type=int,
    default=500,
)
arg_parser.add_argument(
    "-t",
    "--temperature",
    help="Temperature of model",
    required=False,
    type=float,
    default=0.0,
)
arg_parser.add_argument(
    "-v",
    "--verbose",
    help="Display process information to the screen",
    required=False,
    default=False,
    action="store_true",
)
args = arg_parser.parse_args()
if args.verbose:
    print(
        f"""
PROMPT:             {args.prompt}
MODEL_NAME:         {args.model_name}
MAX_OUTPUT_TOKENS:  {args.max_output_tokens}
TEMPERATURE:        {args.temperature}
    """
    )

openai_client = openai.OpenAI()
llm_chat = openai_client.chat.completions.create(
    model=args.model_name,
    temperature=args.temperature,
    max_tokens=args.max_output_tokens,
    messages=[{"role": "user", "content": args.prompt}],
)
print(llm_chat.choices[0].message.content)
