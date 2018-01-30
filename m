From: jacopo mondi <jacopo@jmondi.org>
Date: Tue, 30 Jan 2018 09:47:51 +0000
Subject: Re: [PATCH v7 07/11] media: i2c: ov772x: Support frame interval handling
Message-Id: <20180130092808.GA11063@w540>
List-Id: <linux-sh.vger.kernel.org>
References: <1516974930-11713-1-git-send-email-jacopo+renesas@jmondi.org>
 <1516974930-11713-8-git-send-email-jacopo+renesas@jmondi.org>
 <1735356.2kmgrjUaxx@avalon>
In-Reply-To: <1735356.2kmgrjUaxx@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, geert-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pombredanne-od1rfyK75/E@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Laurent,

On Mon, Jan 29, 2018 at 01:01:01PM +0200, Laurent Pinchart wrote:
> Hi Jacopo,
>
> Thank you for the patch.
>
> On Friday, 26 January 2018 15:55:26 EET Jacopo Mondi wrote:
> > Add support to ov772x driver for frame intervals handling and enumeration.
> > Tested with 10MHz and 24MHz input clock at VGA and QVGA resolutions for
> > 10, 15 and 30 frame per second rates.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> > drivers/media/i2c/ov772x.c | 315 +++++++++++++++++++++++++++++++++++++++++-
> > 1 file changed, 310 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ov772x.c b/drivers/media/i2c/ov772x.c
> > index 912b1b9..6d46748 100644
> > --- a/drivers/media/i2c/ov772x.c
> > +++ b/drivers/media/i2c/ov772x.c
> > @@ -250,6 +250,7 @@
> >  #define AEC_1p2         0x10	/*  01: 1/2  window */
> >  #define AEC_1p4         0x20	/*  10: 1/4  window */
> >  #define AEC_2p3         0x30	/*  11: Low 2/3 window */
> > +#define COM4_RESERVED   0x01	/* Reserved value */
>
> I'd write "Reserved bits", "Reserved value" makes it sound like it's the value
> of the full register.
>

Ack

> >  /* COM5 */
> >  #define AFR_ON_OFF      0x80	/* Auto frame rate control ON/OFF selection
> */
> > @@ -267,6 +268,19 @@
> >  				/* AEC max step control */
> >  #define AEC_NO_LIMIT    0x01	/*   0 : AEC incease step has limit */
> >  				/*   1 : No limit to AEC increase step */
> > +/* CLKRC */
> > +				/* Input clock divider register */
> > +#define CLKRC_RESERVED  0x80	/* Reserved value */
> > +#define CLKRC_BYPASS    0x40	/* Bypass input clock divider */
> > +#define CLKRC_DIV2      0x01	/* Divide input clock by 2 */
> > +#define CLKRC_DIV3      0x02	/* Divide input clock by 3 */
> > +#define CLKRC_DIV4      0x03	/* Divide input clock by 4 */
> > +#define CLKRC_DIV5      0x04	/* Divide input clock by 5 */
> > +#define CLKRC_DIV6      0x05	/* Divide input clock by 6 */
> > +#define CLKRC_DIV8      0x07	/* Divide input clock by 8 */
> > +#define CLKRC_DIV10     0x09	/* Divide input clock by 10 */
> > +#define CLKRC_DIV16     0x0f	/* Divide input clock by 16 */
> > +#define CLKRC_DIV20     0x13	/* Divide input clock by 20 */
>
> How about just
>
> #define CLKRC_DIV(n)		((n) - 1)
>

Ack again,

