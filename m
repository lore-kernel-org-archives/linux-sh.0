From: Stephen Boyd <sboyd@codeaurora.org>
Date: Fri, 28 Aug 2015 17:20:30 +0000
Subject: Re: [PATCH v3 03/04] clk: shmobile: Add Renesas R-Car Gen3 CPG support
Message-Id: <20150828172030.GZ19120@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20150828091550.21731.85227.sendpatchset@little-apple>
 <20150828091624.21731.11014.sendpatchset@little-apple>
In-Reply-To: <20150828091624.21731.11014.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk@vger.kernel.org, kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org, mturquette@baylibre.com, gaku.inami.xw@bp.renesas.com, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com

On 08/28, Magnus Damm wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> 
> This patch adds very initial CPG support.
> R-Car Gen3 write function should use CPG write protection method
> which is shared with MSTP driver. This patch has it but not used.
> 
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---

I think I already reviewed this, but it looks like none of the
comments were addressed in this posting

http://lkml.kernel.org/r/20150825224638.GL19120@codeaurora.org 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
