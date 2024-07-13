# Image Generation App

This Flutter application allows users to generate images based on textual prompts using the OpenAI API. The app follows the MVVM design pattern for better organization and maintainability.

## Getting Started

### Prerequisites
To get started with this project, follow these steps:

1. **Clone the repository:**
   ```sh
   git clone https://github.com/andriyantohalim/image_generation_app.git
   cd image_generation_app
    ```

2.	**Install dependencies:**
    ```
    flutter pub get
    ```

3. **Set up the environment:**
- Obtain your OpenAI API Key from [OpenAI](https://platform.openai.com/account/api-keys).
- Create a `.env` file in the root directory and add your API key:
    ```plaintext
    OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxx
    ```

4. **Run the app:**
    ```bash
    flutter run
    ```

## Usage

- **Send a message:** Type a message in the text field and press the send button to request an image based on the textual prompt.
- **View the generated image:** The generated image will be displayed in the chat view, with user messages on the right and bot responses (images) on the left.

## Project Structure

An overview of the project structure to help you navigate the codebase:
- `lib/` - Contains the Dart code for the app
  - `models/` - Defines the data models used in the application
  - `view_models/` - Contains the ViewModel classes adhering to the MVVM pattern
  - `views/` - Includes the UI components and screens

## Features

- Send text messages to request image generation
- Display generated images from OpenAI API
- Follows MVVM design pattern for better code organization

## Contributing

We welcome contributions from the community! Follow these steps to contribute:
1. Fork the repository.
2. Create a new branch:
    ```bash
    git checkout -b feature/your-feature-name
    ```
3. Commit your changes:
    ```bash
    git commit -m 'Add some feature'
    ```
4. Push to the branch:
    ```bash
    git push origin feature/your-feature-name
    ```
5. Open a pull request on GitHub.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Acknowledgements

- [Flutter](https://flutter.dev/) for providing the framework.
- [OpenAI](https://openai.com/) for the conversational AI API.

For more information, visit the [project repository](https://github.com/andriyantohalim/image_generation_app).