> >  /* COM7 */
> >  				/* SCCB Register Reset */
> > @@ -373,6 +387,12 @@
> >  #define VERSION(pid, ver) ((pid<<8)|(ver&0xFF))
> >
> >  /*
> > + * Input clock frequencies
> > + */
> > +enum { OV772X_FIN_10MHz, OV772X_FIN_24MHz, OV772X_FIN_48MHz, OV772X_FIN_N,
> > };
> > +static unsigned int ov772x_fin_vals[] = { 10000000, 24000000, 48000000
> > };
> > +
> > +/*
> >   * struct
> >   */
> >
> > @@ -391,6 +411,16 @@ struct ov772x_win_size {
> >  	struct v4l2_rect	  rect;
> >  };
> >
> > +struct ov772x_pclk_config {
> > +	u8 com4;
> > +	u8 clkrc;
> > +};
> > +
> > +struct ov772x_frame_rate {
> > +	unsigned int fps;
> > +	const struct ov772x_pclk_config pclk[OV772X_FIN_N];
> > +};
> > +
> >  struct ov772x_priv {
> >  	struct v4l2_subdev                subdev;
> >  	struct v4l2_ctrl_handler	  hdl;
> > @@ -404,6 +434,7 @@ struct ov772x_priv {
> >  	unsigned short                    flag_hflip:1;
> >  	/* band_filter = COM8[5] ? 256 - BDBASE : 0 */
> >  	unsigned short                    band_filter;
> > +	unsigned int			  fps;
> >  };
> >
> >  /*
> > @@ -508,6 +539,154 @@ static const struct ov772x_win_size ov772x_win_sizes[]
> > = { };
> >
> >  /*
> > + * frame rate settings lists
> > + */
> > +unsigned int ov772x_frame_intervals[] = {10, 15, 30, 60};
> > +#define OV772X_N_FRAME_INTERVALS ARRAY_SIZE(ov772x_frame_intervals)
> > +
> > +static const struct ov772x_frame_rate vga_frame_rates[] = {
> > +	{	/* PCLK = 7,5 MHz */
> > +		.fps		= 10,
> > +		.pclk = {
> > +			[OV772X_FIN_10MHz] = {
> > +				.com4	= PLL_6x | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV8 | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_24MHz] = {
> > +				.com4	= PLL_BYPASS | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV3 | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_48MHz] = {
> > +				.com4	= PLL_BYPASS | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV6 | CLKRC_RESERVED,
> > +			},
> > +		},
> > +	},
> > +	{	/* PCLK = 12 MHz */
> > +		.fps		= 15,
> > +		.pclk = {
> > +			[OV772X_FIN_10MHz]	= {
> > +				.com4	= PLL_4x | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV3 | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_24MHz]	= {
> > +				.com4	= PLL_BYPASS | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV2 | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_48MHz]	= {
> > +				.com4	= PLL_BYPASS | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV4 | CLKRC_RESERVED,
> > +			},
> > +		},
> > +	},
> > +	{	/* PCLK = 24 MHz */
> > +		.fps		= 30,
> > +		.pclk = {
> > +			[OV772X_FIN_10MHz]	= {
> > +				.com4	= PLL_8x | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV3 | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_24MHz]	= {
> > +				.com4	= PLL_BYPASS | COM4_RESERVED,
> > +				.clkrc	= CLKRC_BYPASS | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_48MHz]	= {
> > +				.com4	= PLL_BYPASS | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV2 | CLKRC_RESERVED,
> > +			},
> > +		},
> > +	},
> > +	{	/* PCLK = 48 MHz */
> > +		.fps		= 60,
> > +		.pclk = {
> > +			[OV772X_FIN_10MHz]	= {
> > +				.com4	= PLL_8x | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV2 | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_24MHz]	= {
> > +				.com4	= PLL_4x | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV2 | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_48MHz]	= {
> > +				.com4	= PLL_BYPASS | COM4_RESERVED,
> > +				.clkrc	= CLKRC_BYPASS | CLKRC_RESERVED,
> > +			},
> > +		},
> > +	},
> > +};
> > +
> > +static const struct ov772x_frame_rate qvga_frame_rates[] = {
> > +	{	/* PCLK = 3,2 MHz */
> > +		.fps		= 10,
> > +		.pclk = {
> > +			[OV772X_FIN_10MHz] = {
> > +				.com4	= PLL_6x | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV16 | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_24MHz] = {
> > +				.com4	= PLL_BYPASS | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV8 | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_48MHz] = {
> > +				.com4	= PLL_BYPASS | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV16 | CLKRC_RESERVED,
> > +			},
> > +		},
> > +	},
> > +	{	/* PCLK = 4,8 MHz */
> > +		.fps		= 15,
> > +		.pclk = {
> > +			[OV772X_FIN_10MHz]	= {
> > +				.com4	= PLL_BYPASS | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV2 | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_24MHz]	= {
> > +				.com4	= PLL_BYPASS | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV5 | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_48MHz]	= {
> > +				.com4	= PLL_BYPASS | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV10 | CLKRC_RESERVED,
> > +			},
> > +		},
> > +	},
> > +	{	/* PCLK = 9,6 MHz */
> > +		.fps		= 30,
> > +		.pclk = {
> > +			[OV772X_FIN_10MHz]	= {
> > +				.com4	= PLL_BYPASS | COM4_RESERVED,
> > +				.clkrc	= CLKRC_BYPASS | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_24MHz]	= {
> > +				.com4	= PLL_4x | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV10 | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_48MHz]	= {
> > +				.com4	= PLL_4x | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV20 | CLKRC_RESERVED,
> > +			},
> > +		},
> > +	},
> > +	{	/* PCLK = 19 MHz */
> > +		.fps		= 60,
> > +		.pclk = {
> > +			[OV772X_FIN_10MHz]	= {
> > +				.com4	= PLL_4x | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV2 | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_24MHz]	= {
> > +				.com4	= PLL_6x | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV8 | CLKRC_RESERVED,
> > +			},
> > +			[OV772X_FIN_48MHz]	= {
> > +				.com4	= PLL_6x | COM4_RESERVED,
> > +				.clkrc	= CLKRC_DIV16 | CLKRC_RESERVED,
> > +			},
> > +		},
> > +	},
> > +};
> > +
> > +/*
> >   * general function
> >   */
>
> I'm afraid I'll have to ask the obvious: could we replace this table with
> dynamic computation ? You might be able to reuse the (probably badly named)
> aptina-pll library from drivers/media/i2c/
>

Mmmm, okay... I might be able to use the above mentioned library,
but that's designed for a still simple but more complex PLL with 2
dividers and one multiplier. I know I can model it to work on ov7720
PLL using limits, but since I only have 4 possible PLL multipliers
(1x, 2x, 4x, 8x) and a single divider it is simpler to test all 4 of
them and see which one approximate the desired pixel clock.

I will send v8 with this changed shortly.

Thanks
   j

