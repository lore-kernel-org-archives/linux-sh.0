From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 May 2012 04:12:29 +0000
Subject: Re: [PATCH 10/11] ARM: mach-shmobile: armadillo800eva: Add FSI-WM8978 support
Message-Id: <87txz8am6t.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874nr9aqxg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nr9aqxg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

> > +/*
> > + * FIXME !!
> > + *
> > + * gpio_no_direction
> > + *
> > + * current gpio frame work doesn't have
> > + * the method to control only pull up/down/free.
> > + * this function should be replaced by correct gpio function
> > + */
> > +static void __init gpio_no_direction(u32 addr)
> > +{
> > +	__raw_writeb(0x00, addr);
> > +}
> > +
> Now that we have 3 instances of the same routine, it's probably about
> time to consolidate them in the mach-shmobile gpio.h. While we're at it,
> it's probably worth renaming to gpio_direction_none(), so it matches the
> other routines. In the future this will be replaced by the pinconf API.

OK.
I send patch for it.

Best regards
---
Kuninori Morimoto
