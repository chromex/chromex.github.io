---
layout: project
title: "Ludum Dare 25: Prisoner's Dilemma"
excerpt: "A multi-player game where players have one hour to make as much money as possible by joining into contracts with  other players. Either player, or both, can choose to secretly cheat out on the other to maximize their profits but in prisoner's dilemma style if both cheat they both lose."
categories: projects gamejam
image: ld/endnet.png
---

This game, loosely called Prisoner's Dilemma, was built for my second [Ludum Dare](http://www.ludumdare.com/compo/) for the theme "you are the villain." From the theme I jumped to the idea of a multi-player game where players must work together to make money but the players that really win are those that manage to cheat against the others. However making multi-player games for a 48 hour game jam is hard and after a bit of thought I settled on building it as a text based game, MUD style, to avoid the graphics and audio work. The server is written in C++ and uses the boost libraries for asynchronous networking.

To say that this was experience would be to undersell the complexity of writting and testing a multi-player game in C++ in 48 hours.

The essence of the gameplay was that a player would connect, create a character, and would then have one real world hour to make as much money as possible before that character was finished and its score frozen. Playing the game totally depends on other players being around to play with, which meant that the largest group of folks that played it at once was six people. Now players made money by establishing contracts with each other. A contract consisted of an entry cost for each player and a duration. The longer a contract lasted, the more money the players could make. Any player can offer a contract to another if they don't already have one and can set the terms of the contract. The receiving player can choose to accept or decline it. If one player has a lot more money than another, they can offer to pay in more than the other to help raise the pool amount.

And now comes the villany. When offering or accepting a contract, a player could specify that it was an evil offer or an evil acceptance (biased, I know). If no player was evil, they both collected the contract result based on the money pool and the duration. However if one of the players performed an evil move then that player would collect all of the money yielded by the contract at completion. But, if both were evil, they both lost. 

Now you didn't know whether neither, one, or both of the players had been evil until the contract finished and contract durations were in increments of minutes with the 5 minute contracts being the maximum duration and also far and away the most lucrative. Unfortunately, if you were cheated on a 5 minute contract then that was not only lost money but also 5 minutes of lost time and 5 minutes that you believed this other player was on your side. When this would happen the in game global chat would explode which led players to try to work together up until the last 10 minutes or so of a run. This meant that later in the game players were always suspicious of a character that was about to expire and a very rich meta game evolved.

While the game was simple it demanded a fairly large set of commands such as in-game help, contract management, leader board viewing, chat, and more. As a server system it also needed password protected character accounts, saving and loading, connection management, and other necessities so that it could survive being started and stopped in case it crashed or had memory leaks. It was quite a bit of work. Also, when I first launched the server players found ways to cheat within an hour and had exploding scores (even looping the integer) which led to a frantic search for the bugs which were the result of glitches in the contract negotiation. 

It was very interesting because for about two days I had players logged in who had played multiple characters and just stuck around to chat. It was a great experience and really helped me learn some boost which I had minimal experience with prior. Unfortunately, having to connect to the server over telnet meant that I had a hard time getting in players to try the game and so only had a couple of good runs of gameplay. 

After a few weeks running I shutdown the server for the last time though the final uptime was 19 consecutive days, not bad for a hastilly written C++ server. 

* View the source at: <https://github.com/chromex/gamejaming/tree/master/ld25>
* See the Ludum Dare page: <http://www.ludumdare.com/compo/ludum-dare-25/?action=preview&uid=15756>