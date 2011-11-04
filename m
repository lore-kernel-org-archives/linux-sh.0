From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Nov 2011 16:05:22 +0000
Subject: Re: [PATCH 07/10 v2] sh: clkfwk: add clk_rate_mult_range_round()
Message-Id: <20111104160522.GE29825@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 19, 2011 at 06:51:13PM -0700, Kuninori Morimoto wrote:
> Some llock pulse generator has PLL multiplication.
> clk_rate_mult_range_round() will be good helper for it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
> o xx_multi_xx -> xx_mult_xx
> o div_xxx -> mult_xxx
> 
>  drivers/sh/clk/core.c  |   20 ++++++++++++++++++++
>  include/linux/sh_clk.h |    3 +++
>  2 files changed, 23 insertions(+), 0 deletions(-)
> 
I've applied this one now, though it will take a bit to get the rest of
the series sorted out.
