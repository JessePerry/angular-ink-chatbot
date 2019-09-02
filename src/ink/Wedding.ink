VAR name = "JesseTest"
VAR nameEntry = ""
VAR nameLowerAlpha = ""
VAR dress = 0 // 1 cocktail, 2 space
VAR validationError = 0
VAR backUnlocked = 0
VAR dance = ""

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
It is an amazing Spring afternoon in the southern highlands of New South Wales. The drive was easier than you expected.
The clock on the dashboard reads 4:30PM, just in time! You leave the car as you fix yourself up and look for where to go. There is a beautifully trimmed hedge-line which follows a path.
+ [Walk to entrance]

You head to the entrance
-> entry

=== entry ===
<img src="assets/images/Biota.png">
  * [...]
- A smartly dressed man greets you at the front door.
<img src="assets/images/dom-212x381.png">
<strong>Good afternoon!</strong> Are you here for the wedding of Lillian and Jesse? # { "sender": 1 }

+ I am. # { "sender": 2 }
-> iam
+ You bet I am! # { "sender": 2 }
-> iamenthused

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
That's right and I can see you're dressed appropriately and might I also say, quite fashionably? # { "sender": 1 }
  * Oh thank you. # { "sender": 2 }
You chose the correct dress code! Thanks for reading the invitation. If this was a point scoring game then you’d have 10 points.
-> enterCeremony

=== blackTie
Actually I'm afraid that it is not black tie. You must be looking for another wedding. # { "sender": 1 }
  * But I'm all dressed up! # { "sender": 2 }
Sorry, but that's game over for you. Don't worry, this is a game and you can try again. # { "sender": 1 }

You are rejected at the door and didn't make it to the wedding!
THE END.
-> start_over

=== spaceTheme
~ dress = 2
You draw down the visor on your helmet. You were wearing a helmet this whole time!
Luckily you are a master of role play, and decide to put on a voice like you're communicating through a space radio.
Kch, permissions to enter the wedding Houston. Over. Ksh. # { "sender": 2 }
The man is frozen with his mouth wide open and you think maybe you've made a huge mistake.
+  [...]
You wait a second.
-> spaceReaction

=== spaceReaction
<img src="assets/images/Space.png"/>
The man seems to reach something behind his neck. He flips up a set of discrete headphones onto his head and extends an earpiece. He flips the clipboard to reveal a panel of many switches and flickering buttons.
{name}, this is Houston. You are cleared to enter the wedding, over. # { "sender": 1 }
  * [Phewf]
- You breath a sigh of relief which partly fogs up your helmet visor.
Houston opens the door and you head inside!
-> enterCeremony

