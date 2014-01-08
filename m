From: Simon Horman <horms@verge.net.au>
Date: Wed, 08 Jan 2014 04:22:39 +0000
Subject: Re: [PATCH 2/3] arm: shmobile: r8a7790: Add PCI USB host clock support
Message-Id: <20140108042239.GD15891@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387548804-20829-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387548804-20829-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 20, 2013 at 06:13:23PM +0400, Valentine Barshak wrote:
> This adds internal PCI USB host clock support.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a7790.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> index c5c60ec..3e27200 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> @@ -190,7 +190,7 @@ enum {
>  	MSTP813,
>  	MSTP726, MSTP725, MSTP724, MSTP723, MSTP722, MSTP721, MSTP720,
>  	MSTP717, MSTP716,
> -	MSTP704,
> +	MSTP704, MSTP703,
>  	MSTP522,
>  	MSTP315, MSTP314, MSTP313, MSTP312, MSTP311, MSTP305, MSTP304,
>  	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
> @@ -226,6 +226,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP717] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 17, 0), /* HSCIF0 */
>  	[MSTP716] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 16, 0), /* HSCIF1 */
>  	[MSTP704] = SH_CLK_MSTP32(&mp_clk, SMSTPCR7, 4, 0), /* HSUSB */
> +	[MSTP703] = SH_CLK_MSTP32(&mp_clk, SMSTPCR7, 3, 0), /* EHCI */
>  	[MSTP522] = SH_CLK_MSTP32(&extal_clk, SMSTPCR5, 22, 0), /* Thermal */
>  	[MSTP315] = SH_CLK_MSTP32(&div6_clks[DIV6_MMC0], SMSTPCR3, 15, 0), /* MMC0 */
>  	[MSTP314] = SH_CLK_MSTP32(&div4_clks[DIV4_SD0], SMSTPCR3, 14, 0), /* SDHI0 */
> @@ -317,6 +318,9 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
>  	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
>  	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP704]),
> +	CLKDEV_DEV_ID("pci-rcar-gen2.0", &mstp_clks[MSTP703]),
> +	CLKDEV_DEV_ID("pci-rcar-gen2.1", &mstp_clks[MSTP703]),
> +	CLKDEV_DEV_ID("pci-rcar-gen2.2", &mstp_clks[MSTP703]),
>  
>  	/* ICK */
>  	CLKDEV_ICK_ID("usbhs", "usb_phy_rcar_gen2", &mstp_clks[MSTP704]),

Unfortunately this patch conflicts with "ARM: shmobile: r8a7790: Wait for
status on all MSTP clocks" which I have queued up as a fix for v3.14.

As this patch will be submitted for inclusion on v3.15 it will be in a
branch based on v3.14-rc1 which I expect to include (""ARM: shmobile:
r8a7790: Wait for status on all MSTP clocks").

Could you please rebase it on top of the latest devel tag of the renesas
tree, currently renesas-devel-v3.13-rc7-20140108.
