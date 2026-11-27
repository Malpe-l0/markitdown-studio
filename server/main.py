from pathlib import Path
from tempfile import TemporaryDirectory
from typing import Annotated

from fastapi import FastAPI, File, Form, HTTPException, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from markitdown import MarkItDown

app = FastAPI(title="MarkItDown Studio API")
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://127.0.0.1:5173"],
    allow_methods=["GET", "POST"],
    allow_headers=["*"],
)
MAX_BYTES = 50 * 1024 * 1024


@app.get("/api/health")
def health():
    return {"status": "ok"}


@app.post("/api/convert")
async def convert_file(
    file: Annotated[UploadFile, File()],
    enable_plugins: Annotated[bool, Form()] = False,
    include_metadata: Annotated[bool, Form()] = True,
):
    content = await file.read(MAX_BYTES + 1)
    if len(content) > MAX_BYTES:
        raise HTTPException(status_code=413, detail="Il file supera il limite di 50 MB.")
    if not content:
        raise HTTPException(status_code=400, detail="Il file è vuoto.")

    suffix = Path(file.filename or "documento").suffix[:20]
    try:
        with TemporaryDirectory(prefix="markitdown-") as temp_dir:
            source = Path(temp_dir) / f"source{suffix}"
            source.write_bytes(content)
            converter = MarkItDown(enable_plugins=enable_plugins)
            result = converter.convert_local(str(source))
            markdown = result.text_content or ""
            if include_metadata and result.title and result.title not in markdown[:500]:
                markdown = f"# {result.title}\n\n{markdown}"
            return {"markdown": markdown, "filename": file.filename}
    except Exception as exc:
        raise HTTPException(status_code=422, detail=f"Conversione non riuscita: {exc}") from exc
