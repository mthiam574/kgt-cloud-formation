from http.server import HTTPServer, BaseHTTPRequestHandler

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Hello from KGT Cloud Formation ! v2.0 - deploye par GitHub Actions !")

HTTPServer(('', 8080), Handler).serve_forever()
