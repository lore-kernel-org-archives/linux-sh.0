From: "Adrian McMenamin" <lkmladrian@gmail.com>
Date: Wed, 23 Jan 2008 22:11:34 +0000
Subject: Re: [alsa-devel] Fixing my sound driver
Message-Id: <8b67d60801231411n27024a6ei1b1cd3da6c5025ea@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60801201331h338e932fxb856d5fac94ba5f0@mail.gmail.com>
	 <s5habmze1t7.wl%tiwai@suse.de>
In-Reply-To: <s5habmze1t7.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-sh <linux-sh@vger.kernel.org>

On 21/01/2008, Takashi Iwai <tiwai@suse.de> wrote:
> At Sun, 20 Jan 2008 21:31:33 +0000,
> Adrian McMenamin wrote:
> >
> > I am still trying to find out what is wrong with my sound driver - for
> > the Sega Dreamcast (sound/sh/aica.c). This works perfectly with the
> > OSS emulation layer but will not work with the ALSA layer per se.
> >
> > As this shows - there is something wrong with how it interacts with
> > the PCM layer of alsa-lib:
> >
> > $ aplay -l
> > **** List of PLAYBACK Hardware Devices ****
> > card 0: AICA [AICA], device 0: AICA PCM [AICA PCM]
> >   Subdevices: 1/1
> >   Subdevice #0: subdevice #0
> > $
> > $
> > $ aplay -L
> > null
> >     Discard all samples (playback) or generate zero samples (capture)
> >
> >
> > I have no reason to think that my build of alsa-lib is wrong - both
> > the automagic buildroot build and my own by-hand build behave the same
> > way.
> >
> > So therefore I assume it must be something in the driver?!
>
> I don't think so.  Try to load snd-dummy.
>

OK, I went one better than that. I switched to a Debian based
distribution and installed alsa via apt-get (something of a struggle
with just 16MB to play with, but it can be done).

But while it seems better, it is still not fully functioning:

supercat:/usr/share/sounds/alsa# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: AICA [AICA], device 0: AICA PCM [AICA PCM]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

supercat:/usr/share/sounds/alsa# aplay -L
PCM list:
hw {
        @args.0 CARD
        @args.1 DEV
        @args.2 SUBDEV
        @args.CARD {
                type string
                default {
                        @func getenv
                        vars {
                                0 ALSA_PCM_CARD
                                1 ALSA_CARD
                        }
                        default {
                                @func refer
                                name 'defaults.pcm.card'
                        }
                }
        }
        @args.DEV {
                type integer
                default {
                        @func igetenv
                        vars {
                                0 ALSA_PCM_DEVICE
                        }
                        default {
                                @func refer
                                name 'defaults.pcm.device'
                        }
                }
        }
        @args.SUBDEV {
                type integer
                default {
                        @func refer
                        name 'defaults.pcm.subdevice'
                }
        }
        type hw
        card $CARD
        device $DEV
        subdevice $SUBDEV
}
plughw {
        @args.0 CARD
        @args.1 DEV
        @args.2 SUBDEV
        @args.CARD {
                type string
                default {
                        @func getenv
                        vars {
                                0 ALSA_PCM_CARD
                                1 ALSA_CARD
                        }
                        default {
                                @func refer
                                name 'defaults.pcm.card'
                        }
                }
        }
        @args.DEV {
                type integer
                default {
                        @func igetenv
                        vars {
                                0 ALSA_PCM_DEVICE
                        }
                        default {
                                @func refer
                                name 'defaults.pcm.device'
                        }
                }
        }
        @args.SUBDEV {
                type integer
                default {
                        @func refer
                        name 'defaults.pcm.subdevice'
                }
        }
        type plug
        slave.pcm {
                type hw
                card $CARD
                device $DEV
                subdevice $SUBDEV
        }
}
plug {
        @args.0 SLAVE
        @args.SLAVE {
                type string
        }
        type plug
        slave.pcm $SLAVE
}
shm {
        @args.0 SOCKET
        @args.1 PCM
        @args.SOCKET {
                type string
        }
        @args.PCM {
                type string
        }
        type shm
        server $SOCKET
        pcm $PCM
}
tee {
        @args.0 SLAVE
        @args.1 FILE
        @args.2 FORMAT
        @args.SLAVE {
                type string
        }
        @args.FILE {
                type string
        }
        @args.FORMAT {
                type string
                default raw
        }
        type file
        slave.pcm $SLAVE
        file $FILE
        format $FORMAT
}
file {
        @args.0 FILE
        @args.1 FORMAT
        @args.FILE {
                type string
        }
        @args.FORMAT {
                type string
                default raw
        }
        type file
        slave.pcm null
        file $FILE
        format $FORMAT
}
null {
        type null
}
cards 'cards.pcm'
front 'cards.pcm.front'
rear 'cards.pcm.rear'
center_lfe 'cards.pcm.center_lfe'
side 'cards.pcm.side'
surround40 'cards.pcm.surround40'
surround41 'cards.pcm.surround41'
surround50 'cards.pcm.surround50'
surround51 'cards.pcm.surround51'
surround71 'cards.pcm.surround71'
iec958 'cards.pcm.iec958'
spdif 'cards.pcm.iec958'
modem 'cards.pcm.modem'
phoneline 'cards.pcm.phoneline'
default 'cards.pcm.default'
dmix 'cards.pcm.dmix'
dsnoop 'cards.pcm.dsnoop'


Below seems fair enough...

supercat:/usr/share/sounds/alsa# aplay Noise.wav
Playing WAVE 'Noise.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for 'default'
aplay: set_params:899: Access type not available

But this isn't...

supercat:/usr/share/sounds/alsa# aplay -D plughw:0,0 Noise.wav
Playing WAVE 'Noise.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for 'plughw:0,0'
aplay: set_params:899: Access type not available

Any clues?

(Just to be clear:

supercat:/usr/share/sounds/alsa# modprobe snd-pcm-oss
supercat:/usr/share/sounds/alsa# cat Noise.wav > /dev/dsp

works as one would expect)
