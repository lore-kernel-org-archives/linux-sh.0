From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sat, 16 Feb 2013 14:02:36 +0000
Subject: Re: [PATCH v4 03/13] mmc: provide a standard MMC device-tree binding parser centrally
Message-Id: <Pine.LNX.4.64.1302161457140.20044@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
 <1360941242-18153-4-git-send-email-g.liakhovetski@gmx.de>
 <20130216060526.GA20785@verge.net.au> <201302161054.36492.arnd@arndb.de>
In-Reply-To: <201302161054.36492.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Simon Horman <horms@verge.net.au>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Markus Pargmann <mpa@pengutronix.de>

On Sat, 16 Feb 2013, Arnd Bergmann wrote:

> On Saturday 16 February 2013, Simon Horman wrote:
> > > +void mmc_of_parse(struct mmc_host *host)
> > > +{
> > > +     struct device_node *np;
> > > +     u32 bus_width;
> > > +     bool explicit_inv_wp, gpio_inv_wp = false;
> > > +     enum of_gpio_flags flags;
> > > +     int len, ret, gpio;
> > > +
> > > +     if (!host->parent || !host->parent->of_node)
> > > +             return;
> > > +
> > > +     np = host->parent->of_node;
> > > +
> > > +     /* "bus-width" is translated to MMC_CAP_*_BIT_DATA flags */
> > > +     if (of_property_read_u32_array(np, "bus-width", &bus_width, 1) < 0)
> > > +             dev_dbg(host->parent,
> > > +                     "\"bus-width\" property is missing, assuming 1 bit.\n");
> > > +
> > > +     switch (bus_width) {
> > 
> > kbuild tells me that gcc thinks that bus_width is used without being
> > initialised here. Assuming that of_property_read_u32_array always
> > initialises bus_width if it returns zero then perhaps it would be worth
> > considering using uninitialized_var().
> 
> I think this is a false positive that I encountered before and that should be gone
> with gcc-4.7 or higher when using -O2 instead of -Os. I have a patch to disable
> -Wmaybe-uninitialized when builing with -Os. If that gets rid of the warning,
> I'd prefer not annotating it here.

Unfortunately, this does seem to be a real bug, I lost the default 
initialisation to one somewhere along the way... I'll send a trivial 
update. Stupidly, my cross-toolchain doesn't report this error.

Thanks
Guennadi

> There was some discussion about removing uninitialized_var() recently after it
> was found to hide some real bugs.
> 
> 	Arnd

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
