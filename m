From: Simon Horman <horms@verge.net.au>
Date: Thu, 21 Nov 2013 04:12:42 +0000
Subject: Re: [PATCH 05/05] ARM: shmobile: Add r8a7791 clocks for thermal devices
Message-Id: <20131121041240.GN31130@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131120075921.23557.23231.sendpatchset@w520>
 <20131120080005.23557.61686.sendpatchset@w520>
In-Reply-To: <20131120080005.23557.61686.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Nov 20, 2013 at 05:00:05PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add the r8a7791 thermal device as legacy clocks.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue this up.
Assuming all goes will I plan to push this and other updates
today or tomorrow.

> ---
> 
>  arch/arm/mach-shmobile/clock-r8a7791.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- 0001/arch/arm/mach-shmobile/clock-r8a7791.c
> +++ work/arch/arm/mach-shmobile/clock-r8a7791.c	2013-11-20 15:52:07.000000000 +0900
> @@ -124,6 +124,7 @@ static struct clk *main_clks[] = {
>  enum {
>  	MSTP726, MSTP724, MSTP723, MSTP721, MSTP720,
>  	MSTP719, MSTP718, MSTP715, MSTP714,
> +	MSTP522,
>  	MSTP216, MSTP207, MSTP206,
>  	MSTP204, MSTP203, MSTP202, MSTP1105, MSTP1106, MSTP1107,
>  	MSTP124,
> @@ -140,6 +141,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP718] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 18, 0), /* SCIF3 */
>  	[MSTP715] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 15, 0), /* SCIF4 */
>  	[MSTP714] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 14, 0), /* SCIF5 */
> +	[MSTP522] = SH_CLK_MSTP32(&extal_clk, SMSTPCR5, 22, 0), /* Thermal */
>  	[MSTP216] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 16, 0), /* SCIFB2 */
>  	[MSTP207] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 7, 0), /* SCIFB1 */
>  	[MSTP206] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 6, 0), /* SCIFB0 */
> @@ -188,6 +190,8 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh-sci.13", &mstp_clks[MSTP1106]), /* SCIFA4 */
>  	CLKDEV_DEV_ID("sh-sci.14", &mstp_clks[MSTP1107]), /* SCIFA5 */
>  	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
> +	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
> +	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
>  };
>  
>  #define R8A7791_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
> 
