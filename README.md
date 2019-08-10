# Wedding RSVP fork 💍

This is a fork to re-design neoskop's awesome chat bot into an interactive rsvp form for a wedding.

# Chatbot with Angular and Ink

Learn more about the project here: [https://www.neoskop.de/blog/simple-chatbots-with-angular-and-ink](https://www.neoskop.de/blog/simple-chatbots-with-angular-and-ink)

### Demo

https://sqrrl.github.io/angular-ink-chatbot/

### Quickstart

Verify that you are running at least node 7 and npm 4 by running node -v and npm -v in a terminal/console window.

```bash
$ npm install
$ npm start
```

This will start the application on port 3000.

### Build for production

```bash
$ npm install
$ npm build
```

This creates/updates the bundled files, stored in the build directory.

### Update Ink

The story file is located under *src/ink/story.ink*.

On a Mac:
```bash
$ npm run ink
```

Otherwise use Inky to export the story.ink file as JSON, or download inklecate for your OS from
[https://github.com/inkle/ink](https://github.com/inkle/ink).