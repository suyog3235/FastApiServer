import json
import uvicorn
from fastapi import FastAPI
from utils.data_handler import data_handler

app = FastAPI()

@app.get("/")
def root():
    with open('db.json', 'r') as fp:
        data = json.load(fp) 
    return {"data":data} or {}

@app.get("/{item}")
def read_item(item: str):
    data = root().get('data')
    return data.get(item)

@app.get("/{item}/{infos_required:path}")
def read_info(item: str, infos_required: str):
    item = read_item(item)
    keys = infos_required.split("/")
    data = "🚫 No Data 🚫"
    for index, key in enumerate(keys):
        if index==0 and key:
            data = item.get(key)
        elif key:
            data = data.get(key)
    return data

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
