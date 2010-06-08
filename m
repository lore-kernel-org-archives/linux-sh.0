From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 08 Jun 2010 05:53:00 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-sh7367: modify IrDA clock
Message-Id: <20100608055300.GE6376@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p8w6qulxd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p8w6qulxd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 08, 2010 at 02:34:55PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/clock-sh7367.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-sh7367.c b/arch/arm/mach-shmobile/clock-sh7367.c
> index b6454c9..98024eb 100644
> --- a/arch/arm/mach-shmobile/clock-sh7367.c
> +++ b/arch/arm/mach-shmobile/clock-sh7367.c
> @@ -322,7 +322,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[SYMSTP000]), /* SCIFA4 */
>  	CLKDEV_DEV_ID("sh_siu", &mstp_clks[SYMSTP231]), /* SIU */
>  	CLKDEV_CON_ID("cmt1", &mstp_clks[SYMSTP229]), /* CMT10 */
> -	CLKDEV_DEV_ID("sh_irda", &mstp_clks[SYMSTP225]), /* IRDA */
> +	CLKDEV_DEV_ID("sh_irda.0", &mstp_clks[SYMSTP225]), /* IRDA */
>  	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[SYMSTP223]), /* IIC1 */
>  	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[SYMSTP222]), /* USBHS */
>  	CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[SYMSTP222]), /* USBHS */

Can we just fix the sh_irda driver to do clock lookups properly?

If the platform device is registered without an ID then it will simply be
"sh_irda" for the clock string, and with an ID we'll have the .id suffix.
Really we don't even need to do the connection ID lookup, so a simple
clk_get(&pdev->dev, NULL) ought to match this already for you now without
having to change any of this.

If you need to make these sorts of changes in the clock lookup for a
single channel, it's a pretty clear-cut example that the driver has
completely broken clock lookup semantics and needs to be fixed.
