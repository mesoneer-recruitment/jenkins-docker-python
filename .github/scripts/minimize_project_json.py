#!/usr/bin/env python

with open('project.json', 'r') as project_json:
    import json

    project = json.load(project_json)
    print(json.dumps(project))
