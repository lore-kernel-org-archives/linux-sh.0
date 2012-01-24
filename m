From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 Jan 2012 01:47:27 +0000
Subject: Re: [PATCH] sh: clkfwk: bugfix: use clk_reparent() for div6 clocks
Message-Id: <20120124014727.GE32319@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87aa5k6p8r.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87aa5k6p8r.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 19, 2012 at 01:00:40AM -0800, Kuninori Morimoto wrote:
> Various problems will happen if clk parent was set up directly.
> it should use clk_reparent()
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> This is for linus/master
> 
>  drivers/sh/clk/cpg.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
Applied, thanks.