=== enterCeremony
{dress == 1: As a cocktail dress code, everyone looks completely gorgeous and in their element.}
{dress == 2: You can hear the faint bleeps and bloops of space technology as you enter a dark hall. It's hard to see through the thick mist on the floor but it feels like sand beneath your white space boots. You begin to walk as if in low-gravity with long slow steps and your cheeks puffed out.}
  * [Look around]
- There seem to be chairs {dress == 1: draped in a floral arrangement.} {dress == 2: covered in space dust.}
Guests chat and mill around happily on the sweeping green lawn. You walk to join them and a few heads turn excitedly toward you but then away again as they realize you're not the bride or groom.
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
- She's hot on your tail but falls hook, line and sinker for your clever tactic. She theatrically tumbles into the arms of an unsuspecting guy.
Oh goodness me I'm so sorry! # { "sender": 1 }
This is a classic Karen move.
It's these damn heels on the grass ha-ha. # { "sender": 1 }
The man apologies and introduces the guys.
You successfully avoided Karen!
  * Yay! How many points do I get? # { "sender": 2 }
  - Oh, let's say: 100 points.
  * Woo hoo! # { "sender": 2 }
-> takeSeats

=== hiKaren
{name}! I haven’t seen you in forever, you look amazing, I love your outfit but it's a bit out there huh? You're so brave! I feel like I made a mistake with these heels, haha. # { "sender": 1 }
Karen is a sweetheart but you think the backhanded compliments are a bit much.
-> takeSeats

== takeSeats
You hear an announcement:
Ladies and Gentlemen would you please be seated as the bride and groom will be arriving shortly. # { "sender": 1 }
- You hear Karen scream:
Awwwmigooosh here they come! Ahhhh! # { "sender": 1 }
Sure enough, Lillian and Jesse both appear in turn with various bridesmaids and groomsmen in tow. But let's be honest, this game is about you, not them. So let's gloss over this part.
The ceremony is a wonderful creative affair with just a hint of spirituality and a whole lot of love. The rings are given, vows are made, you definitely cried at some point (possibly due to Karen stepping on your foot in her heels).
  * [Aww, this is all very nice.]
- The celebrations continue into the evening until it's time to eat!
 * [...]
- You see tables with a broad selection of foods available! It seems to be a cocktail style dinner with big food stations around the venue so you can enjoy what you like.
There's a wide range of delicious delicacies - a meat station; a seafood station; and many others!
<img src="assets/images/Diet.png"/>
As you hungrily survey the room you suddenly remember
  *I'm vegetarian # { "sender": 2 }
  ~ diet = "vegetarian"
  *I'm vegan # { "sender": 2 }
  ~ diet = "vegan"
  * I have a food allergy # { "sender": 2 }
  Oh what are you allergic to?
  -> otherallergy
  * I can eat whatever I want! # { "sender": 2 }
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
Wow! Lucky you told me because this is a sandwich made entirely of {diet}. # {"sender": 1}
-> eatfood

== eatfood
You enjoy the food and the company, meeting all the relatives and friends of the wedding. Laughing and drinking maybe too much, but hey, it's a wedding!
You hear some loud music and realize that a dance-floor is forming.
  * [Join the dancing]
  -> dancefloor
  * [Eat and drink more]
  -> drink1

== drink1
You continue to enjoy the limitless champagne and food. It seems to get even more delicious the more you have!
The music is getting louder and more guests join the dance-floor.
  * [Join the dancing]
  -> dancefloor
  * [Eat and drink more]
  -> drink2

== drink2
You notice that there isn't just champagne but also a selection of wine and beers!
  * [Try them all!]
- You try them all! Why not?
A few minutes pass (3 hours in reality) and you decide it's finally time to hit the dance-floor.
* [Step aside losers! Here's how you dance!]
- Tsthepasside losers! Ith dance time for me woooooO! # { "sender": 2 }
You stumble onto the dance floor and the music is pumping.
You do your signature move: The Fall-flat-on-face.
  * [Ow]
- The next thing you remember is waking up on the lawn and your head is splitting. Some kind soul must have dragged you off the dancefloor. Lucky you were able to pull off your special move before you passed out. But your drunken stupor made you miss half the wedding!

THE END.
-> start_over

== dancefloor
The dance-floor is heaving with hits from the 90's.
  * Shuffle to the DJ booth
    You shuffle and swing your way through the crowd to the DJ booth.
    * * Play Jesse's Girl! # {"sender": 2 }
      The DJ doesn't have time to respond because a shoe comes flying through the air, hitting you in the head!
      Jesse yells over the crowd:
      Don't play that song! And sorry about the shoe! # { "sender": 1 }
      Dejected. You swing back to the dance-floor.
    * * [Compliment the DJ]
      You yell:
      This is a really good song list and you're doing a great job! # { "sender": 2 }
      Thank you! The couple put in a lot of effort to please the crowd and thanks for respecting their taste by not requesting a song!  # { "sender": 1 }
      Back to the dancefloor.
  * Swing to the center floor
    You swing and shuffle through the crowd to the centre of the dance-floor
- Time for your signature move:
  * The Two-step
    ~ dance = "Two-step"
    You step once. You step twice!
  * The Microwave
    ~ dance = "Microwave"
    You play charades for a moment, pressing buttons on an invisible microwave to the beat. Eventually, you freestyle to represent the microwaves bouncing around.
  * The Charleston
    ~ dance = "Charleston"
    You kick your feet up, swinging back and forth. You find a partner and they do the Charleston too, but not too close because we have to leave room for Jesus.
- The DJ sees your move and immediately stops the music.
  * [...]
- The guests stop dancing and you hear whispers among the crowd:
Did you see that move! # { "sender": 1 }
Oh wow, are they a professional dancer? # { "sender": 1 }
I'm in shock at how smooth those moves were! # { "sender": 1 }
  * [...]
- The DJ's mouth is agape, but they recompose themselves and resume the music again. Dancing ensues.
The DJ motions for you to come over.
That was an amazing move! I've never seen anything like that in all my life! # { "sender": 1 }
  * Thank you, I call it the {dance}. # { "sender": 2 }
-> dancingEmailOrPhone

== dancingEmailOrPhone
Could I please get your phone number or email address so I can contact you for some back up dancer opportunities (So Jesse and Lillian can reach you)? # { "sender": 1 }
# { "userInteraction": { "placeholder": "Email or phone number here", "stateVar": "emailOrPhoneEntry", "type": "text", "handler": "emailOrPhoneHandler", "validator": "emailOrPhone" } }
    + \ {emailOrPhone}. # { "sender": 2 }
- {
    - validationError == 0 : -> leavedance
    - else: -> dancingEmailOrPhone_validation_error
}
-> DONE

= dancingEmailOrPhone_validation_error
Sorry? I didn't quite catch that. # { "sender": 1 }
-> rsvpEmailOrPhone

== leavedance
Thank you so much! # { "sender": 1 }

You continue to dance well into the night, laughing and having a great time.

As the evening goes on and the guests reach their various bedtimes, you too, decide to head off.
-> bestending

== bestending
~ isAttending = 1
You step into your car, where this adventure began.
You breathe a sigh as you reminisce on a wonderful evening at probably the best wedding ever (except maybe your own of course!).

Congratulations, you made it through the wedding and reached the best ending!
  * [Hooray!]
-> rsvpComments


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
I am the system administrator for this website! I just have a few questions for you regarding your attendance at Lillian and Jesse’s wedding. # { "sender": 1 }
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
Oh, what a shame! We would have loved for you to come. # { "sender": 1 }
{ retrying == 0: -> rsvpOnBehalf}
{ retrying == 1: -> rsvpCheckForm}

== rsvpOnBehalf
Would you like to respond on behalf of another guest? (No wedding crashers please) Or they can play the game themselves. # { "sender": 1 }

+ Yes # { "sender": 2 }
-> rsvpOnBehalfYes
+ No # { "sender": 2 }
-> rsvpOtherallergy

== rsvpOnBehalfYes
Who are they? # { "sender": 1 }
# { "userInteraction": { "placeholder": "Their names here", "stateVar": "otherNamesEntry", "type": "text", "handler": "otherNamesHandler", "validator": "name" } }
    + \ They are {otherNames}. # { "sender": 2 }
- {
    - validationError == 0 && retrying == 0: -> rsvpOtherallergy
    - validationError == 0 && retrying == 1: -> rsvpCheckForm
    - else: -> otherNames_validation_error
}
-> DONE

= otherNames_validation_error
Sorry? I didn't quite catch that. # { "sender": 1 }
-> rsvpOnBehalfYes

== rsvpOtherallergy
Do you have any specific dietary requirements? # { "sender": 1 }

+ Yes # { "sender": 2 }
-> rsvpOtherallergyYes
+ No # { "sender": 2 }
-> rsvpEmailOrPhone

== rsvpOtherallergyYes
What are your diet requirements? # { "sender": 1 }
# { "userInteraction": { "placeholder": "Enter your diet...", "stateVar": "dietEntry", "type": "text", "handler": "dietHandler", "validator": "diet" } }
    + \ {diet}. # { "sender": 2 }
- {
    - validationError == 0 && retrying == 0: -> rsvpEmailOrPhone
    - validationError == 0 && retrying == 1: -> rsvpCheckForm
    - else: -> rsvpDiet_validation_error
}
-> DONE

= rsvpDiet_validation_error
Sorry? I didn't quite catch that. # { "sender": 1 }
-> rsvpOtherallergyYes

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
You <strong>are {isAttending == 0: not} </strong> attending the wedding.
- {
  - otherNames != "": You are responding on behalf of: {otherNames}
  - else: You are not responding on behalf of another guest.
}
- {
  - diet != "": Your diet requirements: {diet}
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
 + Diet # { "sender": 2 }
 -> rsvpOtherallergy
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
  * [Restart]
- # { "cmd": "RESET" }
-> start

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
