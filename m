From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Nov 2010 04:00:30 +0000
Subject: Re: [PATCH] sh: Add div6_reparent_clks to clock framework for FSI
Message-Id: <20101129040030.GB709@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3ptyj4o22h.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3ptyj4o22h.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 26, 2010 at 06:40:22PM +0900, Kuninori Morimoto wrote:
> Current clk_ops doesn't support .init which
> is used to select external clock on ecovec
> without CONFIG_SH_CLK_CPG_LEGACY.
> To solve this problem, this patch add div6_reparent_clks
> to clock-sh7724.
> This patch solve compile error too.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied, thanks.
