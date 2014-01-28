From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 28 Jan 2014 07:13:43 +0000
Subject: BockW 4th sound doesn't work on latest linus/master
Message-Id: <878uu08tp8.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Mark Brown <broonie@kernel.org>
Cc: Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>


Hi Simon, Mark

I noticed that bockw 4th sound device doesn't work on
latest linus/master.

My git bisect said the trigger is this patch

e14ee5deab24200e4b70fe31a8c806f0acd3d37c
(ARM: shmobile: bockw: Do not enable CONFIG_DEVTMPFS defconfig)

This patch removed below from defconfig

-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y

But, why this has relationship to sound ??

#0 - #3 sound device have no problem.
But #4 sound device will be broken by this patch
Do you have any idea ?

--- my kernel log -------
...
ALSA device list:
  #0: SSI56-AK4643
  #1: SSI3-AK4554(playback)
  #2: SSI4-AK4554(capture)
  #3: SSI7-AK4554(playback)
  #4: SSI8-AK4554(capture)

--- test result of 4th device (bad case) ---

# /home/arecord -c 2 -t wav -d 10 -r 48000 -f S16_LE -D hw:4 /tmp/hoge
ALSA lib pcm_hw.c:1433:(_snd_pcm_hw_open) Invalid value for card
arecord: main:608: audio open error: No such file or directory

--- test result of 4th device (good case) ---

# /home/arecord -c 2 -t wav -d 10 -r 48000 -f S16_LE -D hw:4 /tmp/hoge
Recording WAVE '/tmp/hoge' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
