From: Simon Horman <horms@verge.net.au>
Date: Thu, 28 Aug 2014 08:31:48 +0000
Subject: Re: [PATCH 01/05] ARM: shmobile: armadillo800eva: Sync DTS
Message-Id: <20140828083144.GA14081@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140828033451.18867.84721.sendpatchset@w520>
In-Reply-To: <20140828033451.18867.84721.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 28, 2014 at 09:45:20AM +0200, Geert Uytterhoeven wrote:
> Hi Magnus,
> 
> On Thu, Aug 28, 2014 at 5:34 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > +++ work/arch/arm/boot/dts/r8a7740-armadillo800eva.dts  2014-08-27 18:37:05.000000000 +0900
> > @@ -10,10 +10,18 @@
> >
> >  /dts-v1/;
> >  #include "r8a7740.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/pwm/pwm.h>
> >
> >  / {
> >         model = "armadillo 800 eva";
> > -       compatible = "renesas,armadillo800eva";
> > +       compatible = "renesas,armadillo800eva", "renesas,r8a7740";
> 
> As this isn't a Renesas board (but we can't break backwards-compatibility),
> shouldn't you add "atmark-techno,armadillo800eva"?

FWIW, I believe that logic would also apply to at least the kzm9d and kzm9g.

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
> 
