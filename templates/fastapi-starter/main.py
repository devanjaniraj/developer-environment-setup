from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from datetime import datetime
import os
from dotenv import load_dotenv

load_dotenv()

# Models
class User(BaseModel):
    id: int = None
    name: str
    email: str

class Post(BaseModel):
    id: int = None
    title: str
    content: str
    author_id: int

# Create FastAPI app
app = FastAPI(
    title="FastAPI Starter",
    description="FastAPI REST API starter template",
    version="1.0.0"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Routes
@app.get("/")
async def root():
    return {
        "message": "FastAPI Server",
        "version": "1.0.0",
        "endpoints": {
            "health": "/api/health",
            "users": "/api/users",
            "posts": "/api/posts",
            "docs": "/docs"
        }
    }

@app.get("/api/health")
async def health():
    return {
        "status": "OK",
        "timestamp": datetime.now().isoformat()
    }

# Users endpoints
@app.get("/api/users")
async def get_users():
    return [
        {"id": 1, "name": "John Doe", "email": "john@example.com"},
        {"id": 2, "name": "Jane Smith", "email": "jane@example.com"}
    ]

@app.get("/api/users/{user_id}")
async def get_user(user_id: int):
    users = {
        1: {"id": 1, "name": "John Doe", "email": "john@example.com"},
        2: {"id": 2, "name": "Jane Smith", "email": "jane@example.com"}
    }
    if user_id not in users:
        raise HTTPException(status_code=404, detail="User not found")
    return users[user_id]

@app.post("/api/users")
async def create_user(user: User):
    user.id = 3
    return user

# Posts endpoints
@app.get("/api/posts")
async def get_posts():
    return [
        {"id": 1, "title": "First Post", "content": "Hello World", "author_id": 1},
        {"id": 2, "title": "Second Post", "content": "FastAPI is great", "author_id": 1}
    ]

@app.post("/api/posts")
async def create_post(post: Post):
    post.id = 3
    return post

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        app,
        host="0.0.0.0",
        port=int(os.getenv("PORT", 8000))
    )
