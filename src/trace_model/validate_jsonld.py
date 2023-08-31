import json, argparse
from jsonschema import Draft7Validator, FormatChecker

def validate_tro(tro_jsonld_file_path, tro_schema_file_path):
    with open(tro_jsonld_file_path) as fin:
        tro_jsonld = json.load(fin)
    with open(tro_schema_file_path) as fin:
        tro_schema = json.load(fin)
    validator = Draft7Validator(schema=tro_schema, format_checker=FormatChecker())
    
    if validator.is_valid(tro_jsonld):
        print("Is a valid TRO JSON-LD file.")
    else:
        validator.validate(instance=tro_jsonld)
    return

def cli():
    # Parse input
    parser = argparse.ArgumentParser()
    parser.add_argument("--jsonldpath", "-jp", help="TRO JSON-LD file path ( str ).")
    parser.add_argument("--schemapath", "-sp", help="TRO Schema file path ( str ).")
    tro_jsonld_file_path, tro_schema_file_path = parser.parse_args().jsonldpath, parser.parse_args().schemapath
    if not tro_jsonld_file_path:
        parser.error("No JSON-LD file provided. Please add input: --jsonldpath.")
    if not tro_schema_file_path:
        parser.error("No schema file provided. Please add input: --schemapath.")
    validate_tro(tro_jsonld_file_path, tro_schema_file_path)

if __name__ == '__main__':
    cli()
