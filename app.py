import spacy
from flask import Flask, jsonify, request

app = Flask(__name__)
nlp = spacy.load('en_core_web_sm')

def nerextraction(text):
    result = {}
    doc = nlp(text)
    for ent in doc.ents:
        result[ent.text] = ent.label_
    return result

@app.route("/ner", methods=['POST'])
def entity_extraction():
    query = request.get_json(force=True)
    query['NER'] = nerextraction(query.get('text', ''))
    return jsonify(query), 200

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8010, debug=False)
