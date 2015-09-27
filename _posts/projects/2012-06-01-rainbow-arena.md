---
layout: project
title: "Ludum Dare 24: Dr. X's Rainbow Arena"
excerpt: "An arena survival shooter where the enemies are generated from an evolving gene pool."
categories: projects gamejam
image: ld/rainbowarena.png
---

Dr. X's Rainbow Arena is a top-down, twin-stick, arena shooter built to the theme of evolution for my very first [Ludum Dare](http://www.ludumdare.com/compo/). The theme itself was quite interesting because I felt that it was wretched in its ambiguity and then it turned out to be wretched because almost everyone made a game to the same general idea: your enemies evolve and you must beat them.

In Rainbow Arena you take the role of Green Arrow on a quest to help The General develop the next generation biological weapon in the extremely colorful rainbow arena. It is your job to survive as long as possible against a growing number of evolving enemies. The evolution works by starting the game with a small pool of enemy configurations. A configuration was stored as a bitfield where each bit corresponded to an enemy feature being turned on or off and the features included up to four guns, random movement, heat seaking movement, shields, explosion on death, etc. Whenever the player kills an enemy the enemy has a chance to either mutate or split. When a mutation happens a bit is flipped at random and when a split happens a new copy of that gene set is put into the pool. The size of the pool controls how many enemies can be in the arena at any one time so the more splits that happen, the more crowded the game becomes. The pool thankfully has a maximum size and if a split occurs when the pool is full, the gene set with the fewest bits turned on is booted out as the weakest link.

Now the idea of this is that the player will in the early stages attempt to farm the easier enemies instead of risk causing an already dangerous enemy to evolve new and more powerful abilities. However with time all enemies will become a risk and the player will be forced to kill their more potent enemies despite the fact that there is a chance they could become more deadly. This leads to a pretty rapid escalation and was quite fun to test and watch others play.

As a 48 hour Ludum Dare I had to make absolutely everything in the game myself which is a phenomenal and somewhat scary experience. For the engine I used [Unity3D](http://www.unity3d.com) since I knew I could work in it quickly and for models I used my own voxel modeling tool that I had written for my masters project. For the few textures I used the [Gimp](http://www.gimp.org/) and for audio I used the fantastic [sfxr](http://www.drpetter.se/project_sfxr.html).

One of the downsides of the game is that I wrote it around using a controller which really hurt it when looking for player testers during the scoring phase of Ludum Dare since most folks do not own things like USB connected Xbox controllers. However I did get a lot of positive feedback for the end game statistics screen that showed information for things like how many enemies were killed and what your most potent enemy was. Ultimately the game was fun and I had a great time making it.

* Play it now (preferably with a controller) at: <http://static.loren.io/ld/rainbowarena.unity3d>
* See the Ludum Dare page: <http://www.ludumdare.com/compo/ludum-dare-24/?action=preview&uid=15756>