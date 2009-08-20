From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 20 Aug 2009 07:46:15 +0000
Subject: Re: [alsa-devel] [PATCH 3/3] Add FSI-AK464x sound support for	ms7724se
Message-Id: <u3a7ndj20.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uiqgk59lj.wl%morimoto.kuninori@renesas.com>
	<20090819120058.GB20227@rakim.wolfsonmicro.main>
	<aec7e5c30908190646l1af450e8w3178683893a17437@mail.gmail.com>
	<20090819140256.GA31305@rakim.wolfsonmicro.main>
	<aec7e5c30908190718j40459a55w614093c6366800db@mail.gmail.com>
	<20090819144547.GB3323@rakim.wolfsonmicro.main>
In-Reply-To: <20090819144547.GB3323@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Magnus Damm <magnus.damm@gmail.com>, philipp.zabel@gmail.com, linux-sh@vger.kernel.org


Dear Mark, pHilipp, Magnus

Thank you for a lot of advice/comments

> Should this driver also be able to drive AK4641? I'm asking because I

I checked datasheet.
My codec is AK4643, and it is compatible with AK4642.
And AK4642 is not compatible AK4641 (^^;

I will re-name it AK464x -> AK4642.
Can you agree with me ?

> +#define PREALLOC_BUFFER		(32 * 1024)
> +#define PREALLOC_BUFFER_MAX	(32 * 1024)
>
> Is it worth letting machines override these in the platform data or is
> there no point?

do you mean it should be possible to change size ?
If so, is it good as future tasks ?
This time, 32k is good for me.

> If possible please try to avoid using a global variable like this.
> Future processors may come with multiple FSI blocks.
>
> Right now I'm quite happy that the CEU driver does not use global

hmm... I can agree with you.
But this time, is it good as future tasks ?
I will fix this problem if I can get free time

>  arch/sh/boards/mach-se/7724/Makefile     |    3 +-
>  arch/sh/boards/mach-se/7724/fsi-ak464x.c |   90 ++++++++++++++++++++++++++++++
>
> the machine driver itself should be under sound/soc/sh.

if fsi-ak464x.c is in arch/sh/boards/mach-se/7724/
it works, and it say
------------
AK4642 Audio Codec 0.0.1
asoc: AK4642 <-> FSI0 mapping ok
ALSA device list:
  #0: FSI (AK4642)
------------

but when I tried to move it to sound/soc/sh,
then it be doesn't work. it say
------------
ALSA device list:
  No soundcards found.
------------

there is no "AK4642 Audio Codec 0.0.1" print,
so, snd_soc_codec_device :: probe isn't called.
can you give me advice ?

Best regards
--
Kuninori Morimoto
