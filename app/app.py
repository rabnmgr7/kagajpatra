# app/app.py

from flask import Flask, render_template, request, redirect, url_for, send_from_directory
from werkzeug.utils import secure_filename
import os

app = Flask(__name__, template_folder='templates')
app.config['UPLOAD_FOLDER'] = 'uploads'
app.config['ALLOWED_EXTENSIONS'] = set(['txt', 'pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg', 'gif'])

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

icons = {
    'txt': 'far fa-file-alt',   # Example: Font Awesome icon for text files
    'pdf': 'far fa-file-pdf',   # Example: Font Awesome icon for PDF files
    'doc': 'far fa-file-word',  # Example: Font Awesome icon for Word files
    'docx': 'far fa-file-word', # Example: Font Awesome icon for Word files
    'png': 'far fa-file-image', # Example: Font Awesome icon for image files
    'jpg': 'far fa-file-image', # Example: Font Awesome icon for image files
    'jpeg': 'far fa-file-image',# Example: Font Awesome icon for image files
    'gif': 'far fa-file-image'  # Example: Font Awesome icon for image files
}

@app.route('/')
def index():
    files = os.listdir(os.path.join(app.root_path, app.config['UPLOAD_FOLDER']))
    file_data = []
    for file in files:
        file_name, file_extension = os.path.splitext(file)
        icon_class = icons.get(file_extension[1:], 'far fa-file')  # Default icon if extension not found
        file_data.append({'name': file_name, 'icon': icon_class, 'filename': file})        

    print(file_data)
    return render_template('index.html', files=file_data)

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return redirect(request.url)

    file = request.files['file']

    if file.filename == '':
        return redirect(request.url)

    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        
        # Ensure the 'uploads' directory exists
        uploads_dir = os.path.join(app.root_path, app.config['UPLOAD_FOLDER'])
        os.makedirs(uploads_dir, exist_ok=True)

        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        return redirect(url_for('index'))

    return 'Invalid file type.'

@app.route('/download/<filename>')
def download_file(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename, as_attachment=True)

@app.route('/uploads')
def uploads():
    files = os.listdir(os.path.join(app.root_path, app.config['UPLOAD_FOLDER']))
    file_data = []
    for file in files:
        file_name, file_extension = os.path.splitext(file)
        icon_class = icons.get(file_extension[1:], 'far fa-file')  # Default icon if extension not found
        file_data.append({'name': file_name, 'icon': icon_class, 'filename': file})        

    return render_template('uploads.html', files=file_data)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
