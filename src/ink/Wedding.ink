VAR name = ""
VAR nameEntry = ""
VAR nameLowerAlpha = ""
VAR dress = 0 // 1 cocktail, 2 space
VAR validationError = 0

VAR retrying = 0
VAR isAttending = 0
VAR otherNamesEntry = ""
VAR otherNames = ""
VAR emailOrPhoneEntry = ""
VAR emailOrPhone = ""
VAR commentsEntry = ""
VAR comments = ""
-> start
= start
BIOTA, November 1st, 2019
You get out of your car and arrive at the wedding just on time (5pm!) and follow a beautifully trimmed hedgeline up to the entrance.

// hedge? I dunno

-> entry

=== entry ===
A smartly dressed man greets you at the front door.
"Good afternoon! Are you here for the wedding of Jesse and Lillian?" # { "sender": 1 }

+ "I am." # { "sender": 2 }
-> iam
+ "You bet I am!" # { "sender": 2 }
-> iamenthused
+ "I want to skip to the RSVP part" # { "sender": 2 }
-> rsvp


=== iamenthused ===
You gesture with a swingin' thumbs up.

The man smiles.
"That's what I like to hear!" # { "sender": 2 }
-> askName

=== iam ===

You are looking quite serious, not in the mood for much administrivia, and certainly not any games! # { "sender": 0 }

"Well then..." # { "sender": 1 }

His tone suddenly reflects your seriousness.
-> askName

=== askName ===
A clipboard has appeared in the his arms out of nowhere. You wonder if he's some kind of magician?

"Could I please get your name?" # { "sender": 1 }
-> enterName

=== enterName
# { "userInteraction": { "placeholder": "Your name here", "stateVar": "nameEntry", "type": "text", "handler": "nameHandler", "validator": "name" } }
    + \ I'm {name}. # { "sender": 2 }
- {
    - validationError == 0: -> respondName
    - else: -> name_validation_error
}
-> DONE

= name_validation_error
"Sorry? I didn't quite catch that." # { "sender": 1 }
-> enterName

=== respondName

He looks through a list of guests as he mutters to himself
"Hmm, {name}, {name}." # { "sender": 1 }

You wonder why he's taking so long to find your name. Surely it's ordered alphabetically. It's just after {nameLowerAlpha}!

"Oh! Here's {name}, you're {name}." # { "sender": 1 }

He theatrically strikes off your name, then takes a second look at you.

"You did read the dress code, right?" # { "sender": 1 }

+ "Yes, it's cocktail." # { "sender": 2 }
-> cocktail
+ "I did, black tie." # { "sender": 2 }
-> blackTie
+ "Yeah! Space theme!" # { "sender": 2 }
-> spaceTheme

=== cocktail
~ dress = 1

todo: correct choice so reward player. write reaction.

-> enterCeremony

=== blackTie

todo: make fun of player for getting the choice wrong, show game end.

-> start_over

=== spaceTheme
~ dress = 2

You draw down the visor on your helmet. You were wearing a helmet this whole time!
Luckily you are a master of role-play, and decide to put on a voice like you're communicating through a space radio.

"Kch, permissions to enter the wedding Houston. Over. Ksh." # { "sender": 2 }

The man is frozen with his mouth wide open and you think maybe you've made a huge mistake.

+  Wait..
-> spaceReaction

=== spaceReaction

The man seems to reach something behind his neck. He flips up a set of discrete headphones onto his head and extends an earpiece. He flips the clipboard to reveal a panel of many switches and flickering buttons.

"{name}, this is Houston. You are cleared to enter the wedding, over." # { "sender": 1 }

You breath a sigh of relief which partly fogs up your helmet visor adding to the immersion.

Houston opens the door and you head inside!

-> enterCeremony

=== enterCeremony
{dress == 1: It looks black tie optional, everyone looks completely gorgeous and in their element.}

