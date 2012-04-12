From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 12 Apr 2012 00:11:12 +0000
Subject: Re: [PATCH 1/2 v2] sh: Add initial support for SH7734 CPU subtype
Message-Id: <20120412001112.GB7368@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1334188415-14427-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1334188415-14427-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 12, 2012 at 08:53:34AM +0900, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
> 
> V2: Fix build clock framework on 3.4-rc2
> 
If you are adding a new CPU then you at least need some changelog
outlining some basic information about it, what you are supporting, etc.

> +struct clk *clks[] = {
> +	&sh7734_ifs_clk,
> +	&sh7734_sfs_clk,
> +	&sh7734_bfs_clk,
> +	&sh7734_mfs_clk,
> +	&sh7734_s1fs_clk,
> +	&sh7734_pfs_clk,
> +};
> +
These are all div4 clocks, use the div4 clock API.

> +#include <linux/usb/ehci-sh.h>

I don't see this in mainline or my tree. If you are going to send me
patches that you know won't build or have a dependency that hasn't been
met, you either need to state it clearly, or I'll just ignore the entire
series.

> +/* SCIF */
> +static struct plat_sci_port scif0_platform_data = {
> +	.mapbase        = 0xFFE40000,
> +	.flags          = UPF_BOOT_AUTOCONF,
> +	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
> +	.scbrr_algo_id  = SCBRR_ALGO_2,
> +	.type           = PORT_SCIF,
> +	.irqs           = { evt2irq(0x8C0),
> +						evt2irq(0x8C0),
> +						evt2irq(0x8C0),
> +						evt2irq(0x8C0) },
> +	.regtype        = SCIx_SH4_SCIF_REGTYPE,
> +};
> +
You can use SCIx_IRQ_MUXED() for these.
