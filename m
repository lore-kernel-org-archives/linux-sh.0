From: "Adrian McMenamin" <lkmladrian@gmail.com>
Date: Sun, 20 Jan 2008 21:31:33 +0000
Subject: Fixing my sound driver
Message-Id: <8b67d60801201331h338e932fxb856d5fac94ba5f0@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-sh <linux-sh@vger.kernel.org>

I am still trying to find out what is wrong with my sound driver - for
the Sega Dreamcast (sound/sh/aica.c). This works perfectly with the
OSS emulation layer but will not work with the ALSA layer per se.

As this shows - there is something wrong with how it interacts with
the PCM layer of alsa-lib:

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: AICA [AICA], device 0: AICA PCM [AICA PCM]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
$
$
$ aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)


I have no reason to think that my build of alsa-lib is wrong - both
the automagic buildroot build and my own by-hand build behave the same
way.

So therefore I assume it must be something in the driver?!

Some questions:

The driver implements nothing for capture (the AICA device is pure
playback) - could that have an effect?

What information must the driver pass to the PCM layer?

What could make the alsa-lib layer detect the card but then report
"null" is the only PCM device?

Adrian
