
final List<Map<String, dynamic>> card_details = [
  // Topic 1: Python
  {
    'id': 1,
    'topic_id': 1,
    'question': 'What is Python?',
    'answer': 'Python is a high-level, interpreted programming language known for its simple syntax.',
  },
  {
    'id': 2,
    'topic_id': 1,
    'question': 'What is a list in Python?',
    'answer': 'A list is an ordered, mutable collection of items. Example: numbers = [1, 2, 3].',
  },
  {
    'id': 3,
    'topic_id': 1,
    'question': 'What is a tuple?',
    'answer': 'A tuple is an ordered collection of items that cannot be modified after creation. Example: values = (1, 2, 3).',
  },
  {
    'id': 4,
    'topic_id': 1,
    'question': 'What is a dictionary?',
    'answer': 'A dictionary stores data as key-value pairs. Example: student = {"name": "Alex", "age": 20}.',
  },
  {
    'id': 5,
    'topic_id': 1,
    'question': 'What is a function in Python?',
    'answer': 'A function is a reusable block of code defined using the def keyword. Example: def greet(): print("Hello").',
  },

  // Topic 2: Flutter Navigation
  {
    'id': 6,
    'topic_id': 2,
    'question': 'What is navigation in Flutter?',
    'answer': 'Navigation allows users to move between different screens or pages in a Flutter application.',
  },
  {
    'id': 7,
    'topic_id': 2,
    'question': 'What does Navigator.push() do?',
    'answer': 'Navigator.push() adds a new route to the navigation stack and displays that screen.',
  },
  {
    'id': 8,
    'topic_id': 2,
    'question': 'What does Navigator.pop() do?',
    'answer': 'Navigator.pop() removes the current route from the navigation stack and returns to the previous screen.',
  },
  {
    'id': 9,
    'topic_id': 2,
    'question': 'What is a route in Flutter?',
    'answer': 'A route represents a screen or page in an application. MaterialPageRoute is commonly used to navigate to a new screen.',
  },
  {
    'id': 10,
    'topic_id': 2,
    'question': 'How do you pass data to another screen?',
    'answer': 'You can pass data through the destination screen constructor when calling Navigator.push(). For example: DetailsPage(title: "Hello").',
  },

  // Topic 3: FastAPI Endpoints
  {
    'id': 11,
    'topic_id': 3,
    'question': 'What is an endpoint in FastAPI?',
    'answer': 'An endpoint is a URL path combined with an HTTP method that allows a client to interact with an API.',
  },
  {
    'id': 12,
    'topic_id': 3,
    'question': 'What does @app.get() do?',
    'answer': '@app.get() defines an endpoint that handles HTTP GET requests, commonly used to retrieve data.',
  },
  {
    'id': 13,
    'topic_id': 3,
    'question': 'What does @app.post() do?',
    'answer': '@app.post() defines an endpoint that handles HTTP POST requests, commonly used to create or submit data.',
  },
  {
    'id': 14,
    'topic_id': 3,
    'question': 'What is a path parameter in FastAPI?',
    'answer': 'A path parameter is a value included directly in the URL path. Example: @app.get("/users/{user_id}") allows you to receive user_id as a parameter.',
  },
  {
    'id': 15,
    'topic_id': 3,
    'question': 'What is a query parameter in FastAPI?',
    'answer': 'A query parameter is a value passed after ? in a URL. Example: /items?limit=10. FastAPI can receive it as a function argument.',
  },
];
