"""
Python Starter Project
A simple Python project template
"""

import sys
from pathlib import Path
import requests
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()

# Add src to path
sys.path.insert(0, str(Path(__file__).parent / 'src'))


class APIClient:
    """Simple API client for making requests"""

    def __init__(self, base_url: str = "http://localhost:3000"):
        self.base_url = base_url

    def get_users(self):
        """Fetch users from API"""
        try:
            response = requests.get(f"{self.base_url}/api/users")
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            print(f"Error fetching users: {e}")
            return []

    def get_health(self):
        """Check API health"""
        try:
            response = requests.get(f"{self.base_url}/api/health")
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            print(f"Error checking health: {e}")
            return None


def main():
    """Main function"""
    print("🐍 Python Starter Project")
    print("-" * 40)

    # Create API client
    api_client = APIClient()

    # Check health
    print("\nChecking API health...")
    health = api_client.get_health()
    if health:
        print(f"✓ API Status: {health['status']}")

    # Fetch users
    print("\nFetching users...")
    users = api_client.get_users()
    if users:
        print(f"✓ Found {len(users)} users:")
        for user in users:
            print(f"  - {user['name']} ({user['email']})")
    else:
        print("✗ No users found")

    print("\n✓ Done!")


if __name__ == "__main__":
    main()
