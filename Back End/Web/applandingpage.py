from flask import Flask, render_template, send_from_directory

landing_page = Flask(__name__)

# Serve the index.html file as the landing page
@landing_page.route('/')
def index():
    return render_template('index.html')

# Serve the contents of the fonts folder
@landing_page.route('/static/fonts/<path:filename>')
def serve_fonts(filename):
    return send_from_directory('static/fonts', filename)

if __name__ == '__main__':
    landing_page.run(debug=True, port=5002)