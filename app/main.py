from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse, PlainTextResponse
from fastapi.templating import Jinja2Templates

app = FastAPI()
templates = Jinja2Templates(directory="app/templates")

@app.get("/", response_class=HTMLResponse)
def index(request: Request, q: str = ""):
    # намеренно простая страница, отражающая ввод
    # (для DAST это даст находки типа отражений/хедеров)
    return templates.TemplateResponse(
        "index.html",
        {"request": request, "q": q}
    )

@app.get("/healthz")
def healthz():
    return PlainTextResponse("OK")

@app.get("/echo", response_class=HTMLResponse)
def echo(x: str = ""):
    # намеренно без экранирования - упрощённая цель для ZAP
    return HTMLResponse(f"<h1>ECHO</h1><div>you said: {x}</div>")
