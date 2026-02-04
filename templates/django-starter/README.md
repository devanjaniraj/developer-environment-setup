# Django Starter Template

A professional Django REST API starter with PostgreSQL, CORS, and best practices.

## Features

- 🔥 Django 5.0 with REST Framework
- 🗄️ PostgreSQL database
- 🔐 Authentication ready
- 🌐 CORS configured
- 📦 Whitenoise for static files
- 🚀 Production-ready with Gunicorn
- 📝 Example API with CRUD operations
- ⚡ Environment variables support

## Getting Started

### Prerequisites

- Python 3.11+
- PostgreSQL database
- Virtual environment

### Installation

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# Windows
venv\Scripts\activate
# macOS/Linux
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Create .env file
copy .env.example .env

# Update database settings in .env

# Run migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Run development server
python manage.py runserver
```

Open [http://localhost:8000/api/](http://localhost:8000/api/) in your browser.

### API Endpoints

- `GET /api/` - API root
- `GET /api/items/` - List all items
- `POST /api/items/` - Create new item
- `GET /api/items/{id}/` - Get specific item
- `PUT /api/items/{id}/` - Update item
- `DELETE /api/items/{id}/` - Delete item
- `GET /admin/` - Django admin panel

### Environment Variables

Create a `.env` file:

```env
SECRET_KEY=your-secret-key-here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1
DB_NAME=django_db
DB_USER=postgres
DB_PASSWORD=postgres
DB_HOST=localhost
DB_PORT=5432
```

## Project Structure

```
django-starter/
├── django_starter/
│   ├── settings.py       # Django settings
│   ├── urls.py          # Main URL config
│   └── wsgi.py          # WSGI config
├── api/
│   ├── models.py        # Database models
│   ├── serializers.py   # DRF serializers
│   ├── views.py         # API views
│   └── urls.py          # API URLs
├── manage.py            # Django management
├── requirements.txt     # Dependencies
└── .env                 # Environment variables
```

## Production Deployment

```bash
# Collect static files
python manage.py collectstatic --noinput

# Run with Gunicorn
gunicorn django_starter.wsgi:application --bind 0.0.0.0:8000
```

## Learn More

- [Django Documentation](https://docs.djangoproject.com/)
- [Django REST Framework](https://www.django-rest-framework.org/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
