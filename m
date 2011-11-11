From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 11 Nov 2011 03:05:34 +0000
Subject: Re: [PATCH 03/20] sh: clkfwk: add clk_rate_mult_range_round()
Message-Id: <20111111030534.GD29807@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87wrb79y5e.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wrb79y5e.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 10, 2011 at 06:43:44PM -0800, Kuninori Morimoto wrote:
> Some clock pulse generator has PLL multiplication.
> clk_rate_mult_range_round() will be good helper for it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/sh/clk/core.c  |   20 ++++++++++++++++++++
>  include/linux/sh_clk.h |    3 +++
>  2 files changed, 23 insertions(+), 0 deletions(-)
> 
This is already applied to my common/clkfwk branch. I'll be sending it
out with the -rc2 updates.
