---
layout: project
title:  "Terrain Engine"
excerpt: "Added terrain support to a personal game engine with support for up to 8k heightmaps. Both generation and presentation were optimized such that loading even large datasets took no more than a couple of seconds and rendering supported almost per-pixel triangle density."
categories: projects school
---

I built a terrain component for my engine that loads and renders 8k x 8k square height maps at 60 FPS. The component used a level of detail system to optimize which quadrants could render at higher or lower detail given distance and the index buffers were created to use a H-fractal format when accessing vertices to take maximum advantage of the vertex cache. Stitching between quadrants of different densities is supported and the overall quadrant count across the hight map is configurable. The stitching algorithm itself is a small and fast system that thinks of indices as points in 2D space and creating the next index is treated as a vector translation.

<center><iframe src="http://player.vimeo.com/video/14909303" width="500" height="476" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe></center>