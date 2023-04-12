# Health-GPT
Health-GPT is an iOS chat app that uses a GPT model to provide health-related answers. The app is built with Swift and uses the OpenAI GPT-3 API to generate responses to user queries. This repository contains the source code for the iOS app.


[![](https://github.com/dhairyachandra/Health-GPT/blob/main/Screenshots/App_Screens.png)](https://github.com/dhairyachandra/Health-GPT/blob/main/Screenshots/App_Screens.png)

Blog: [Health-GPT: An iOS App Powered by OpenAI](https://medhairya.com/health-gpt/)

## Features
- Easy to use chat interface.
- Provides health-related answers.
- Uses GPT-3 API to generate responses.

## Installation
To use the app, you will need an API key from OpenAI. Once you have the API key, you can replace the YOUR_API_KEY constant in the 
**"Health-GPT/HealthGPT/Constants.swift"** file with your own key.


`static let openAIAPIKey = "[ENTER API KEY]"`

## Usage
To start using the app, simply run it on your iOS device or simulator. You will be presented with a chat interface where you can enter your health-related queries. The app will use the GPT-3 API to generate responses to your queries.

`OpenAICompletionsBody(model: "text-davinci-003", prompt: message, temperature: 0.7, max_tokens: 256)`

## Contributing
Contributions to the project are welcome. If you find any bugs or have any feature requests, please create an issue on the [GitHub repository](https://github.com/dhairyachandra/Health-GPT/issues "GitHub repository").

## License
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT "MIT License").
