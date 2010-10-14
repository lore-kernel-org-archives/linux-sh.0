From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Oct 2010 08:50:42 +0000
Subject: Re: [PATCH 1/2] ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock
Message-Id: <w3pr5ftjgym.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pzkuyihfm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pzkuyihfm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

I used your patch
But

> +static int clk_establish_mapping(struct clk *clk)
> +{
> +	struct clk_mapping *mapping = clk->mapping;
> +
> +	/*
> +	 * Propagate mappings.
> +	 */
> +	if (!mapping) {
> +		struct clk *clkp;
> +
> +		/*
> +		 * dummy mapping for root clocks with no specified ranges
> +		 */
> +		if (!clk->parent) {
> +			clk->mapping = &dummy_mapping;
> +			return 0;
> +		}
> +
> +		/*
> +		 * If we're on a child clock and it provides no mapping of its
> +		 * own, inherit the mapping from its root clock.
> +		 */
> +		clkp = lookup_root_clock(clk);
> +		mapping = clkp->mapping;
> +		BUG_ON(!mapping);
> +	}
> +
> +	/*
> +	 * Establish initial mapping.
> +	 */
> +	if (!mapping->base && mapping->phys) {
> +		kref_init(&mapping->ref);
> +		mapping->base = ioremap_nocache(mapping->phys, mapping->len);
> +		if (unlikely(!mapping->base))
> +			return -ENXIO;
> +	} else
> +		/* Existing mapping */
> +		kref_get(&mapping->ref);
> +
> +	clk->mapping = mapping;
> +	return 0;
> +}

If I use this patch on AP4,
It said

------------[ cut here ]------------
WARNING: at /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/lib/kref.c:34 kref_get
+0x20/0x3c()
Modules linked in:
[<c002802c>] (unwind_backtrace+0x0/0xe4) from [<c0031154>] (warn_slowpath_common
+0x4c/0x64)
[<c0031154>] (warn_slowpath_common+0x4c/0x64) from [<c0031184>] (warn_slowpath_n
ull+0x18/0x1c)
[<c0031184>] (warn_slowpath_null+0x18/0x1c) from [<c014a798>] (kref_get+0x20/0x3
c)
[<c014a798>] (kref_get+0x20/0x3c) from [<c01d9fec>] (clk_register+0xdc/0x190)
[<c01d9fec>] (clk_register+0xdc/0x190) from [<c000b8dc>] (sh7372_clock_init+0x20
/0xcc)
[<c000b8dc>] (sh7372_clock_init+0x20/0xcc) from [<c000b9f8>] (ap4evb_timer_init+
0x8/0x30)
[<c000b9f8>] (ap4evb_timer_init+0x8/0x30) from [<c0009d30>] (time_init+0x14/0x1c
)
[<c0009d30>] (time_init+0x14/0x1c) from [<c0008834>] (start_kernel+0x154/0x244)
[<c0008834>] (start_kernel+0x154/0x244) from [<40008034>] (0x40008034)
---[ end trace 1b75b31a2719ed1c ]---

Best regards
--
Kuninori Morimoto
 
