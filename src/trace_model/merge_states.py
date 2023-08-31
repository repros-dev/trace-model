import pandas as pd
import argparse

def merge_state(arg_file):
    merged_state = pd.DataFrame()
    for file_path in arg_file.split(","):
        state = pd.read_csv(file_path, index_col="file_path")
        merged_state = pd.concat([merged_state, state], axis=1)
    return merged_state

def cli():
    # Parse input
    parser = argparse.ArgumentParser()
    parser.add_argument("--file", "-f", help="Files of the data (list[str] | str ): please use comma (no space) to split multiple file paths (e.g. file1,file2,file3).")
    parser.add_argument("--output", "-o", help="Output file path.")
    arg_file, arg_o = parser.parse_args().file, parser.parse_args().output

    if not arg_file:
        parser.error("No action requested. Please add input: --file.")
    if not arg_o:
        parser.error("Missing output file path. Please add input: --output.")
    
    merged_state = merge_state(arg_file)
    merged_state.to_csv(arg_o, index=True)

if __name__ == "__main__":
    cli()
