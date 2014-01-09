From: Simon Horman <horms@verge.net.au>
Date: Thu, 09 Jan 2014 08:17:52 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: r8a7790: Add PCI USB host clock support
Message-Id: <20140109081752.GD9267@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387548804-20829-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387548804-20829-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 08, 2014 at 08:31:24PM +0400, Valentine Barshak wrote:
> This adds internal PCI USB host clock support.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a7790.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

I am holding off on this patch until reviewed the rest of
the USB patches is complete.

> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> index 31c5ffa..d1b1b8f 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> @@ -200,7 +200,7 @@ enum {
>  	MSTP811, MSTP810, MSTP809, MSTP808,
>  	MSTP726, MSTP725, MSTP724, MSTP723, MSTP722, MSTP721, MSTP720,
>  	MSTP717, MSTP716,
> -	MSTP704,
> +	MSTP704, MSTP703,
>  	MSTP522,
>  	MSTP315, MSTP314, MSTP313, MSTP312, MSTP311, MSTP305, MSTP304,
>  	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
> @@ -240,6 +240,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP717] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR7, 17, MSTPSR7, 0), /* HSCIF0 */
>  	[MSTP716] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR7, 16, MSTPSR7, 0), /* HSCIF1 */
>  	[MSTP704] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR7, 4, MSTPSR7, 0), /* HSUSB */
> +	[MSTP703] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR7, 3, MSTPSR7, 0), /* EHCI */
>  	[MSTP522] = SH_CLK_MSTP32_STS(&extal_clk, SMSTPCR5, 22, MSTPSR5, 0), /* Thermal */
>  	[MSTP315] = SH_CLK_MSTP32_STS(&div6_clks[DIV6_MMC0], SMSTPCR3, 15, MSTPSR3, 0), /* MMC0 */
>  	[MSTP314] = SH_CLK_MSTP32_STS(&div4_clks[DIV4_SD0], SMSTPCR3, 14, MSTPSR3, 0), /* SDHI0 */
> @@ -335,6 +336,9 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
>  	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
>  	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP704]),
> +	CLKDEV_DEV_ID("pci-rcar-gen2.0", &mstp_clks[MSTP703]),
> +	CLKDEV_DEV_ID("pci-rcar-gen2.1", &mstp_clks[MSTP703]),
> +	CLKDEV_DEV_ID("pci-rcar-gen2.2", &mstp_clks[MSTP703]),
>  
>  	/* ICK */
>  	CLKDEV_ICK_ID("usbhs", "usb_phy_rcar_gen2", &mstp_clks[MSTP704]),
> -- 
> 1.8.3.1
> 
