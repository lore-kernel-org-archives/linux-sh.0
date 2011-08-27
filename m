From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 27 Aug 2011 12:27:26 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 LCDC1 suspend fix V2 (incremental)
Message-Id: <201108271427.26409.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20110824093936.8230.53081.sendpatchset@rxone.opensource.se>
In-Reply-To: <20110824093936.8230.53081.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Saturday, August 27, 2011, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch updates the recently submitted
> "Associate the HDMI clock together with LCDC1 on sh7372"
> to V2 with the following change:
>  - Use lcdc1_device on AP4EVB to build properly.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied to linux-pm/pm-fixes, thanks!

Rafael


> ---
> 
>  arch/arm/mach-shmobile/board-ap4evb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 0007/arch/arm/mach-shmobile/board-ap4evb.c
> +++ work/arch/arm/mach-shmobile/board-ap4evb.c	2011-08-27 20:58:15.000000000 +0900
> @@ -1412,7 +1412,7 @@ static void __init ap4evb_init(void)
>  	fsi_init_pm_clock();
>  	sh7372_pm_init();
>  	pm_clk_add(&fsi_device.dev, "spu2");
> -	pm_clk_add(&hdmi_lcdc_device.dev, "hdmi");
> +	pm_clk_add(&lcdc1_device.dev, "hdmi");
>  }
>  
>  static void __init ap4evb_timer_init(void)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

