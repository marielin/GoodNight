# GoodNight  
Forked from Anthony Agatiello's "GoodNight" (https://github.com/anthonya1999/GoodNight), which is based off of Thomas Finch's "GammaThingy" (https://github.com/thomasfinch/GammaThingy).

GoodNight is an app that allows you to change the screen temperature and adjust the apparent screen brightness below normal levels.

This fork enables simultaneous screen temperature and brightness adjustments, and also removes some inessential features. It also incorporates accurate temperature curves using a Kelvin to RGB algorithm, originally developed by [Tanner Helland](http://www.tannerhelland.com/4435/convert-temperature-rgb-algorithm-code/) and modified by [Neil B](http://www.zombieprototypes.com/?p=210).

This application uses dlsym, which loads in the private symbols at runtime, rather than using headers, so no additional setup is needed once you download the source.
