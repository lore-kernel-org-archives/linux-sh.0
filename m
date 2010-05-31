From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 31 May 2010 04:52:01 +0000
Subject: Re: [PATCH v3] ARM: mach-shmobile: ap4evb: Add FSI2 support
Message-Id: <20100531045201.GH20358@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pbpc594jf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pbpc594jf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 24, 2010 at 03:50:44PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 
> o remove name and id from fsiackcr_clk
> o use IS_ERR_VALUE for clk_get err check 
> o use CLKDEV_DEV_ID and driver name for clk_lookup
> o CLK_ENABLE_ON_INIT is used in mstp_clks because SH-ARM doesn't support PM now.
> 
>  arch/arm/mach-shmobile/board-ap4evb.c |  135 ++++++++++++++++++++++++++++++++-
>  arch/arm/mach-shmobile/clock-sh7372.c |    4 +-
>  2 files changed, 135 insertions(+), 4 deletions(-)
> 
Applied, thanks.
