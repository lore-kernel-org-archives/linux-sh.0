From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sun, 19 Sep 2010 15:59:50 +0000
Subject: Re: [PATCH 3/5] ASoC: lowercase wm8978 codec name to match its only
Message-Id: <Pine.LNX.4.64.1009191756500.23955@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
 <Pine.LNX.4.64.1009171214281.4988@axis700.grange> <20100917125319.GF4322@rakim.wolfsonmicro.main>
In-Reply-To: <20100917125319.GF4322@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, 17 Sep 2010, Mark Brown wrote:

> On Fri, Sep 17, 2010 at 12:30:05PM +0200, Guennadi Liakhovetski wrote:
> > All ASoC codecs are called in lower case, adjust wm8978 to match them and also
> > to match its so far only user - the sh7722 migor board.
> 
> >  	.driver = {
> > -		.name = "WM8978-codec",
> > +		.name = "wm8978-codec",
> 
> Better yet would be to rename this to wm8978 (and adjust the board).

Well, what does "better" mean? That it's your suggestion or your 
requirement for this patch to be accepted? I grepped codecs/ and have 
found enough of both versions, so, maybe we can take it like this and then 
decide upon a unified naming?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
