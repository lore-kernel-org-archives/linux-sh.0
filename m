From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 31 Aug 2015 10:00:53 +0000
Subject: Re: [PATCH 1/2][RFC] pinctrl: sh-pfc: Initial R8A7795 PFC support
Message-Id: <18242717.vkv89r6G4C@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1y7daou.wl%kuninori.morimoto.gx@renesas.com> <15835467.TaO4P3MKAU@avalon> <87y4gs2bqy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y4gs2bqy.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hello Morimoto-san,

On Monday 31 August 2015 06:53:36 Kuninori Morimoto wrote:
> Hi Laurent
> 
> >> +#define CPU_ALL_PORT(fn, sfx)						\
> >> +	PORT_GP_32(0, fn, sfx),						\
> >> +	PORT_GP_32(1, fn, sfx),						\
> >> +	PORT_GP_32(2, fn, sfx),						\
> >> +	PORT_GP_32(3, fn, sfx),						\
> >> +	PORT_GP_32(4, fn, sfx),						\
> >> +	PORT_GP_32(5, fn, sfx),						\
> >> +	PORT_GP_32(6, fn, sfx),						\
> >> +	PORT_GP_32(7, fn, sfx)
> > 
> > Not all GPIO banks include 32 pins. From a quick look at the datasheet the
> > following GPIO pins are available.
> 
> Thanks. will fix in next version
> 
> >> +	{ PINMUX_CFG_REG_VAR("MOD_SEL1", 0xe6060504, 32,
> >> +			     2, 3, 1, 2, 3, 1, 1, 2, 1,
> >> +			     2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1) {
> 
> (snip)
> 
> >> +		/* SEL_SCIF3 [1] */
> >> +		FN_SEL_SCIF3_0,		FN_SEL_SCIF3_1,
> >> +		/* SEL_SCIF2 [1] */
> >> +		FN_SEL_SCIF2_0,		FN_SEL_SCIF2_1,
> >> +		/* SEL_SCIF1 [1] */
> >> +		FN_SEL_SCIF1_0,		FN_SEL_SCIF1_1,
> >> +		/* SEL_SCIF [1] */
> >> +		FN_SEL_SCIF_0,		FN_SEL_SCIF_1,
> >> +		/* SEL_REMOCON [1] */
> >> +		FN_SEL_REMOCON_0,	FN_SEL_REMOCON_1,
> >> +		/* RESERVED [2] */
> >> +		0, 0, 0, 0,
> > 
> > According to the datasheet those two bits are supposed to control the RDS
> > clock and data pins (whatever they are).
> 
> Thank you, but sorry.
> Latest version indicates these are reserved bit.

My bad, I had checked an older version of the datasheet.

-- 
Regards,

Laurent Pinchart

