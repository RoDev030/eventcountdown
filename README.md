# eventcountdown

This is a app which allows you to setup an event countdowntimer with a name, date, time, description and location

optionally you can add an image to use as a background

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## bestaande problematiek
Prio:
1. Afbeelding opslaan in Hive (done)
    a. opruimen add_event_screen (done)
2. Countdowntimer bouwen op homepage
3. Countdowntimer tijd op laten halen uit Hive
4. Container achtergrond op laten halen uit 


Non-prio:
1. Je kan het scherm nog steeds verlaten als er data in staat >> popscope uitbreiden of onderzoeken hoe dit tegen kan worden gehouden
2. Orientatie blokkeren. We doen niet aan landscape losers
3. Als je vanuit add event de app verlaat en dat doet via de pop scope melding staat de drawer nog open
4. transitie tussen schermen heeft nog geen animatie (wel echt een basic chille functie)

