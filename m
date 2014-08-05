From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 05 Aug 2014 09:06:58 +0000
Subject: Re: [PATCH] clk: shmobile: add missing 0x0100 for SDCKCR
Message-Id: <2533034.O1mfuWNL4j@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppgf1kgv.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87ppgf1kgv.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Tuesday 05 August 2014 00:09:26 Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current cpg_sd01_div_table is missing
> "0x0100: x 1/8" division ratio.
> This patch is based on R-Car H2 v0.7, R-Car M2 v0.9.
> 
> Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> >> Simon
> 
> Actually,
> 	linux/arch/arm/mach-shmobile/clock-r8a7790.c : div4_clks
> 	linux/arch/arm/mach-shmobile/clock-r8a7791.c : div4_clks
> have same issue, but I ignored
> 
>  drivers/clk/shmobile/clk-rcar-gen2.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c
> b/drivers/clk/shmobile/clk-rcar-gen2.c index dff7f79..e996425 100644
> --- a/drivers/clk/shmobile/clk-rcar-gen2.c
> +++ b/drivers/clk/shmobile/clk-rcar-gen2.c
> @@ -202,6 +202,7 @@ static const struct clk_div_table cpg_sdh_div_table[] > { };
> 
>  static const struct clk_div_table cpg_sd01_div_table[] = {
> +	{  4,  8 },
>  	{  5, 12 }, {  6, 16 }, {  7, 18 }, {  8, 24 },
>  	{ 10, 36 }, { 11, 48 }, { 12, 10 }, {  0,  0 },
>  };

-- 
Regards,

Laurent Pinchart

