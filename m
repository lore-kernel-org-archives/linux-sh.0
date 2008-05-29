From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 29 May 2008 21:07:36 +0000
Subject: Re: [Linux-fbdev-devel] [PATCH] video: SuperH Mobile LCDC Driver
Message-Id: <20080529210736.GA13663@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
	<20080529200951.434093d3.krzysztof.h1@poczta.fm>
In-Reply-To: <20080529200951.434093d3.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Thu, May 29, 2008 at 08:09:51PM +0200, Krzysztof Helt wrote:
> > --- /dev/null
> > +++ work/drivers/video/sh_mobile_lcdcfb.c	2008-05-29 17:21:48.000000000 +0900
> > @@ -0,0 +1,742 @@
> > +/*
> > + * SuperH Mobile LCDC Framebuffer
> > + *
> > + * Copyright (c) 2008 Magnus Damm
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License
> > + *
> 
> English is not my native language but the last line sounds suspicious (either what?)
> 
Yes, there's overzealous trimming here. This should be amended to refer
to GPLv2 only, though as the MODULE_LICENSE() its already get this right,
it's mostly a cosmetic change.

> put lcdc_priv and channel number (or base address and and channel pointer) 
> as arguments to break the circular link. 
> You can make these functions inline as well.
> 
As the 'circular' link is being used in a pre-defined way, it's not clear
that there's a problem with it existing in the first place. It's
obviously a matter of convenience.

> > +static void lcdc_write(struct sh_mobile_lcdc_priv *priv,
> > +		       int reg_offs, unsigned long data)
> > +{
> > +	iowrite32(data, priv->base + reg_offs);
> > +}
> > +
> > +static unsigned long lcdc_read(struct sh_mobile_lcdc_priv *priv,
> > +			       unsigned long reg_offs)
> > +{
> > +	return ioread32(priv->base + reg_offs);
> > +}
> > +
> 
> These two functions can be inline.
> 
The compiler will do this automatically, there's no need to mark it
explicity.

> > +static void lcdc_sys_write_index(void *handle, unsigned long data)
> > +{
> > +	struct sh_mobile_lcdc_chan *ch = handle;
> > +
> > +	lcdc_write(ch->lcdc, _LDDWD0R, data | 0x10000000);
> > +
> > +	while (lcdc_read(ch->lcdc, _LDSR) & 2)
> > +	  ;
> > +
> 
> As Andrew Morton put it it would be better to put
> cpu_relax() inside this loop (or do some other
> cpu releasing). There are more busy loops
> in the driver's code.
> 
cpu_relax() doesn't really matter here. It's good to include for general
coherency, since we don't have the same barriers in the ioread() path,
but it's hardly critical.
