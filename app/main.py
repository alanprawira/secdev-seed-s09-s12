from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse, PlainTextResponse
from fastapi.templating import Jinja2Templates
import html

app = FastAPI()
templates = Jinja2Templates(directory="app/templates")


@app.get("/", response_class=HTMLResponse)
def index(request: Request, q: str = ""):
    safe_q = html.escape(q, quote=True)
    return templates.TemplateResponse(
        "index.html",
        {"request": request, "q": safe_q}
    )


@app.get("/healthz")
def healthz():
    return PlainTextResponse("OK")

@app.get("/echo", response_class=HTMLResponse)
def echo(x: str = ""):
    safe_x = html.escape(x, quote=True)
    return HTMLResponse(f"<h1>ECHO</h1><div>you said: {safe_x}</div>")

