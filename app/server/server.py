#!/usr/bin/env python3

from flask import Flask, request, jsonify

import tempfile
import subprocess
import os
import shutil
from glob import glob


WORKING_DIR = '../jsonschema2pojo-0.4.8'
EXECUTABLE = './jsonschema2pojo'
ROOT_CLASS_NAME = 'RootJsonClass'

app = Flask(__name__)


@app.route('/', methods=['GET'])
def home():
    return 'JSON -> POJO server ready!'


@app.route('/', methods=['POST'])
def process():
    input_dir = tempfile.mkdtemp()
    input_path = input_dir + '/' + ROOT_CLASS_NAME + '.java'

    with open(input_path, 'w') as f:
        f.write(request.data.decode())

    output_dir = tempfile.mkdtemp()

    os.chdir(WORKING_DIR)
    COMMAND = [EXECUTABLE,
               '-T', 'json',
               '-s', input_path,
               '-t', output_dir]

    try:
        subprocess.call(COMMAND)

    except subprocess.CalledProcessError as e:
        return e.output, 400

    finally:
        classes = {}
        for path in glob(output_dir + '/*.java'):
            filename = os.path.basename(path)
            with open(path) as f:
                classes[filename] = f.read()

        shutil.rmtree(input_dir, True)
        shutil.rmtree(output_dir, True)

        return jsonify(classes), 200


if __name__ == '__main__':
    app.run(debug=True)
