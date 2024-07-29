#!/usr/bin/python3
"""Exports data to JSON for all employees"""

import json
import requests

if __name__ == "__main__":

    url = "https://jsonplaceholder.typicode.com/"

    # Fetch all users
    users_response = requests.get(url + "users")
    users = users_response.json()

    # Prepare a dictionary to hold tasks for all users
    all_tasks = {}

    # Iterate over each user
    for user in users:
        user_id = user.get("id")
        username = user.get("username")

        # Fetch todos for the current user
        params = {"userId": user_id}
        todos_response = requests.get(f"{url}todos", params=params)
        todos = todos_response.json()

        # Prepare the list of tasks for the current user
        all_tasks[user_id] = [
            {
                "username": username,
                "task": task.get("title"),
                "completed": task.get("completed")
            }
            for task in todos
        ]

    # Write data to JSON file
    with open('todo_all_employees.json', 'w') as file:
        json.dump(all_tasks, file, indent=4)
