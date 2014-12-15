From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 15 Dec 2014 08:49:15 +0000
Subject: Re: [PATCH v2] gpio: rcar: Add r8a7793 and r8a7794 support
Message-Id: <1524147.icrOVo31mS@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1415361248-24610-1-git-send-email-ykaneko0929@gmail.com> <2188270.mR2n2an5Xq@avalon> <CANqRtoTA+sPUT8enk_BCzi7Z5xG4Ump29hCAJgm47JgVXoF9WQ@mail.gmail.com>
In-Reply-To: <CANqRtoTA+sPUT8enk_BCzi7Z5xG4Ump29hCAJgm47JgVXoF9WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-gpio <linux-gpio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Simon Horman <horms@verge.net.au>, SH-Linux <linux-sh@vger.kernel.org>

Hi Magnus,

On Monday 15 December 2014 11:03:49 Magnus Damm wrote:
> On Sat, Dec 13, 2014 at 4:17 AM, Laurent Pinchart wrote:
> > On Friday 07 November 2014 20:54:08 Yoshihiro Kaneko wrote:
> >> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> >> 
> >> The device tree probing for R-Car M2-N (r8a7793) and R-Car E2 (r8a7794)
> >> is added.
> >> 
> >> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> >> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> >> ---
> >> 
> >> This patch is based on for-next branch of Linus Walleij's gpio tree.
> >> 
> >> v2 [Yoshihiro Kaneko]
> >> * As suggested by Geert Uytterhoeven
> >> 
> >>   - clean up 4 identical copies of struct gpio_rcar_info.
> >>  
> >>  .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |  4 +++-
> >>  drivers/gpio/gpio-rcar.c                           | 27 +++++++++-------
> >>  2 files changed, 21 insertions(+), 10 deletions(-)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> >> b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt index
> >> 941a26a..38fb86f 100644
> >> --- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> >> +++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> >> 
> >> @@ -6,7 +6,9 @@ Required Properties:
> >>      - "renesas,gpio-r8a7778": for R8A7778 (R-Mobile M1) compatible GPIO
> >> controller.
> >>      - "renesas,gpio-r8a7779": for R8A7779 (R-Car H1) compatible GPIO
> >> controller.
> >>      - "renesas,gpio-r8a7790": for R8A7790 (R-Car H2) compatible GPIO
> >> controller.
> >> -    - "renesas,gpio-r8a7791": for R8A7791 (R-Car M2) compatible GPIO
> >> controller.
> >> +    - "renesas,gpio-r8a7791": for R8A7791 (R-Car M2-W) compatible GPIO
> >> controller.
> >> +    - "renesas,gpio-r8a7793": for R8A7793 (R-Car M2-N) compatible GPIO
> >> controller.
> >> +    - "renesas,gpio-r8a7794": for R8A7794 (R-Car E2) compatible GPIO
> >> controller.
> >> 
> >>      - "renesas,gpio-rcar": for generic R-Car GPIO controller.
> >>    
> >>    - reg: Base address and length of each memory resource used by the
> >>    GPIO
> >> 
> >> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> >> index ef71ca8..24f0343 100644
> >> --- a/drivers/gpio/gpio-rcar.c
> >> +++ b/drivers/gpio/gpio-rcar.c
> >> @@ -1,6 +1,7 @@
> >>  /*
> >>   * Renesas R-Car GPIO Support
> >>   *
> >> + *  Copyright (C) 2014 Renesas Electronics Corporation
> >>   *  Copyright (C) 2013 Magnus Damm
> >>   *
> >>   * This program is free software; you can redistribute it and/or modify
> >> @@ -315,22 +316,30 @@ struct gpio_rcar_info {
> >>       bool has_both_edge_trigger;
> >>  };
> >> 
> >> +static const struct gpio_rcar_info gpio_rcar_info_gen1 = {
> >> +     .has_both_edge_trigger = false,
> >> +};
> >> +
> >> +static const struct gpio_rcar_info gpio_rcar_info_gen2 = {
> >> +     .has_both_edge_trigger = true,
> >> +};
> > 
> > Seriously, doesn't this call for a "renesas,gpio-rcar-gen2" compatible
> > string ?
> 
> Maybe, but only if we had a crystal ball and could predict that the IP
> would be guaranteed not to change inside future Gen2 devices! =)

Do we expect future Gen2 devices ? And if they happen to be incompatible we 
could call them v2.5 ;-)

-- 
Regards,

Laurent Pinchart

