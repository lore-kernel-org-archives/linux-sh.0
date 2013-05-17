From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 17 May 2013 00:31:42 +0000
Subject: Re: [PATCH 02/12] sh-pfc: r8a7778: add HSPI pin groups
Message-Id: <87y5bev444.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvxnwg43.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvxnwg43.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Sergei

> > Add HSPI CLK/CS/RX/TX pin groups to R8A7778 PFC driver.
> 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >   drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   61 ++++++++++++++++++++++++++++++++++
> >   1 file changed, 61 insertions(+)
> 
> > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> > index ed78f74..137dd59 100644
> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> > @@ -1365,6 +1365,43 @@ I2C_PFC_DAT(i2c3_b,	SDA3_B,			SCL3_B);
> >   I2C_PFC_PIN(i2c3_c,	RCAR_GP_PIN(1, 22),	RCAR_GP_PIN(1, 23));
> >   I2C_PFC_DAT(i2c3_c,	SDA3_C,			SCL3_C);
> >
> > +/* - HSPI macro --------------------------------------------------------------*/
> > +#define HSPI_PFC_PIN(name, args...)		SH_PFC_PINS(name, args)
> > +#define HSPI_PFC_DAT(name, clk, cs, rx, tx)	SH_PFC_MUX4(name, clk, cs, rx, tx)
> 
>     Same comments about the dubious macro naming as in I2C patch. Also, 
> I that suspect CS signal is optional.

I want existing style. r8a7779 doesn't separate it

Best regards
---
Kuninori Morimoto
