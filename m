From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 08 Jun 2009 10:03:27 +0000
Subject: Re: [PATCH] sh: sh7724 clock framework rewrite V2
Message-Id: <umy8j59g0.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090602103459.13411.85023.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090602103459.13411.85023.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

I checked this patch. and it works.
But I found bug

> This patch contains V2 of the sh7724 clock framework
> rewrite. The new code makes use of the recently merged
> div4, div6 and mstp32 helper code. Both extal and fll are
> supported as input clocks to the pll. The div6 clocks are
> fed through a divide-by-3 block.


> -	MSTPCR("tmu1", "peripheral_clk", 0, 10, 0),
(snip)
> +	MSTP("flctl0", &div4_clks[DIV4_P], MSTPCR0, 10, 0, 1, 0),

I wonder your manual is old one.
old manual is very bad, and it say lie sometimes.

correct MSTP010 is "tmu1" here

Best regards
--
Kuninori Morimoto
