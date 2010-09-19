From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sun, 19 Sep 2010 19:45:31 +0000
Subject: Re: [PATCH 3/5] ASoC: lowercase wm8978 codec name to match its
Message-Id: <20100919194530.GA20255@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
	<Pine.LNX.4.64.1009171214281.4988@axis700.grange>
	<20100917125319.GF4322@rakim.wolfsonmicro.main>
	<Pine.LNX.4.64.1009191756500.23955@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009191756500.23955@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, linux-sh@vger.kernel.org

On Sun, Sep 19, 2010 at 05:59:50PM +0200, Guennadi Liakhovetski wrote:
> On Fri, 17 Sep 2010, Mark Brown wrote:

> > Better yet would be to rename this to wm8978 (and adjust the board).

> Well, what does "better" mean? That it's your suggestion or your 
> requirement for this patch to be accepted? I grepped codecs/ and have 
> found enough of both versions, so, maybe we can take it like this and then 
> decide upon a unified naming?

I mean I've already done a version that renames everything to wm8978.  I
don't like the other users for I2C devices terribly much either and will
post patches for at least the drivers I'm responsible for soon.
