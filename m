From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 Oct 2013 04:23:50 +0000
Subject: Re: [PATCH 2/3] arm: shmobile: r8a7790: Add USBHS clock support
Message-Id: <20131029042350.GA20432@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 10, 2013 at 02:14:46AM +0400, Valentine Barshak wrote:
> This adds USBHS clock support.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a7790.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> index a64f965..161d44e 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> @@ -186,6 +186,7 @@ enum {
>  	MSTP813,
>  	MSTP726, MSTP725, MSTP724, MSTP723, MSTP722, MSTP721, MSTP720,
>  	MSTP717, MSTP716,
> +	MSTP704,
>  	MSTP522,
>  	MSTP315, MSTP314, MSTP313, MSTP312, MSTP311, MSTP305, MSTP304,
>  	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
> @@ -208,6 +209,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
>  	[MSTP717] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 17, 0), /* HSCIF0 */
>  	[MSTP716] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 16, 0), /* HSCIF1 */
> +	[MSTP704] = SH_CLK_MSTP32(&mp_clk, SMSTPCR7, 4, 0), /* HSUSB */
>  	[MSTP522] = SH_CLK_MSTP32(&extal_clk, SMSTPCR5, 22, 0), /* Thermal */
>  	[MSTP315] = SH_CLK_MSTP32(&div6_clks[DIV6_MMC0], SMSTPCR3, 15, 0), /* MMC0 */
>  	[MSTP314] = SH_CLK_MSTP32(&div4_clks[DIV4_SD0], SMSTPCR3, 14, 0), /* SDHI0 */
> @@ -296,6 +298,8 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
>  	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
>  	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
> +	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP704]),
> +	CLKDEV_ICK_ID("usbhs", "usb_phy_rcar_gen2", &mstp_clks[MSTP704]),
>  };
>  
>  #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\

Thanks, I have queued this up.
It should appear in the next push of the devel branch of the renesas tree.
