From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 07 Nov 2011 04:38:45 +0000
Subject: Re: [PATCH 2.1/5 v2] ARM: mach-shmobile: R-Mobile A1 support.
Message-Id: <20111107043844.GA3927@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <8739e0srjd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8739e0srjd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Nov 06, 2011 at 04:30:17PM -0800, Kuninori Morimoto wrote:
> +enum {	DIV4_I, DIV4_ZG, DIV4_B, DIV4_M1, DIV4_HP,
> +	DIV4_HPP, DIV4_S, DIV4_ZB, DIV4_M3, DIV4_CP,
> +	DIV4_NR
> +};
> +
For enum definitions I generally prefer:

enum {
	...
};

rather than bringing the definitions up to the enum line. This keeps more
in line with structure definitions and so on as well.

> +#define DIV4(_reg, _bit, _mask, _flags) \
> +	SH_CLK_DIV4(&pllc1_clk, _reg, _bit, _mask, _flags)
> +
> +struct clk div4_clks[DIV4_NR] = {
> +	[DIV4_I]	= DIV4(FRQCRA, 20, 0x6fff, CLK_ENABLE_ON_INIT),
> +	[DIV4_ZG]	= DIV4(FRQCRA, 16, 0x6fff, CLK_ENABLE_ON_INIT),
> +	[DIV4_B]	= DIV4(FRQCRA,  8, 0x6fff, CLK_ENABLE_ON_INIT),
> +	[DIV4_M1]	= DIV4(FRQCRA,  4, 0x6fff, CLK_ENABLE_ON_INIT),
> +	[DIV4_HP]	= DIV4(FRQCRB,  4, 0x6fff, 0),
> +	[DIV4_HPP]	= DIV4(FRQCRC, 20, 0x6fff, 0),
> +	[DIV4_S]	= DIV4(FRQCRC, 12, 0x6fff, 0),
> +	[DIV4_ZB]	= DIV4(FRQCRC,  8, 0x6fff, 0),
> +	[DIV4_M3]	= DIV4(FRQCRC,  4, 0x6fff, 0),
> +	[DIV4_CP]	= DIV4(FRQCRC,  0, 0x6fff, 0),
> +};
> +
I'd prefer that we simply stick with SH_CLK_DIV4. All of these wrappers
to wrappers are just irritating, regardless of whether it helps cut down
on a bit of screen real estate or not.

The whole reason we have SH_CLK_DIV4 is to already make things less
verbose, I don't see any valid reason for wrapping it a second time.

> +#define MSTP(_parent, _reg, _bit, _flags) \
> +	SH_CLK_MSTP32(_parent, _reg, _bit, _flags)
> +
Likewise for these.

> +	/* detect RCLK parent */
> +	switch (md_ck & (MD_CK2 | MD_CK1)) {
> +	case 0 | 0:
> +	case 0 | MD_CK1:
> +		r_clk.parent = &extalr_clk;
> +		break;
> +	case MD_CK2 | 0:
> +		r_clk.parent = &extal1_div1024_clk;
> +		break;
> +	case MD_CK2 | MD_CK1:
> +		r_clk.parent = &extal1_div2048_clk;
> +	}
> +
I'm a bit confused as to what the point of the | 0 stuff is. Why not
just:

	switch (md_ck & (MD_CK2 | MD_CK1)) {
	case MD_CK2 | MD_CK1:
		...
	case MD_CK2:
		...
	case MD_CK1:
	default:
		...
	}

> +/* SCIFA0 */
> +static struct plat_sci_port scif0_platform_data = {
> +	.mapbase	= 0xe6c40000,
> +	.flags		= UPF_BOOT_AUTOCONF,
> +	.scscr		= SCSCR_RE | SCSCR_TE,
> +	.scbrr_algo_id	= SCBRR_ALGO_4,
> +	.type		= PORT_SCIFA,
> +	.irqs		= { gic_spi(100), gic_spi(100),
> +			    gic_spi(100), gic_spi(100) },
> +};
> +
Please use SCIx_IRQ_MUXED() for all of the muxed IRQs.
