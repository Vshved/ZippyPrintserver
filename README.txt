Configurable Unicode-Safe XPrinter Server (Zippy compatible)
==================================================================
- Listens on host/port from config.json (default 127.0.0.1:8081)
- Accepts text/plain arrays like [27,64,...], raw TSPL bytes, and JSON
- Automatically replaces TSPL TEXT lines with BITMAP (Cyrillic/Unicode OK)
- Async queue replies 202 immediately
- Printer name and paper size in config.json

Quick start
-----------
1) Install deps:
   py -m pip install -r requirements.txt
2) Edit app\config.json (host, port, printer_name, size, etc.)
3) Run:
   run.bat

Build EXE
---------
1) py -m pip install -r requirements.txt
2) run build_exe.bat
3) dist\xprint_server.exe + dist\config.json (edit the config, keep next to exe)

Config (app\config.json)
------------------------
{
  "host": "127.0.0.1",
  "port": 8081,
  "printer_name": "",             // empty = default printer
  "input_encoding": "cp1251",     // decode TEXT payloads sent by Zippy inside quotes
  "cors_allowed_origins": ["http://127.0.0.1","http://localhost"],
  "cors_allow_credentials": false,
  "label": {
    "size_w_mm": 40,
    "size_h_mm": 25,
    "gap_mm": 2,
    "density": 8,
    "speed": 4,
    "font_size": 26,
    "left_padding": 20
  }
}

Endpoints
---------
POST /print
  Content-Type: text/plain     -> "[27,64,...]" or raw TSPL text
  Content-Type: application/octet-stream -> raw TSPL
  Content-Type: application/json -> byte array or {"raw_base64": "..."}
  -> Returns 202 with {"job_id": ...}

GET /jobs/<id>   -> status: queued/printing/done/error
GET /health      -> diagnostics
GET /printers    -> list Windows printers

Notes
-----
- Place config.json next to the EXE (same folder). Edit and restart.
- If Cyrillic is wrong, adjust "input_encoding" (e.g., "utf-8", "cp866") or use pure JSON label mode.
- If browser CORS blocks, add your origin into "cors_allowed_origins".
