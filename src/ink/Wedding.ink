VAR name = "JesseTest"
VAR nameEntry = ""
VAR nameLowerAlpha = ""
VAR dress = 0 // 1 cocktail, 2 space
VAR validationError = 0
VAR backUnlocked = 0

VAR retrying = 0
VAR isAttending = 0
VAR otherNamesEntry = ""
VAR otherNames = ""
VAR emailOrPhoneEntry = "0123"
VAR emailOrPhone = "0123"
VAR commentsEntry = ""
VAR comments = ""
VAR dietEntry = ""
VAR diet = ""
// -> start
// = start
// + [Start]
-> start
== start
<strong>BIOTA, 1st November, 2019</strong>
It is an amazing spring afternoon in the southern highlands of New South Wales. The drive was easier than you expected.
The clock on the dashboard reads 4:30PM, just in time! You leave the car as you fix yourself up and look for where to go. There is a beautifully trimmed hedgeline which follows a path.
+ [Walk to entrance]
You head to the entrance
-> entry

=== entry ===
A smartly dressed man greets you at the front door.
<img src="assets/images/dom-212x381.png">
<strong>Good afternoon!</strong> Are you here for the wedding of Jesse and Lillian? # { "sender": 1 }

+ I am. # { "sender": 2 }
-> iam
+ You bet I am! # { "sender": 2 }
-> iamenthused
+ I want to skip to the RSVP part # { "sender": 2 }
-> rsvp

=== iamenthused ===
You gesture with a swingin' thumbs up.
The man smiles.
That's what I like to hear! # { "sender": 1 }
-> askName

=== iam ===
You are looking quite serious, not in the mood for much administrivia, and certainly not any games! # { "sender": 0 }
Well then... # { "sender": 1 }
His tone suddenly reflects your seriousness.
-> askName

=== askName ===
A clipboard has appeared in the his arms out of nowhere. You wonder if he's some kind of magician?
Could I please get your name? # { "sender": 1 }
-> enterName

=== enterName
# { "userInteraction": { "placeholder": "Enter your name...", "stateVar": "nameEntry", "type": "text", "handler": "nameHandler", "validator": "name" } }
    + \ I'm {name}. # { "sender": 2 }
- {
    - validationError == 0: -> respondName
    - else: -> name_validation_error
}
-> DONE

= name_validation_error
Sorry? I didn't quite catch that. # { "sender": 1 }
-> enterName

=== respondName
# { "cmd": "START_SEND_CHOICES" }
Hmm, {name}, {name}. # { "sender": 1 }
He looks through a list of guests as he mutters to himself. You wonder why he's taking so long to find your name. Surely it's ordered alphabetically. It's just after {nameLowerAlpha}!
  * [...]
- Oh! Here's {name}, you're {name}. # { "sender": 1 }
He theatrically strikes off your name, then takes a second look at you.
You did read the dress code, right? # { "sender": 1 }
+ Yes, it's cocktail. # { "sender": 2 }
-> cocktail
+ I did, black tie. # { "sender": 2 }
-> blackTie
+ Yeah! Space theme! # { "sender": 2 }
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
Kch, permissions to enter the wedding Houston. Over. Ksh. # { "sender": 2 }
The man is frozen with his mouth wide open and you think maybe you've made a huge mistake.
+  [Wait]
You wait a second.
-> spaceReaction

=== spaceReaction
<img src="assets/images/Space.png"/>
The man seems to reach something behind his neck. He flips up a set of discrete headphones onto his head and extends an earpiece. He flips the clipboard to reveal a panel of many switches and flickering buttons.
{name}, this is Houston. You are cleared to enter the wedding, over. # { "sender": 1 }
  * [Phewf]
- You breath a sigh of relief which partly fogs up your helmet visor adding to the immersion.
Houston opens the door and you head inside!
-> enterCeremony

