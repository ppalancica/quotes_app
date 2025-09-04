# quotes_app

Quotes App project.

## Prerequisites

Make sure you have the following installed:

- Flutter SDK: Install Flutter: https://docs.flutter.dev/get-started/install

- VS Code: Install VS Code: https://code.visualstudio.com/

- Flutter & Dart extensions for VS Code:

    Open VS Code. Go to Extensions (Ctrl+Shift+X) Search for Flutter and install it (it will also install Dart automatically)

## Project Opening Instructions

This project is a Flutter application. It was written in VS Code. It can be run on iOS Simulator. Android is not supported yet.

To open it in Visual Studio Code (VS Code), follow these steps:

- Launch VS Code
- Go to File > Open Folder...
- Select the root folder of your Flutter project (the one with pubspec.yaml)
- Click "Open"
- Once open, if prompted, click "Get packages" or run flutter pub get

## Project Running Instructions

- Make sure a device/emulator is running.
- Use flutter devices in terminal to check.
- Or start an emulator from the Device Selector in the VS Code status bar.
- Press F5 or click Run > Start Debugging to run the app.

## Architecture

I've implemented a simple architecture, with Views, Services, Loaders, Model, and Provider. I applied Dependency Injection to both screens.
The components are divided in multiple folders inside 'lib' folder:

- loaders   (favorites_local_loader.dart, quotes_local_loader.dart)
- models    (quote.dart)
- providers (quotes_provider.dart)
- screens   (favorites_screen.dart, quotes_screen.dart)
- services  (quotes_service.dart)
- widgets   (quote_row.dart)

Quote is a plain class matching all the required properties coming from the Quotes API (id, quote, author), plus an additional isFavorite property (since we need it for implementing the Favorites feature, but it's not Quotes API related).

The FavoritesLocalLoader and QuotesLocalLoader classes work with local data.

The QuotesService class fetches data from the Quotes API and converts it to a List of Quotes.

The QuotesScreen and FavoritesScreen are used create a tabbed navigation. They both use the QuoteRow widget to display a quote in the list. QuotesScreen is also integrated with Search by Text or Author functionality (it does a basic filtering, no text highlighting).

QuotesProvider interacts with the loaders and the API service and keeps things in sync. It is injected to both screens and changes on one screen should be reflected immediately on the other. We can think of it as an AppState or a State Controller class.

## Technologies used

I've chose to use 'http' package because I needed to interact with the Quotes API via the HTTP Protocol.

I've used the 'connectivity_plus' package because I wanted to have an easy way of checking if connection is available.

I've used the 'provider' package because I needed to use Dependency Injection and implement some basic State Management so that the related UI updates automatically when related Model change are done on a different screen.

I've closed the 'shared_preferences' package because I've used the SharedPreferences for Local Storage when I've implemented Quotes Caching and Favorites features. (Note that in a production app, especially when the number of quotes are much bigger or we want to add pagination - I would use something different, such as SQLite or something that scales better, but for small data sets, using SharedPreferences also works fine).
