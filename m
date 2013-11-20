From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 20 Nov 2013 21:18:47 +0000
Subject: Re: [PATCH 7/9] ARM: shmobile: r8a7790: add internal PCI clock
Message-Id: <528D2737.7020001@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384969086-8920-8-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1384969086-8920-8-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11/20/2013 09:38 PM, Ulrich Hecht wrote:
> Adds clock for internal PCI host controllers.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> ---
>   arch/arm/mach-shmobile/clock-r8a7790.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> index 6107571..5a84698 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> @@ -187,7 +187,7 @@ enum {
>   	MSTP813,
>   	MSTP726, MSTP725, MSTP724, MSTP723, MSTP722, MSTP721, MSTP720,
>   	MSTP717, MSTP716,
> -	MSTP704,
> +	MSTP704, MSTP703,
>   	MSTP522,
>   	MSTP315, MSTP314, MSTP313, MSTP312, MSTP311, MSTP305, MSTP304,
>   	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
> @@ -212,6 +212,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>   	[MSTP717] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 17, 0), /* HSCIF0 */
>   	[MSTP716] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 16, 0), /* HSCIF1 */
>   	[MSTP704] = SH_CLK_MSTP32(&mp_clk, SMSTPCR7, 4, 0), /* HSUSB */
> +	[MSTP703] = SH_CLK_MSTP32(&mp_clk, SMSTPCR7, 3, 0), /* EHCI */

The comment to the above line is a bit misleading.

>   	[MSTP522] = SH_CLK_MSTP32(&extal_clk, SMSTPCR5, 22, 0), /* Thermal */
>   	[MSTP315] = SH_CLK_MSTP32(&div6_clks[DIV6_MMC0], SMSTPCR3, 15, 0), /* MMC0 */
>   	[MSTP314] = SH_CLK_MSTP32(&div4_clks[DIV4_SD0], SMSTPCR3, 14, 0), /* SDHI0 */
> @@ -303,6 +304,8 @@ static struct clk_lookup lookups[] = {
>   	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
>   	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP704]),
>   	CLKDEV_ICK_ID("usbhs", "usb_phy_rcar_gen2", &mstp_clks[MSTP704]),
> +	CLKDEV_ICK_ID("usbpci", "pci-rcar-gen2.1", &mstp_clks[MSTP703]),
> +	CLKDEV_ICK_ID("usbpci", "pci-rcar-gen2.2", &mstp_clks[MSTP703]),

The CLKDEV_DEV_ID should be used instead for both pci clocks.

>   };
>
>   #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
>

Thanks,
Val.