=== enterCeremony
{dress == 1: It looks black tie optional, everyone looks completely gorgeous and in their element.}
{dress == 2: You can hear the faint bleeps and bloops of space technology as you enter a dark hall. It's hard to see through the thick mist on the floor but it feels like sand beneath your white gumboots (space boots). You begin to walk as if in low-gravity with long slow steps and your cheeks puffed out.}
  * [Look around]
- There seems to be chairs {dress == 1: draped in with floral arrangement.} {dress == 2: covered in space dust.}
You see a beautiful lawn with guests happily chatting and laughing. You walk to join them and a few heads turn excitedly toward you but then away again as they realize you're not the bride or groom.
You scan the good-looking crowd and recognise some old friends. As you walk. Someone calls your name:
{name}! {name}! # { "sender": 1 }

Oh no, it's your cousin Karen
+ [Run]
    -> runFromKaren
+ Heyyy Karen # { "sender": 2 }
    -> hiKaren

=== runFromKaren
You walk faster. The last time you were caught with Karen at a wedding you missed the whole thing because she wouldn't shut up about her ex-boyfriend Daren.
You cut through a group of good-looking young men, hoping Karen will get distracted like a fish in a net of other good-looking fish.
  * [Lose her in the crowd]
- She's hot on your tail but stops in the net with a faux tumble into the arms of an unsuspecting guy.
Oh goodness me I'm so sorry! # { "sender": 1 }
This is a classic Karen move.
It's these damn heels on the grass ha-ha. # { "sender": 1 }
The man apologies and introduces the guys.
You successfully avoided Karen!
  * Yay! How many points do I get? # { "sender": 2 }
  - Oh let's say: 100 points.
  * Woo hoo! # { "sender": 2 }
-> takeSeats

=== hiKaren
{name}! I havent seen you in forever, you look amazing, I love your outfit but it's a bit out there huh? You're so brave! I feel like I made a mistake with these heels, haha # { "sender": 1 }
Karen is a sweetheart but you think the backwards compliments are a bit much.
-> takeSeats

== takeSeats
You hear an announcement:
Ladies and Gentlemen would you please be seated as the bride and groom will be arriving shortly. # { "sender": 1 }
You approach the garden to find a lush lawn with chairs arranged in an arc around a table adorned with flowers.
- You realise there are no names on the chairs! Where will you sit?
*   [At the front, I'm family!]
    You take a seat in the front aisle. Close family begins to sit near you, you feel right at home because you are family! You spend the ceremony quitely chatting to various uncle's and aunties.
*   [In the middle, I'm a friend!]
    You take a seat in the middle. Familiar friends sit around you and excitedly reunite. Of course, Karen decides to sit next to you and talks your ear off.
*   [Stand in the aisle like a statue.]
    -> statue
- The celebrant is a lovely woman who speaks up with a booming voice! Oh, that's not her voice, it's just very good outdoor speakers.
[Note]: Allegra picture here.
"Hello everyone, I'm Allegra and I'll be your celebrant for the evening. Thank you all for joining us on such a wonderful afternoon! The guests of honor are just arriving now." # { "sender": 1 }

  * [Turn around]
- You hear Karen scream:
Awwwmigooosh here they come! Ahhhh! # { "sender": 1 }
Sure enough, Jesse and Lillian both appear in turn with various mothers and fathers in tow. But let's be honest, this game is about you, not them. So lets gloss over this part.
The ceremony is a wonderful creative affair with just a hint of sprituality and a whole lot of love. The rings are given, vows are made.
  * [Aww, this is all very nice.]
- Finally, Allegra says:
Should anyone here present know of any reason that this couple should <strong>not</strong> be joined, speak now or forever hold your peace. # { "sender": 1 }
  * "Um, actually." # { "sender": 2 }
  -> umactually
  * [Keep your mouth shut]
- A stunned silence falls on the crowd.

- You may now kiss the bride! # { "sender": 1 }
Kissing ensues.
[Note]: Insert kissing picture here. Lillian: No.
  * Hooray! # { "sender": 2 }
- The celebrations continue into the evening until it's time to eat!
You enter the Biota resturant interior and see a few tables and chairs, but you're wondering where to sit!
  * We already did the seating thing.
- Yeah I know, let me finish.
 * [...]
- As I was saying...
You see tables, with a broad selection of foods available! It seems to be a cocktail style dinner with big food stations around the room so you can enjoy what you like.
There's a meat station with beef and pork cuts; A seafood station with sushi; and many others!
<img src="assets/images/Diet.png"/>
A small child appears at your feed with a non-specific food item in hand, offering it to you.
  * Thanks but I'm vegetarian # { "sender": 2 }
  ~ diet = "vegetarian"
  * Thanks but I'm vegan # { "sender": 2 }
  ~ diet = "vegan"
  * Thanks but I'm allergic # { "sender": 2 }
  Oh what are you allergic to? # { "sender": 1 }
  -> otherallergy
 * Thanks! # { "sender": 2 }
- You take the food and it's delicious.
-> eatfood

== otherallergy
# { "userInteraction": { "placeholder": "Enter your allergy...", "stateVar": "dietEntry", "type": "text", "handler": "dietHandler", "validator": "diet" } }
    + \ {diet}. # { "sender": 2 }
- {
    - validationError == 0: -> finishdiet
    - else: -> diet_validation_error
}
-> DONE

= diet_validation_error
Sorry? I didn't quite catch that. # { "sender": 1 }
-> otherallergy

== finishdiet
Wow! Lucky you told me because this is a sandwitch made entirely of {diet}. # {"sender": 1}
The elequent child scurries away.
-> eatfood

== eatfood
You enjoy the food and the company, meeting all the relatives and friends of the wedding. Lauging and drinking maybe too much, but hey, it's a wedding!
You hear some loud music and realize that a dancefloor is forming.
  * [Join the dancing]
  -> dance
  * [Eat and drink more]
  -> drink1

== drink1
You continue to enjoy the limitless champagne and food. It seems to get even more delicious the more you have!
The music is getting louder and more guests join the dancefloor.
  * [Join the dancing]
  -> dance
  * [Eat and drink more]
  -> drink2

== drink2
You notice that there isn't just champagne but also a selection of wine and beers!
  * [Try them all!]
- You try them all! Why not?
A few mintues pass (2 hours in reality) and you decide it's finally time to hit the dancefloor.
* [Step aside losers! Here's how you dance!]
- Tthepasside losers! Ith dance time for me woooooO! # { "sender": 2 }
You stumble onto the dance floor and the music is pumping.
You do your signature move: The Fall-flat-on-face.
  * [Ow]
- The next thing you remember is waking up on the lawn and your head is splitting. Some kind soul must have dragged you off the dancefloor. Lucky you were able to pull off your special move before you passed out, but your drunken stupor made you miss half the wedding!

THE END.
-> start_over

== dance
todo: dancing and a professional dancer wants your contact information.
todo:  Dancing impress everyone

todo:  How to finish?
todo:  Choices have cause and effect!

-> start_over

-> END

== statue
You don't have time for seats. Life as a professional living statue has left you with a lust for stillness and you will be satisfied!
- You stand in the aisle, right in the center. You twist one of your arms up the the sky and the other rests on your hip as if delivering an enthusiastic speech worthy of divine audience. No one is brave enough to interrupt an episode such as this and so they sit there, weirded out.
  * [Keep standing]
- The ceremony goes on around you, flower girls throw their baskets at you while you remain flinchless.
  * [Keep standing]
- You remain a statue for the rest of the wedding, well into the night, even as the lasts guests leave.
Finally, you are satisfied, but at what cost {name}? At what cost...
THE END.

-> start_over

== umactually
Look, I just think we should all take a breather on this. I'm not totally convinced these two are in love enough to.. # { "sender": 2 }
You are interrupted when a flying shoe hits you in the head, knocking you out!
  * [A shoe?]
- Karen stands up.
Oh sorry! Whoops! It's these damn heels what a crazy accident. Don't worry everyone. I can take them in an ambulance. Bye! # { "sender": 1 }
Just like that, you are whisked away in an ambulance with Karen. No chance to interrupt the wedding anymore, what a shame.
THE END.

-> start_over

// RSVP PART HERE:
== rsvp
You get a strange urge to look up at the evening sky. You admire the intense natural beauty when a deep voice comes down from the heavens and a single light shines upon you.

Hello there, potential wedding guest. # { "sender": 1 }

+ Conscience? # { "sender": 2 }
-> rsvpSysAdmin
+ Mum? # { "sender": 2 }
-> rsvpSysAdmin

== rsvpSysAdmin
Ha ha, no. # { "sender": 1 }
The voice booms.
I am the system administrator for this website! I just have a few questions for you regarding your attendance at Lillian and Jesses' wedding. # { "sender": 1 }
You will get a chance to change your answers before submitting. So don't worry! # { "sender": 1 }

-> rsvpName

== rsvpName
- {
    - name != "": -> rsvpNameSure
    - else: -> rsvpNameEntry
}

== rsvpNameEntry
What is your name? # { "sender": 1 }
# { "userInteraction": { "placeholder": "Your name here", "stateVar": "nameEntry", "type": "text", "handler": "nameHandler", "validator": "name" } }
    + \ I'm {name}. # { "sender": 2 }
- {
    - validationError == 0 && retrying == 0: -> rsvpAttending
    - validationError == 0 && retrying == 1: -> rsvpCheckForm
    - else: -> rsvpName_validation_error
}
-> DONE

= rsvpName_validation_error
Sorry? I didn't quite catch that. # { "sender": 1 }
-> rsvpNameEntry

== rsvpNameSure
You said your name was {name}. Is that right? # { "sender": 1 }

+ Yes # { "sender": 2 }
-> rsvpAttending
+ No # { "sender": 2 }
-> rsvpNameEntry

== rsvpAttending
Are you able to attend the wedding on the 1st November, 2019? # { "sender": 1 }

+ Yes # { "sender": 2 }
-> rsvpAttendingYes
+ No # { "sender": 2 }
-> rsvpAttendingNo

== rsvpAttendingYes
~ isAttending = 1
Wonderful, we can't wait to see you! # { "sender": 1 }
{ retrying == 0: -> rsvpOnBehalf}
{ retrying == 1: -> rsvpCheckForm}

== rsvpAttendingNo
~ isAttending = 0
Oh, what a shame! We would have loved to see you. # { "sender": 1 }
{ retrying == 0: -> rsvpOnBehalf}
{ retrying == 1: -> rsvpCheckForm}

== rsvpOnBehalf
Would you like to respond on behalf of another guest? Or they can play the game themselves. # { "sender": 1 }

+ Yes # { "sender": 2 }
-> rsvpOnBehalfYes
+ No # { "sender": 2 }
-> rsvpEmailOrPhone

== rsvpOnBehalfYes
Who are they? # { "sender": 1 }
# { "userInteraction": { "placeholder": "Their names here", "stateVar": "otherNamesEntry", "type": "text", "handler": "otherNamesHandler", "validator": "name" } }
    + \ They are {otherNames}. # { "sender": 2 }
- {
    - validationError == 0 && retrying == 0: -> rsvpEmailOrPhone
    - validationError == 0 && retrying == 1: -> rsvpCheckForm
    - else: -> otherNames_validation_error
}
-> DONE

= otherNames_validation_error
Sorry? I didn't quite catch that. # { "sender": 1 }
-> rsvpOnBehalfYes

== rsvpEmailOrPhone
Please give us a way to contact you with an email or phone number. # { "sender": 1 }
# { "userInteraction": { "placeholder": "Email or phone number here", "stateVar": "emailOrPhoneEntry", "type": "text", "handler": "emailOrPhoneHandler", "validator": "emailOrPhone" } }
    + \ {emailOrPhone}. # { "sender": 2 }
- {
    - validationError == 0 && retrying == 0: -> rsvpComments
    - validationError == 0 && retrying == 1: -> rsvpCheckForm
    - else: -> emailOrPhone_validation_error
}
-> DONE

= emailOrPhone_validation_error
Sorry? I didn't quite catch that. # { "sender": 1 }
-> rsvpEmailOrPhone

== rsvpComments
Would you like to make any other comments? # { "sender": 1 }
+ Yes I do # { "sender": 2 }
-> rsvpCommentsYes
+ No # { "sender": 2 }
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
Sorry? I didn't quite catch that. # { "sender": 1 }
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

Is all that correct? # { "sender": 1 }

+ Yes # { "sender": 2 }
  -> rsvpFinish
+ No # { "sender": 2 }
  -> rsvpEdit

== rsvpEdit
~ retrying = 1
What would you like to edit? # { "sender": 1 }
+ Name # { "sender": 2 }
 -> rsvpName
+ Attendance # { "sender": 2 }
 -> rsvpAttending
+ Other names # { "sender": 2 }
 -> rsvpOnBehalf
+ Email or phone # { "sender": 2 }
 -> rsvpEmailOrPhone
+ Comments # { "sender": 2 }
 -> rsvpComments
 + All fine # { "sender": 2 }
 -> rsvpFinish

== rsvpFinish
~ retrying = 0
# { "cmd": "SUBMIT_RSVP" }
I have saved your RSVP information. Thanks so much for playing! # { "sender": 1 }

-> start_over

== start_over
- Want to start over?
    + [Yes please.] -> backUnlockThenStart
    + No, thank you. # { "sender": 2 }
      You're welcome, thanks for playing!
      -> END
    + [I want to skip this silliness and RSVP.]
    -> rsvp

== backUnlockThenStart
~ backUnlocked = 1
Something feels a bit different, like an option has been unlocked to "Go Back"? How perculiar.
# {"cmd": "BACK_UNLOCK"}
  + Oh, good! I can see the button up the top.
    # { "cmd": "RESET" }
    -> start