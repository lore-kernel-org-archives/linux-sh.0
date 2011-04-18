From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 18 Apr 2011 09:36:13 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-sh7372: remove status check from fsidiv_recalc
Message-Id: <20110418093613.GG32457@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 14, 2011 at 05:13:22PM +0900, Kuninori Morimoto wrote:
> clock status check is not needed in recalc function.
> clk->rate will be 0 in clk_set_rate without this patch.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 

On Thu, Apr 14, 2011 at 05:13:53PM +0900, Kuninori Morimoto wrote:
> div6 clock should not use arch_flags for clk_rate_table_build,
> because SH_CLK_DIV6_EXT doesn't care .arch_flags.
> clk->freq_table[] will be all CPUFREQ_ENTRY_INVALID without this patch.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Both applied, thanks.
