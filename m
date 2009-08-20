From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 20 Aug 2009 11:48:12 +0000
Subject: Re: [alsa-devel] [PATCH 3/3] Add FSI-AK464x sound support for	ms7724se
Message-Id: <u1vn6emf7.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uiqgk59lj.wl%morimoto.kuninori@renesas.com>
	<20090819120058.GB20227@rakim.wolfsonmicro.main>
	<aec7e5c30908190646l1af450e8w3178683893a17437@mail.gmail.com>
	<20090819140256.GA31305@rakim.wolfsonmicro.main>
	<aec7e5c30908190718j40459a55w614093c6366800db@mail.gmail.com>
	<20090819144547.GB3323@rakim.wolfsonmicro.main>
	<u3a7ndj20.wl%morimoto.kuninori@renesas.com>
	<20090820085204.GA11699@sirena.org.uk>
In-Reply-To: <20090820085204.GA11699@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org


Dear Mark

Thank you very much

> > do you mean it should be possible to change size ?
> > If so, is it good as future tasks ?
> > This time, 32k is good for me.
> 
> It's OK for you but is it going to be the right choice for every system?

I'm not sure.
But this patch is start point for us.
So, I would like to fix it if we find trouble.
OK ?

> > there is no "AK4642 Audio Codec 0.0.1" print,
> > so, snd_soc_codec_device :: probe isn't called.
> > can you give me advice ?
> 
> If you could repost with the driver under sound/soc/sh it may be
> possible to identify where the problem lies.

Thank you. I could fix it.
The criminal was my miss.
Thank you.

Best regards
--
Kuninori Morimoto
 
