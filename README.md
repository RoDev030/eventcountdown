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
 a. listview ombouwen naar pageview zodat het er beter uitziet
3. Countdowntimer tijd op laten halen uit Hive
a. beperken tot seconden ipv kleinere aantallen
4. Container achtergrond op laten halen uit hive (done)


Non-prio:
1. Je kan het scherm nog steeds verlaten als er data in staat >> popscope uitbreiden of onderzoeken hoe dit tegen kan worden gehouden
2. Orientatie blokkeren. We doen niet aan landscape losers
3. Als je vanuit add event de app verlaat en dat doet via de pop scope melding staat de drawer nog open
4. transitie tussen schermen heeft nog geen animatie (wel echt een basic chille functie)
5. flutter ndk hardcoded for ndkVersion = "27.0.12077973"
6. extract gesture detector from eventcard

bool hasChanges() {
    return _nameController.text.isNotEmpty ||
        _dateController.text.isNotEmpty ||
        _timeController.text.isNotEmpty ||
        _locationController.text.isNotEmpty ||
        _descriptionController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    //add warning if user tries to leave without saving
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }

        if (hasChanges()) {
          final shouldDiscard = await showDialog<bool>(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Discard changes?'),
                  content: const Text(
                    'Are you sure you want to discard your changes?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Discard'),
                    ),
                  ],
                ),
          );

          if (shouldDiscard == true) {
            Navigator.of(context).pop(); // Go back to previous screen.
          }
        } else {
          Navigator.of(context).pop(); // Go back to previous screen.
        }
      },
