From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Apr 2013 15:35:39 +0000
Subject: Re: [PATCH v3] ARM: shmobile: r8a7779: Add PCIe clocks
Message-Id: <20130409153539.GB13831@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365518115-4410-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1365518115-4410-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 09, 2013 at 03:35:15PM +0100, Phil Edworthy wrote:
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Thanks, this time I really queued it up.
It is in the soc-r8a7779 branch.

> ---
> v3:
>   Rebased on renesas soc branch again.
> v2:
>   Rebased on renesas soc branch.
>   Removed ".0" from clock name.
> 
>  arch/arm/mach-shmobile/clock-r8a7779.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
> index 7d86bfb..f66cf85 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7779.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7779.c
> @@ -93,7 +93,7 @@ static struct clk *main_clks[] = {
>  };
>  
>  enum { MSTP323, MSTP322, MSTP321, MSTP320,
> -	MSTP115,
> +	MSTP116, MSTP115,
>  	MSTP103, MSTP101, MSTP100,
>  	MSTP030,
>  	MSTP029, MSTP028, MSTP027, MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
> @@ -106,6 +106,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP322] = SH_CLK_MSTP32(&clkp_clk, MSTPCR3, 22, 0), /* SDHI1 */
>  	[MSTP321] = SH_CLK_MSTP32(&clkp_clk, MSTPCR3, 21, 0), /* SDHI2 */
>  	[MSTP320] = SH_CLK_MSTP32(&clkp_clk, MSTPCR3, 20, 0), /* SDHI3 */
> +	[MSTP116] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1, 16, 0), /* PCIe */
>  	[MSTP115] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1, 15, 0), /* SATA */
>  	[MSTP103] = SH_CLK_MSTP32(&clks_clk, MSTPCR1,  3, 0), /* DU */
>  	[MSTP101] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1,  1, 0), /* USB2 */
> @@ -141,6 +142,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_CON_ID("peripheral_clk",	&clkp_clk),
>  
>  	/* MSTP32 clocks */
> +	CLKDEV_DEV_ID("rcar-pcie", &mstp_clks[MSTP116]), /* PCIe */
>  	CLKDEV_DEV_ID("sata_rcar", &mstp_clks[MSTP115]), /* SATA */
>  	CLKDEV_DEV_ID("fc600000.sata", &mstp_clks[MSTP115]), /* SATA w/DT */
>  	CLKDEV_DEV_ID("ehci-platform.1", &mstp_clks[MSTP101]), /* USB EHCI port2 */
> -- 
> 1.7.5.4
> 
