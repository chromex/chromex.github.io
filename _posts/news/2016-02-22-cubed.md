---
layout: post
title: New project code named "cubed"
categories: news
excerpt: Getting back into game dev with an Oculus Rift project
---

With the release of the Oculus Rift looming I found that this was an excellent time to get back into game programming. As I've ordered a Rift I wanted to do something that took advantage of it as a unique input mechanism. Additionally I'm fascinated by the issues presented with using your facing direction to influence in-game movement. To dig into this I've opted to build a simple flying game where your movement is wholly controlled via the Rift. I'm calling the project "Cubed" even though it is my first project in a while that so far has nothing to do with voxels.

But that is getting a bit ahead. At this point I've gotten the core engine written and just tagged the checkin where my graphics test is complete. Right now the engine supports:

* Draw queues
* OpenGL forward renderer (you'll see why)
* Asset packer that converts assets to code
* Material system
* Input system

This engine has been a big learning experience for me. It is my first dive into the newer C++ features, the newer OpenGL core profile functionality (so nice), and more rigorous architecture design that is singleton / global free. Between these various changes this is probably the leanest and cleanest engine I've written. As my first real stint of engine programming in a few years it is also super refreshing.

Back to Cubed though. The current target style is an old vector graphics aesthetic. Below is a video of the test scene used for engine validation. 

<center><iframe src="http://player.vimeo.com/video/156363039" width="500" height="281" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe></center>

Next update will hopefully have some content from the level generation.
