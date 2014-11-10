From: Simon Horman <horms@verge.net.au>
Date: Mon, 10 Nov 2014 00:52:38 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7740 legacy: Correct IIC0 parent clock
Message-Id: <20141110005237.GC16836@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415181874-21549-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415181874-21549-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 05, 2014 at 11:04:33AM +0100, Geert Uytterhoeven wrote:
> According to the datasheet, the operating clock for IIC0 is the HPP
> (RT Peri) clock, not the SUB (Peri) clock. Both clocks run at the same
> speed (50 Mhz).
> 
> This is consistent with IIC0 being located in the A4R PM domain, and
> IIC1 in the A3SP PM domain.

Thanks, I have queued this up.

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/mach-shmobile/clock-r8a7740.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
> index dbb0ab283e2fe91f..9cac8247c72b6e45 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7740.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
> @@ -470,7 +470,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP127] = SH_CLK_MSTP32(&div4_clks[DIV4_S],	SMSTPCR1, 27, 0), /* CEU20 */
>  	[MSTP125] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR1, 25, 0), /* TMU0 */
>  	[MSTP117] = SH_CLK_MSTP32(&div4_clks[DIV4_B],	SMSTPCR1, 17, 0), /* LCDC1 */
> -	[MSTP116] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR1, 16, 0), /* IIC0 */
> +	[MSTP116] = SH_CLK_MSTP32(&div4_clks[DIV4_HPP],	SMSTPCR1, 16, 0), /* IIC0 */
>  	[MSTP111] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR1, 11, 0), /* TMU1 */
>  	[MSTP100] = SH_CLK_MSTP32(&div4_clks[DIV4_B],	SMSTPCR1,  0, 0), /* LCDC0 */
>  
> -- 
> 1.9.1
> 
