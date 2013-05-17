From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 17 May 2013 00:21:24 +0000
Subject: Re: [PATCH 01/12] sh-pfc: r8a7778: add I2C pin groups
Message-Id: <871u96wj5q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87hai3wg4d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hai3wg4d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Sergei

> On 16-05-2013 11:14, Kuninori Morimoto wrote:
> 
> > Add I2C SDA/SCL pin groups to R8A7778 PFC driver.
> 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >   drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   54 ++++++++++++++++++++++++++++++++++
> >   1 file changed, 54 insertions(+)
> 
> > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> > index bc20083..ed78f74 100644
> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> > @@ -1339,6 +1339,32 @@ SH_PFC_MUX1(ether_link,		ETH_LINK);
> >   SH_PFC_PINS(ether_magic,	RCAR_GP_PIN(4, 20));
> >   SH_PFC_MUX1(ether_magic,	ETH_MAGIC);
> >
> > +/* - I2C macro ------------------------------------------------------------- */
> > +#define I2C_PFC_PIN(name, args...)	SH_PFC_PINS(name, args)
> > +#define I2C_PFC_DAT(name, sda, scl)	SH_PFC_MUX2(name, sda, scl)
> 
>      Why not just I2C_PFC_PINS() and I2C_PFC_DATA()?
>      Also, I don't think I2C_PFC_DAT() is a really good name, since the 
> group includes both data and clock lines. Why not just use SH_PFC_MUX2()?

We don't use SH_PFC_MUX2() directly here
it will be I2C_PFC_DATA() in v2



Best regards
---
Kuninori Morimoto
