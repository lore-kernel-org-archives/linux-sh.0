From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 24 Jan 2008 10:51:10 +0000
Subject: Re: [alsa-devel] Fixing my sound driver
Message-Id: <s5h4pd35wf5.wl%tiwai@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60801201331h338e932fxb856d5fac94ba5f0@mail.gmail.com>
	<s5habmze1t7.wl%tiwai@suse.de>
	<8b67d60801231411n27024a6ei1b1cd3da6c5025ea@mail.gmail.com>
In-Reply-To: <8b67d60801231411n27024a6ei1b1cd3da6c5025ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <lkmladrian@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-sh <linux-sh@vger.kernel.org>

At Wed, 23 Jan 2008 22:11:34 +0000,
Adrian McMenamin wrote:
> 
> On 21/01/2008, Takashi Iwai <tiwai@suse.de> wrote:
> > At Sun, 20 Jan 2008 21:31:33 +0000,
> > Adrian McMenamin wrote:
> > >
> > > I am still trying to find out what is wrong with my sound driver - for
> > > the Sega Dreamcast (sound/sh/aica.c). This works perfectly with the
> > > OSS emulation layer but will not work with the ALSA layer per se.
> > >
> > > As this shows - there is something wrong with how it interacts with
> > > the PCM layer of alsa-lib:
> > >
> > > $ aplay -l
> > > **** List of PLAYBACK Hardware Devices ****
> > > card 0: AICA [AICA], device 0: AICA PCM [AICA PCM]
> > >   Subdevices: 1/1
> > >   Subdevice #0: subdevice #0
> > > $
> > > $
> > > $ aplay -L
> > > null
> > >     Discard all samples (playback) or generate zero samples (capture)
> > >
> > >
> > > I have no reason to think that my build of alsa-lib is wrong - both
> > > the automagic buildroot build and my own by-hand build behave the same
> > > way.
> > >
> > > So therefore I assume it must be something in the driver?!
> >
> > I don't think so.  Try to load snd-dummy.
> >
> 
> OK, I went one better than that. I switched to a Debian based
> distribution and installed alsa via apt-get (something of a struggle
> with just 16MB to play with, but it can be done).

It must be a pretty older version of alsa-lib...


Takashi
