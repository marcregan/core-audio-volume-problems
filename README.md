Adjusting AVAudioPlayer Volume while Audio Session Inactive
===========================================================

This project demonstrates an issue with the CoreAudio and volume that I can't figure out.  I built this project to support a Radar bug:



Description
-----------

I'm building a turn-by-turn navigation app that plays periodic, short clips of sound. Sound should play regardless of whether the screen is locked, should mix with other music playing, and should make other music duck when this audio plays.

Apple discusses the turn-by-turn use case in detail in the "WWDC 2010 session 412 Audio Development for iPhone OS part 1" video at minute 29:20. The implementation works great, but there is one problem - when the app is running, pressing the hardware volume controls adjust the ringer volume, not the app volume. If you want to change the app volume, you must press the volume buttons while a prompt is playing.

I've also opened a Stack Overflow issue here:
http://stackoverflow.com/questions/16474771/cannot-control-volume-of-avaudioplayer-via-hardware-buttons-when-audiosessionact


Project
-------

This project uses the code described in the WWDC video I mentioned above, and has the volume issue.  If you install it on a device, you'll be able to adjust the audio volume while audio is playing, and you won't be able to when audio isn't playing.  This is a really big problem if you have very short audio clips spaced out over a long period of time (turn-by-turn).

