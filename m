From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 20 Aug 2009 08:52:05 +0000
Subject: Re: [alsa-devel] [PATCH 3/3] Add FSI-AK464x sound support for
Message-Id: <20090820085204.GA11699@sirena.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <uiqgk59lj.wl%morimoto.kuninori@renesas.com>
	<20090819120058.GB20227@rakim.wolfsonmicro.main>
	<aec7e5c30908190646l1af450e8w3178683893a17437@mail.gmail.com>
	<20090819140256.GA31305@rakim.wolfsonmicro.main>
	<aec7e5c30908190718j40459a55w614093c6366800db@mail.gmail.com>
	<20090819144547.GB3323@rakim.wolfsonmicro.main>
	<u3a7ndj20.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u3a7ndj20.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: alsa-devel@alsa-project.org, Magnus Damm <magnus.damm@gmail.com>, philipp.zabel@gmail.com, linux-sh@vger.kernel.org

On Thu, Aug 20, 2009 at 04:46:15PM +0900, Kuninori Morimoto wrote:

> Dear Mark, pHilipp, Magnus

It's a bit easier to follow things if you reply to individual mails
rather than stitching things together into a singel mail like this.

> > Should this driver also be able to drive AK4641? I'm asking because I

> I checked datasheet.
> My codec is AK4643, and it is compatible with AK4642.
> And AK4642 is not compatible AK4641 (^^;

> I will re-name it AK464x -> AK4642.
> Can you agree with me ?

Yes, that sounds lkike a good approach.  You can add entries to the I2C
device ID table for both ak4642 and ak4643 so it's clear that both
devices are supported.

> > +#define PREALLOC_BUFFER		(32 * 1024)
> > +#define PREALLOC_BUFFER_MAX	(32 * 1024)

> > Is it worth letting machines override these in the platform data or is
> > there no point?

> do you mean it should be possible to change size ?
> If so, is it good as future tasks ?
> This time, 32k is good for me.

It's OK for you but is it going to be the right choice for every system?

> > If possible please try to avoid using a global variable like this.
> > Future processors may come with multiple FSI blocks.

> > Right now I'm quite happy that the CEU driver does not use global

> hmm... I can agree with you.
> But this time, is it good as future tasks ?
> I will fix this problem if I can get free time

> >  arch/sh/boards/mach-se/7724/Makefile     |    3 +-
> >  arch/sh/boards/mach-se/7724/fsi-ak464x.c |   90 ++++++++++++++++++++++++++++++

> > the machine driver itself should be under sound/soc/sh.

> if fsi-ak464x.c is in arch/sh/boards/mach-se/7724/
> it works, and it say

You will be able to load the driver, yes, this is a coding style sort of
issue.  Placing machine drivers outside of ASoC will create maintinance
problems since the ASoC APIs change relatively often.

> but when I tried to move it to sound/soc/sh,
> then it be doesn't work. it say
> ------------
> ALSA device list:
>   No soundcards found.
> ------------

This needn't be anything to worry about - cards can be started at any
time, this is just a snapshot of the cards that were ready at this point
during system startup.

> there is no "AK4642 Audio Codec 0.0.1" print,
> so, snd_soc_codec_device :: probe isn't called.
> can you give me advice ?

If you could repost with the driver under sound/soc/sh it may be
possible to identify where the problem lies.
