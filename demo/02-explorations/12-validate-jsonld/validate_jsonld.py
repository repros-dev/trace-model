import json
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