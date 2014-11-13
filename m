From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 13 Nov 2014 03:33:38 +0000
Subject: Re: [PATCH][resend] of: Add vendor 2nd prefix for Asahi Kasei Corp
Message-Id: <87vbmjhj00.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5398A53D.3020706@wwwdotorg.org>
	<20140611190444.GN5099@sirena.org.uk>
	<5398AB07.4040304@wwwdotorg.org>
	<87sinbdk44.wl%kuninori.morimoto.gx@renesas.com>
	<878ulzx6hr.wl%kuninori.morimoto.gx@gmail.com>
	<20140922130026.GK3290@leverpostej>
	<CAMuHMdX22z97SbGS1HDiYfJ1PXxyEN2S8D7w4sr+4bUwD+mJZw@mail.gmail.com>
	<20140922132743.GM3290@leverpostej>
	<87y4rfhmgl.wl%kuninori.morimoto.gx@renesas.com>
	<1415845309.4269.6.camel@perches.com>
	<20141113025105.GA16652@verge.net.au>
In-Reply-To: <20141113025105.GA16652@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Joe Perches <joe@perches.com>, Mark Rutland <mark.rutland@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Olof Johansson <olof@lixom.net>, Stephen Warren <swarren@wwwdotorg.org>, Rob Herring <robh@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>


Hi Joe, Simon

> > > I guess removing "ak" line from vendor-prefixes.txt is very enough
> > > for warn for a deprecated vendor prefix on checkpatch ?
> > 
> > Huh?  No idea what you mean.
> > What are you suggesting about checkpatch?
> 
> Hi Joe,
> 
> I think that what Morimoto-san wanted to say was something like this:
> 
>   I guess that removing the "ak" line from vendor-prefixes.txt would
>   be sufficient to cause checkpatch to generate a warning about
>   using the deprecated "ak" vendor prefix. Is that a good approach?

Yes, this is.
Thank you Simon, Sorry Joe.

