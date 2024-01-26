# app/app.py

from flask import Flask, render_template, request, redirect, url_for, send_from_directory, flash
from flask.helpers import get_flashed_messages # Import get_flashed_messages explicitly
from werkzeug.utils import secure_filename
import os

app = Flask(__name__, template_folder='templates')
app.config['UPLOAD_FOLDER'] = 'uploads'
app.config['ALLOWED_EXTENSIONS'] = set(['txt', 'pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg', 'gif'])
app.secret_key = 'Rabin@123'  # Set a secret key for flash messages

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

icons = {
    'txt': 'far fa-file-alt',   # Example: Font Awesome icon for text files
    'pdf': 'far fa-file-pdf',   # Example: Font Awesome icon for PDF files
    'doc': 'far fa-file-word',  # Example: Font Awesome icon for Word files
    'docx': 'far fa-file-word',  # Example: Font Awesome icon for Word files
    'png': 'far fa-file-image',  # Example: Font Awesome icon for image files
    'jpg': 'far fa-file-image',  # Example: Font Awesome icon for image files
    'jpeg': 'far fa-file-image', # Example: Font Awesome icon for image files
    'gif': 'far fa-file-image'   # Example: Font Awesome icon for image files
}

@app.route('/')
def index():
    # Check if a success flash message is present
    success_message = any(msg[1] == 'success' for msg in get_flashed_messages())

    files = os.listdir(os.path.join(app.root_path, app.config['UPLOAD_FOLDER']))
    file_data = []

    if success_message:
        for file in files:
            file_name, file_extension = os.path.splitext(file)
            icon_class = icons.get(file_extension[1:], 'far fa-file')  # Default icon if extension not found
            file_data.append({'name': file_name, 'icon': icon_class, 'filename': file})

        return render_template('index.html', files=file_data, show_files=success_message)

    # Add a default return statement in case the flash message is not present
    return render_template('index.html', show_files=False)
@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        flash('No file part', 'error')
        return redirect(request.url)

    file = request.files['file']

    if file.filename == '':
        flash('No selected file', 'error')
        return redirect(request.url)

    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)

        # Ensure the 'uploads' directory exists
        uploads_dir = os.path.join(app.root_path, app.config['UPLOAD_FOLDER'])
        os.makedirs(uploads_dir, exist_ok=True)

        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))        # Redirect to the '/uploads' route instead of the home page
        # return redirect(url_for('uploads'))  # to be redirected to /uploads.
        # Flash a success message
        flash('Files uploaded successfully', 'success')
        return index()

    flash('Invalid file type.')
    return redirect(request.url)

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
    app.run(debug=True, host='web')
