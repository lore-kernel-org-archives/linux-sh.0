From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 24 Apr 2012 11:46:09 +0000
Subject: Re: [PATCH/RFC] sh: ecovec: switch MMC power control to regulator
Message-Id: <Pine.LNX.4.64.1204241342590.21239@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
 <Pine.LNX.4.64.1204201850180.3974@axis700.grange>
 <20120420170744.GC3080@opensource.wolfsonmicro.com>
In-Reply-To: <20120420170744.GC3080@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi

On Fri, 20 Apr 2012, Mark Brown wrote:

> On Fri, Apr 20, 2012 at 06:59:41PM +0200, Guennadi Liakhovetski wrote:
> 
> > +static struct gpio_regulator_state mmcif_power_states[] = {
> > +	{ .value = 3300000, .gpios = 0 },
> > +};
> 
> It doesn't make much odds but if you've only got one voltage the fixed
> voltage regulator is a little more idiomatic here (there's some overlap
> as they've been evolving separately.  No harm in gpio-regulator though.

One more question in this respect: I see, that most other MMC drivers use 
"vmmc" as supply name. How important is it for all MMC drivers to use the 
same name? Shall I use it for MMCIF and TMIO-MMC too?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
