From: Simon Horman <horms@verge.net.au>
Date: Thu, 31 Jan 2013 06:35:20 +0000
Subject: Re: [PATCH 1/3] r8a7779: Add Display Unit clock support
Message-Id: <20130131063520.GB24518@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1359596703-17556-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1359596703-17556-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1359596703-17556-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, magnus.damm@gmail.com, Phil Edworthy <phil.edworthy@renesas.com>

On Thu, Jan 31, 2013 at 02:45:01AM +0100, Laurent Pinchart wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> [Rename device from to rcarfb to rcar-du]
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have applied this to the soc3 branch, merged it into the next
branch. At this point intend to try and have it included in 3.9, though
we are now late in the cycle so that may not happen.

> ---
>  arch/arm/mach-shmobile/clock-r8a7779.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
> index c019609..8cc9bce 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7779.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7779.c
> @@ -87,7 +87,7 @@ static struct clk div4_clks[DIV4_NR] = {
>  };
>  
>  enum { MSTP323, MSTP322, MSTP321, MSTP320,
> -	MSTP101, MSTP100,
> +	MSTP103, MSTP101, MSTP100,
>  	MSTP030,
>  	MSTP029, MSTP028, MSTP027, MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
>  	MSTP016, MSTP015, MSTP014,
> @@ -99,6 +99,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP322] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 22, 0), /* SDHI1 */
>  	[MSTP321] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 21, 0), /* SDHI2 */
>  	[MSTP320] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 20, 0), /* SDHI3 */
> +	[MSTP103] = SH_CLK_MSTP32(&div4_clks[DIV4_S], MSTPCR1,  3, 0), /* DU */
>  	[MSTP101] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1,  1, 0), /* USB2 */
>  	[MSTP100] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1,  0, 0), /* USB0/1 */
>  	[MSTP030] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 30, 0), /* I2C0 */
> @@ -179,6 +180,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
>  	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
>  	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP320]), /* SDHI3 */
> +	CLKDEV_DEV_ID("rcar-du.0", &mstp_clks[MSTP103]), /* DU */
>  };
>  
>  void __init r8a7779_clock_init(void)
> -- 
> 1.7.12.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
