From: "Adrian McMenamin" <lkmladrian@gmail.com>
Date: Mon, 31 Dec 2007 15:55:26 +0000
Subject: Getting the AICA device to work properly
Message-Id: <8b67d60712310755u6536e666gfca525bdb52df1e3@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org

I have built mpg123 for SH4 (using uclibc for a buildroot/busybox environment):

./configure --host=sh4-linux
CC="/home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-uclibc-gcc"
--with-cpu=generic_fpu --prefix=/tftpboot/192.168.61.55/usr
LDFLAGS="-L/tftpboot/192.168.61.55/lib"
--oldincludedir=/tftpboot/192.168.61.55/usr/include -with-audio=alsa
--sysconfdir=/tftpboot/192.168.61.55/etc --enable-modules=no
--enable-static --enable-debug


When I try to play sound I get this:

$ mpg123 -v ms.mp3
[getlopt.c:115] debug: getsingleopt: -v
[getlopt.c:115] debug: getsingleopt: ms.mp3
[audio.c:501] debug: opening normal audio/file
[libmpg123.c:190] debug: set flags to 0x40
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layers 1, 2 and 3
        version 1.0.1; written and copyright by Michael Hipp and others
        free software (LGPL/GPL) without any warranty but with best wishes
[frame.c:464] debug: frame_gapless_init: from 0 to 0 samples
[libmpg123.c:99] debug: cpu opt setting
Decoder: generic
[frame.c:141] debug: frame 0x435650 buffer
[frame.c:242] debug: frame 0x435650 buffer done
[tabinit.c:85] debug: MMX decode tables
[tabinit.c:107] debug: MMX decode tables done
[audio.c:279] debug: audio_capabilities
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
[mpg123.c:813] debug: Going to play ms.mp3
[mpg123.c:483] debug: OK... going to finally open.
[frame.c:464] debug: frame_gapless_init: from 0 to 0 samples
[readers.c:620] error: Cannot file ms.mp3: No such file or directory
[mpg123.c:495] error: Cannot open ms.mp3: File access error. (code 22)
[playlist.c:116] debug: going to free() the playlist
[playlist.c:120] debug: free()ing entry 0
[playlist.c:126] debug: free()d the playlist
[audio.c:441] debug: exit output
[audio.c:524] debug: closing output
[audio.c:148] debug: closing output module

The main problem appears to be that ALSA lib has no knowledge of the
installed (snd-aica) sound module - eg


$ aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)

How do I fix this? I don't think I had this problem before because my
alsalib set up was somewhat banjaxed - things like aplay segfaulted -
but the oss smulation layer worked well.

When I use the emulation layer now (rebuilding mpg123) I now get:

$ mpg123 ./ms.mp3
[getlopt.c:115] debug: getsingleopt: ./ms.mp3
[audio.c:501] debug: opening normal audio/file
[oss.c:180] error: Can't open default sound device!
[audio.c:505] error: failed to open audio device
[mpg123.c:666] error: Failed to initialize output, goodbye.
