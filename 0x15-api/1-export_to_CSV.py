#!/usr/bin/python3
"""Exports data to CSV"""

import requests
import sys

if __name__ == "__main__":

    url = "https://jsonplaceholder.typicode.com/"

    user_id = sys.argv[1]

    response = requests.get(url + "users/{}".format(user_id))

    user = response.json()

    username = user.get("username")

    params = {"userId": user_id}
    todos_response = requests.get(f"{url}todos", params=params)

    todos = todos_response.json()

    with open(f'{user_id}.csv', 'w') as file:
        file.write('"USER_ID","USERNAME","COMPLETED","TITLE"\n')
        for task in todos:
            file.write('"{}","{}","{}","{}"\n'
                       .format(user_id, username, task.get('completed'),
                               task.get('title')))