{dress == 2: You can hear the faint bleeps and bloops of space technology as you enter a dark hall. It's hard to see through the thick mist on the floor but it feels like sand beneath your white gumboots (space boots). You begin to walk as if in low-gravity with long slow steps and your cheeks puffed out.}

There seems to be rows of chairs {dress == 1: draped in with floral arrangement.} {dress == 2: covered in space dust.}

// Ceremony, describe: guests, decorations

You see a beautiful lawn with guests happily chatting and laughing. You walk to join them and a few heads turn excitedly toward you but then away again as they realize you're not the bride or groom.

You scan the good-looking crowd and recognise some old friends. As you walk. Someone calls your name:
"{name}! {name}!" # { "sender": 1 }

Oh no, it's your cousin Karen
+ Run
    -> runFromKaren
+ "Heyyy Karen" # { "sender": 2 }
    -> hiKaren

=== runFromKaren
You walk faster. The last time you were caught with Karen at a wedding you missed the whole thing because she wouldn't shut up about her ex-boyfriend Daren.

You cut through a group of good-looking young men, hoping Karen will get distracted like a fish in a net of other good-looking fish.

She's hot on your tail but stops in the net with a faux tumble into the arms of an unsuspecting guy.
"Oh goodness me I'm so sorry!" # { "sender": 1 }
This is a classic Karen move.
"It's these damn heels on the grass ha-ha". # { "sender": 1 }
The man apologies and introduces the guys.

You successfully avoided Karen! 100 points.

You hear quiet voice over a PA system:
"Ladies and Gentlemen would you please be seated as the bride and groom will be arriving shortly." # { "sender": 1 }

-> start_over

=== hiKaren

"{name}! I havent seen you in forever, you look amazing, I love your outfit but it's a bit out there huh? You're so brave! I feel like I made a mistake with these heels, haha" # { "sender": 1 }

todo:  Vows, speak now or forever hold your peace

interrupt to say this wedding's a sham and get killed by guests.

todo:  Begin reception giving dietary requirements
todo:  Meet Jesse and Lil briefly
todo:  Choose kids table or not.
todo:  Eat too much
todo:  Drink too much
todo:  Dancing Hurt yourself
todo:  Dancing impress everyone

todo:  How to finish?
todo:  Choices have cause and effect!

-> start_over

== rsvp
You get a strange urge to look up at the evening sky. You admire the intense natural beauty when a deep, voice comes down from the heavens and a single light shines upon you.

"Hello there, potential wedding guest." # { "sender": 1 }

+ "God?" # { "sender": 2 }
-> rsvpSysAdmin
+ "Mum?" # { "sender": 2 }
-> rsvpSysAdmin

== rsvpSysAdmin
"Ha ha, no." # { "sender": 1 }
The voice booms.
"I am the system administrator for this website! I just have a few questions for you regarding your attendance at Lillian and Jesses' wedding." # { "sender": 1 }
"You will get a chance to change your answers before submitting. So don't worry!" # { "sender": 1 }

-> rsvpName

== rsvpName
- {
    - name != "": -> rsvpNameSure
    - else: -> rsvpNameEntry
}

== rsvpNameEntry
"What is your name?" # { "sender": 1 }
# { "userInteraction": { "placeholder": "Your name here", "stateVar": "nameEntry", "type": "text", "handler": "nameHandler", "validator": "name" } }
    + \ I'm {name}. # { "sender": 2 }
- {
    - validationError == 0 && retrying == 0: -> rsvpAttending
    - validationError == 0 && retrying == 1: -> rsvpCheckForm
    - else: -> rsvpName_validation_error
}
-> DONE

= rsvpName_validation_error
"Sorry? I didn't quite catch that." # { "sender": 1 }
-> rsvpNameEntry

== rsvpNameSure
"You said your name was {name}. Is that right?" # { "sender": 1 }

+ "Yes" # { "sender": 2 }
-> rsvpAttending
+ "No" # { "sender": 2 }
-> rsvpNameEntry

== rsvpAttending
"Are you able to attend the wedding on the 1st November, 2019?" # { "sender": 1 }

+ "Yes" # { "sender": 2 }
-> rsvpAttendingYes
+ "No" # { "sender": 2 }
-> rsvpAttendingNo

== rsvpAttendingYes
~ isAttending = 1
"Wonderful, we can't wait to see you!" # { "sender": 1 }
{ retrying == 0: -> rsvpOnBehalf}
{ retrying == 1: -> rsvpCheckForm}

== rsvpAttendingNo
~ isAttending = 0
"Oh, what a shame! We would have loved to see you." # { "sender": 1 }
{ retrying == 0: -> rsvpOnBehalf}
{ retrying == 1: -> rsvpCheckForm}

== rsvpOnBehalf
"Would you like to respond on behalf of another guest? Or they can play the game themselves." # { "sender": 1 }

+ "Yes" # { "sender": 2 }
-> rsvpOnBehalfYes
+ "No" # { "sender": 2 }
-> rsvpEmailOrPhone

== rsvpOnBehalfYes
"Who are they?" # { "sender": 1 }
# { "userInteraction": { "placeholder": "Their names here", "stateVar": "otherNamesEntry", "type": "text", "handler": "otherNamesHandler", "validator": "name" } }
    + \ They are {otherNames}. # { "sender": 2 }
- {
    - validationError == 0 && retrying == 0: -> rsvpEmailOrPhone
    - validationError == 0 && retrying == 1: -> rsvpCheckForm
    - else: -> otherNames_validation_error
}
-> DONE

= otherNames_validation_error
"Sorry? I didn't quite catch that." # { "sender": 1 }
-> rsvpOnBehalfYes

== rsvpEmailOrPhone
"Please give us a way to contact you with an email or phone number." # { "sender": 1 }
# { "userInteraction": { "placeholder": "Email or phone number here", "stateVar": "emailOrPhoneEntry", "type": "text", "handler": "emailOrPhoneHandler", "validator": "name" } }
    + \ {emailOrPhone}. # { "sender": 2 }
- {
    - validationError == 0 && retrying == 0: -> rsvpComments
    - validationError == 0 && retrying == 1: -> rsvpCheckForm
    - else: -> emailOrPhone_validation_error
}
-> DONE

= emailOrPhone_validation_error
"Sorry? I didn't quite catch that." # { "sender": 1 }
-> rsvpEmailOrPhone

== rsvpComments
"Would you like to make any other comments?" # { "sender": 1 }
+ "Yes" # { "sender": 2 }
-> rsvpCommentsYes
+ "No" # { "sender": 2 }
-> rsvpCheckForm

== rsvpCommentsYes

# { "userInteraction": { "placeholder": "Enter your comment", "stateVar": "commentsEntry", "type": "text", "handler": "commentsHandler", "validator": "name" } }
    + \ {comments}. # { "sender": 2 }
- {
    - validationError == 0: -> rsvpCheckForm
    - else: -> comments_validation_error
}
-> DONE

= comments_validation_error
"Sorry? I didn't quite catch that." # { "sender": 1 }
-> rsvpCommentsYes

== rsvpCheckForm
You are: {name}
You are {isAttending == 0: not} attending the wedding.
- {
  - otherNames != "": You are responding on behalf of: {otherNames}
}
Your Email or Phone number is: {emailOrPhone}
- {
  - comments != "": Your comments: {comments}
}

"Is all that correct?" # { "sender": 1 }

+ "Yes" # { "sender": 2 }
  -> rsvpFinish
+ "No" # { "sender": 2 }
  -> rsvpEdit

== rsvpEdit
~ retrying = 1
"What would you like to edit?" # { "sender": 1 }
+ "My Name" # { "sender": 2 }
 -> rsvpName
+ "My attendance" # { "sender": 2 }
 -> rsvpAttending
+ "Other names" # { "sender": 2 }
 -> rsvpOnBehalf
+ "My email or phone number" # { "sender": 2 }
 -> rsvpEmailOrPhone
+ "My comments" # { "sender": 2 }
 -> rsvpComments

== rsvpFinish
~ retrying = 0
"I have saved your RSVP information. Thanks so much for playing!" # { "sender": 1 }

-> start_over

== start_over
- Want to start over?
    + Sure. # { "sender": 1 }
      -> start
    + Take me straight to the RSVP part. # { "sender": 1 }
    -> rsvp
    + No, thank you. # { "sender": 1 }
-> END