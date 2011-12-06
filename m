From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 06 Dec 2011 05:26:46 +0000
Subject: Re: [PATCH 4/4] sh: clock-sh73a0: all div6_clks use SH_CLK_DIV6_EXT()
Message-Id: <20111206052646.GF30055@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <871usj8r6b.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871usj8r6b.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Dec 04, 2011 at 10:32:16PM -0800, Kuninori Morimoto wrote:
> Current div6 clocks can specify their current parent clocks
> from its register value if it is registered
> by sh_clk_div6_reparent_register().
> This patch modifies all div6 clocks into SH_CLK_DIV6_EXT().
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This one looks fine too, although it will need to be respun to not depend
on 2/4.
