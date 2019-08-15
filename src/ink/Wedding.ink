VAR name = ""
VAR nameEntry = ""
VAR nameLowerAlpha = ""
VAR dress = 0 // 1 blackTieOptional, 2 space
VAR age = 0
VAR birthday = "06/16/1989"
VAR validationError = 0

BIOTA, November 1st, 2019
You get out of your car and arrive at the wedding just on time (5pm!) and follow a beautifully trimmed hedgeline up to the entrance.
// hedge? I dunno

-> entry

=== entry ===
A smartly dressed man greets you at the front door.
"Good afternoon! Are you here for the wedding of Jesse and Lillian?" # { "sender": 1 }

+ "I am."    -> iam
+ "You bet I am!"    -> iamenthused # { "sender": 2 }


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
"Hmm, {name}, {name}, {name}" # { "sender": 1 }

You wonder why he's taking so long to find your name. I mean, surely it's all alphabetical. It's just after {nameLowerAlpha}!

"Oh great! {name}! Here's {name}, you're {name}." # { "sender": 1 }

He theatrically strikes off your name, then takes a second look at you.

"You did read the dress code, right?"

+ "Yes, it's black tie optional." # { "sender": 2 }
-> blackTieOptional
+ "I did, black tie." # { "sender": 2 }
-> blackTie
+ "Yeah! Space theme!" # { "sender": 2 }
-> spaceTheme

=== blackTieOptional
~ dress = 1
// this is right, but missing Reaction

-> END

=== blackTie
// this is incorrect, so END

-> END


=== spaceTheme
~ dress = 2

You draw down the visor on your helmet which you were wearing this whole time.
Luckily you are a master of role-play, and decide to put on a voice like you're communicating through a space radio.

"Kch, permissions to enter the wedding Houston. Over. Ksh."

The man is frozen with his mouth wide open and you think maybe you've made a huge mistake.

+  Wait..
-> spaceReaction

=== spaceReaction

The man seems to reach something behind his neck. He flips up a set of discrete headphones onto his head and extends an earpiece. He flips the clipboard to reveal a panel of many switches and flickering buttons.

"{name}, this is Houston. You are cleared to enter the wedding, over."

You breath a sigh of relief which partly fogs up your helmet visor adding to the immersion.

Houston opens the door and you head inside!

-> enterCeremony

=== enterCeremony


{dress == 1: It looks black tie optional, everyone looks completely gorgeous and in their element.}

{dress == 2: You can hear the faint bleeps and bloops of space technology as you enter a dark hall. It's hard to see through the thick mist on the floor but it feels like sand beneath your white gumboots (space boots). Assuming this is an alien planet, you begin to walk as if in low-gravity.}


There seems to be rows of chairs {dress == 1: draped in with floral arrangement.}{dress == 2: covered in space dust.}


// Ceremony, describe: guests, decorations

You see a beautiful lawn with guests happily chatting and laughing. You walk to join them and a few heads turn excitedly toward you but then away again as they realize you're not the bride or groom.

You scan the good-looking crowd and recognise some old friends. As you walk. Someone calls your name:
"{name}! {name}!"

Oh no, it's your cousin Karen
+ Run
    -> runFromKaren
+ "Heyyy Karen"
    -> hiKaren

=== runFromKaren
You walk faster. The last time you were caught with Karen at a wedding you missed the whole thing because she wouldn't shut up about her ex-boyfriend Daren.

You cut through a group.of good-looking young men, hoping Karen will get distracted like a fish in a net of other good-looking fish.

She's hot on your tail but stops in the net with a faux tumble into the arms of an unsuspecting guy. "Oh goodness me I'm so sorry!"
This is a classic Karen move.
"It's these damn heels on the grass ha-ha". The man apologies and introduces the guys.

You successfully avoided Karen! 100 points.

You hear quiet voice over a PA system:
"Ladies and Gentlemen would you please be seated as the bride and groom will be arriving shortly.

-> END

=== hiKaren

"Heyyyy Karen" You smile.

"{name}! I havent seen you in forever, you look amazing, I love your outfit, I feel like I made a mistake with these heels, haha"

// Vows, speak now or forever hold your peace

// interrupt to say this wedding's a sham and get killed by guests.

// Begin reception giving dietary requirements
// Meet Jesse and Lil briefly
// Choose kids table or not.
// Eat too much
// Drink too much
// Dancing Hurt yourself
// Dancing impress everyone

// How to finish?
// Choices have cause and effect!

-> END