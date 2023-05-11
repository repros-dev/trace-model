import pandas as pd
import json, argparse

def jsonld2csv(data, arg_o):
    # Parse the JSON-LD file and convert it into CSV files
    # Composition & Arrangement Table
    composition = data["trov:hasComposition"]
    artifacts = pd.DataFrame(data=composition["trov:hasArtifact"])[["@id", "trov:sha256", "trov:mimeType"]] \
                            .rename(columns={"@id": "ArtifactId", "trov:mimeType": "MimeType", "trov:sha256": "Digest"}) \
                            .set_index("ArtifactId")

    for arrangement in data["trov:hasArrangement"]:
        arrangement_id = arrangement["@id"]
        for artifact in arrangement["trov:hasLocus"]:
            artifact_id = artifact["trov:hasArtifact"]["@id"]
            artifact_loc = artifact["trov:hasLocation"]
            artifacts.loc[artifact_id, arrangement_id] = artifact_loc
        
    artifacts.to_csv(arg_o + "#composition_and_arrangement.csv", index=True)

    # Only if TRP exits, the following two tables will be available:
    # 1) TRO Attribute Justification Table
    # 2) TRP & Arrangement Table
    if "trov:hasPerformance" in data.keys():

        # TRS capability: mappings from @id to @type
        trscapid2type = {}
        for cap in data["trov:wasAssembledBy"]["trov:hasCapability"]:
            trscapid2type[cap["@id"]] = cap["@type"]

        if "trov:hasAttribute" in data.keys():
            for tro_att in data["trov:hasAttribute"]:
                tro_att_id = tro_att["@id"]
                tro_att_type = tro_att["@type"]
                justif = pd.DataFrame(tro_att["trov:warrantedBy"]).rename(columns={"@id": "TrpAttId"}).set_index("TrpAttId")
                justif["TroAtt"] = tro_att_type

        trp_rows = []
        for trp in data["trov:hasPerformance"]:
            trp_att = trp["trov:hadPerformanceAttribute"]
            justif.loc[trp_att["@id"], ["TrpAtt", "TrsAttId", "TrsAtt"]] = [trp_att["@type"], trp_att["trov:warrantedBy"]["@id"], trscapid2type[trp_att["trov:warrantedBy"]["@id"]]]

            trp_rows.append((trp["@id"], 
                            trp["rdfs:comment"] if "rdfs:comment" in trp.keys() else None,
                            trp["trov:wasConductedBy"]["@id"],
                            trp["trov:startedAtTime"],
                            trp["trov:endedAtTime"],
                            trp["trov:accessedArrangement"]["@id"],
                            trp["trov:contributedToArrangement"]["@id"]))
        perf = pd.DataFrame(data=trp_rows, columns=["TrpId", "TrpComment", "TrsId", "StartedAtTime", "EndedAtTime", "accessedArrangementId", "contributedToArrangementId"])
        
        justif.to_csv(arg_o + "#tro_attribute_justification.csv", index=True)
        perf.to_csv(arg_o + "#trp_and_arrangement.csv", index=False)
    return

# Parse input
parser = argparse.ArgumentParser()
parser.add_argument("--file", "-f", help="Files of the tro.jsonld (list[str] | str ): please use comma (no space) to split multiple file paths (e.g. file1,file2,file3).")
parser.add_argument("--output", "-o", help="Output folder path.")
arg_file, arg_o = parser.parse_args().file, parser.parse_args().output

if __name__ == "__main__":
    if not arg_file:
        parser.error("No action requested. Please add input: --file.")
    if not arg_o:
        parser.error("Missing output folder path. Please add output file path: --output.")
    
    for file_path in arg_file.split(","):
        tro_filename = file_path.split("/")[-1][:-7]
        print(tro_filename)
        # Load JSON-LD file
        with open(file_path) as fin:
            data = json.load(fin)["@graph"][0]
            jsonld2csv(data, arg_o + "/" + tro_filename)
