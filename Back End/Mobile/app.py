from flask import Flask, request, jsonify
from flask_cors import CORS
import json

app = Flask(__name__)
CORS(app)

def load_data(filename):
    try:
        with open(filename, "r") as file:
            return json.load(file)
    except FileNotFoundError:
        return {}

def save_data(filename, data):
    with open(filename, "w") as file:
        json.dump(data, file, indent=2)

@app.route('/users', methods=['GET'])
def get_users():
    users_data = load_data("users.json")
    return jsonify(users_data)

@app.route('/users/<int:user_id>', methods=['GET', 'PUT'])
def handle_user(user_id):
    if request.method == 'GET':
        users_data = load_data("users.json")
        user = users_data.get(str(user_id))
        if user:
            return jsonify(user)
        else:
            return jsonify({'error': 'User not found'}), 404

    elif request.method == 'PUT':
        updated_user_data = request.json.get('user')
        if not updated_user_data:
            return jsonify({'error': 'Invalid user data'}), 400

        users_data = load_data("users.json")
        user = users_data.get(str(user_id))
        if user:
            # Update user information
            user.update(updated_user_data)
            save_data("users.json", users_data)
            return jsonify({'message': 'User updated successfully!'}), 200
        else:
            return jsonify({'error': 'User not found'}), 404

@app.route('/reviews', methods=['GET', 'POST'])
def handle_reviews():
    if request.method == 'GET':
        reviews_data = load_data("reviews.json")
        return jsonify({'Review': reviews_data.get("Review", [])})

    elif request.method == 'POST':
        new_review = request.json.get('Review')
        if not new_review:
            return jsonify({'error': 'Invalid review data'}), 400

        reviews_data = load_data("reviews.json")
        reviews = reviews_data.get("Review", [])
        reviews.append(new_review)
        reviews_data["Review"] = reviews

        save_data("reviews.json", reviews_data)

        return jsonify({'message': 'Review submitted successfully!'}), 200

if __name__ == '__main__':
    app.run(debug=True)