From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Dec 2018 14:45:26 +0000
Subject: Re: [PATCH 10/15] pinctrl: sh-pfc: sh7734: Fix shifted values in IPSR10
Message-Id: <CAMuHMdW-r42PNxESV4w26F=D=xTFpeyWX0WuOEcNYZWMRsXS4w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
 <20181213182714.26094-11-geert+renesas@glider.be> <20181217143742.4qsndrcickp3hsyw@verge.net.au>
In-Reply-To: <20181217143742.4qsndrcickp3hsyw@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>

Hi Simon,

On Mon, Dec 17, 2018 at 3:37 PM Simon Horman <horms@verge.net.au> wrote:
> On Thu, Dec 13, 2018 at 07:27:09PM +0100, Geert Uytterhoeven wrote:
> > Some values in the Peripheral Function Select Register 10 descriptor are
> > shifted by one position, which may cause a peripheral function to be
> > programmed incorrectly.
> >
> > Fixing this makes all HSCIF0 pins use Function 4 (value 3), like was
> > already the case for the HSCK0 pin in field IP10[5:3].
> >
> > Fixes: ac1ebc2190f575fc ("sh-pfc: Add sh7734 pinmux support")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Based on the SH7734 Hardware User's Manual Rev. 1.00.
> > Compile-tested only.
> >
> > Noticed when investigating a different bug in the same register
> > description.
> > ---
> >  drivers/pinctrl/sh-pfc/pfc-sh7734.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
> > index cad70f9cf5699f0c..748a32a3af82d368 100644
> > --- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
> > @@ -2210,22 +2210,22 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
> >           /* IP10_22 [1] */
> >               FN_CAN_CLK_A, FN_RX4_D,
> >           /* IP10_21_19 [3] */
> > -             FN_AUDIO_CLKOUT, FN_TX1_E, FN_HRTS0_C, FN_FSE_B,
> > -             FN_LCD_M_DISP_B, 0, 0, 0,
> > +             FN_AUDIO_CLKOUT, FN_TX1_E, 0, FN_HRTS0_C, FN_FSE_B,
>
> FN_FSE_B does no appear to be documented for this field in Users' Manual
> Hardware v1.00 (Jun 12, 2012). Should it be 0?

None of the FSE bits seem to be documented in the public datasheet, so I
just retained it, maintaining consistency with the surrounding fields.

> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
