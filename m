From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon, 04 Jul 2016 16:12:23 +0000
Subject: Re: [PATCH v4 14/22] sh: SH7751 core dtsi
Message-Id: <87k2h12xi0.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
	<1467207667-15768-15-git-send-email-ysato@users.sourceforge.jp>
	<CAMuHMdXPfP+A4PFy81bRoq4Va=5JpgCz2M3D6icWf0zCGTw8pA@mail.gmail.com>
In-Reply-To: <CAMuHMdXPfP+A4PFy81bRoq4Va=5JpgCz2M3D6icWf0zCGTw8pA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 04 Jul 2016 16:15:31 +0900,
Geert Uytterhoeven wrote:
> 
> Hi Sato-san,
> 
> On Wed, Jun 29, 2016 at 3:40 PM, Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/renesas-sh7750.h
> > @@ -0,0 +1,26 @@
> > +/*
> > + * Copyright (C) 2016 Yoshinori Sato
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +#ifndef __DT_BINDINGS_CLOCK_RENESAS_SH7750_H__
> > +#define __DT_BINDINGS_CLOCK_RENESAS_SH7750_H__
> > +
> > +#define SH7750_CLK_SCI 0
> > +#define SH7750_CLK_RTC 1
> > +#define SH7750_CLK_TMU0        2
> > +#define SH7750_CLK_TMU1        3
> > +#define SH7750_CLK_TMU2        4
> > +#define SH7750_CLK_SCIF        5
> > +#define SH7750_CLK_DMAC        6
> > +#define SH7750_CLK_UBC 7
> > +#define SH7750_CLK_SQ  8
> > +#define SH7750_CLK_INTC 9
> > +#define SH7750_CLK_TMU3        10
> > +#define SH7750_CLK_TMU4        11
> > +#define SH7750_CLK_PCIC        12
> 
> Looking at the table in drivers/clk/sh/clk-sh7750cpg.c, SH7750_CLK_CORE seems
> to be missing?

Yes.
I forgot it.

> > +
> > +#endif /* __DT_BINDINGS_CLOCK_RENESAS_CPG_MSSR_H__ */
> 
> Relic from the Renesas CPG/MSSR driver.

OK.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
