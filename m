From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 07 Nov 2011 04:44:01 +0000
Subject: Re: [PATCH 2.2/5 v2] ARM: mach-shmobile: R-Mobile A1 PFC support.
Message-Id: <20111107044401.GB3927@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <871utksrir.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871utksrir.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Nov 06, 2011 at 04:30:39PM -0800, Kuninori Morimoto wrote:
> +#define _1(fn, pfx, sfx) fn(pfx, sfx)
> +
> +#define _10(fn, pfx, sfx)				\
> +	_1(fn, pfx##0, sfx), _1(fn, pfx##1, sfx),	\
> +	_1(fn, pfx##2, sfx), _1(fn, pfx##3, sfx),	\
> +	_1(fn, pfx##4, sfx), _1(fn, pfx##5, sfx),	\
> +	_1(fn, pfx##6, sfx), _1(fn, pfx##7, sfx),	\
> +	_1(fn, pfx##8, sfx), _1(fn, pfx##9, sfx)
> +
..

> +
> +#define _PORT(pfx, sfx) pfx##_##sfx
> +
Perhaps these are better off moved in to a pfc helper header, before we
start copying them all over the place.

> +#define _IO___(nr) \
> +	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0,	\
> +		    PORT##nr##_OUT, PORT##nr##_IN)
> +
> +#define _IO__D(nr) \
> +	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0,	\
> +		    PORT##nr##_OUT, PORT##nr##_IN, PORT##nr##_IN_PD)
> +
> +#define _IO_U_(nr) \
> +	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0,	\
> +		    PORT##nr##_OUT, PORT##nr##_IN, PORT##nr##_IN_PU)
> +
> +#define _IO_UD(nr) \
> +	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0,	\
> +		    PORT##nr##_OUT, PORT##nr##_IN,	\
> +		    PORT##nr##_IN_PD, PORT##nr##_IN_PU)
> +
Likewise for these.

You can just move the definitions out from pfc-sh7367.c and stick with
the verbose names. There's very little value in this sort of obfuscation.

> +/* helper for top 4 bits in PORTnCR */
> +#define PCRH(in, in_pd, in_pu, out)	\
> +	0, (out), (in), 0,		\
> +	0, 0, 0, 0,			\
> +	0, 0, (in_pd), 0,		\
> +	0, 0, (in_pu), 0
> +
> +#define PORTCR(nr, reg)	\
> +	{ PINMUX_CFG_REG("PORT" nr "CR", reg, 8, 4) {		\
> +		PCRH(PORT##nr##_IN,  PORT##nr##_IN_PD,		\
> +		     PORT##nr##_IN_PU, PORT##nr##_OUT),		\
> +		PORT##nr##_FN0, PORT##nr##_FN1,	PORT##nr##_FN2,	\
> +		PORT##nr##_FN3,	PORT##nr##_FN4, PORT##nr##_FN5,	\
> +		PORT##nr##_FN6, PORT##nr##_FN7 }		\
> +	}
> +
These too.
