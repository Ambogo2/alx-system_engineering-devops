#!/usr/bin/python3
"""Exports data to JSON"""

import requests
import sys
import json

if __name__ == "__main__":

    url = "https://jsonplaceholder.typicode.com/"

    user_id = sys.argv[1]

    # Fetch user information
    response = requests.get(url + "users/{}".format(user_id))
    user = response.json()

    username = user.get("username")

    # Fetch todos for the user
    params = {"userId": user_id}
    todos_response = requests.get(f"{url}todos", params=params)
    todos = todos_response.json()

    # Prepare data for JSON export
    data = {
        user_id: [
            {
                "task": task.get("title"),
                "completed": task.get("completed"),
                "username": username
            }
            for task in todos
        ]
    }

    # Write data to JSON file
    with open(f'{user_id}.json', 'w') as file:
        json.dump(data, file, indent=4)
