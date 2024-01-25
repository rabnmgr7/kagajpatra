"# kagajpatra"
Web App (Python Flask): Handles user interactions and manages document storage.
Database (MySQL): Stores information about documents and users.
Nginx: Acts as a reverse proxy to handle web requests and serve static files.
Here's a simplified directory structure:
├── app
│   ├── app.py
│   ├── __init__.py
│   ├── static
│   │   └── style.css
│   └── templates
│       ├── index.html
│       └── uploads.html
├── container-create.sh
├── db
│   └── init.sql
├── Dockerfile-nginx
├── Dockerfile-web
├── image-build.sh
├── Jenkinsfile
├── nginx
│   └── nginx.conf
├── README.md
└── requirements.txt
