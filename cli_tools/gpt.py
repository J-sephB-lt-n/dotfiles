#!/usr/bin/env python
"""
A CLI interface to openAI models

To make this script available everywhere:
    1. Put this script into ~/cli_scripts/gpt.py
    2. Add the following lines to the bottom of your run commands file
        (e.g. .bashrc or .zshrc):
        export PATH=$PATH:~/cli_scripts
        chmod +x ~/cli_scripts/*

For usage instructions run:
    $ gpt.py --help
"""

import argparse
import time

import openai
import tiktoken

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
args = arg_parser.parse_args()

tokenizer = tiktoken.encoding_for_model(args.model_name)

openai_client = openai.OpenAI()
inference_start_time: float = time.perf_counter()
llm_chat = openai_client.chat.completions.create(
    model=args.model_name,
    temperature=args.temperature,
    max_tokens=args.max_output_tokens,
    messages=[{"role": "user", "content": args.prompt}],
)
inference_end_time: float = time.perf_counter()
total_inference_time_seconds: float = inference_end_time - inference_start_time
llm_response: str = llm_chat.choices[0].message.content

print(llm_response)
print(
    f"""
Model:              {llm_chat.model}
n input tokens:     {len( tokenizer.encode(args.prompt) ):,}
n output tokens:    {len( tokenizer.encode(llm_response) ):,} 
Inference time:     {total_inference_time_seconds:,.2f} seconds
"""
)
