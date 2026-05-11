from http.server import HTTPServer, BaseHTTPRequestHandler

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Hello from KGT Cloud Formation ! v4.0 - Azure CI/CD !")

HTTPServer(('', 8080), Handler).serve_forever()
