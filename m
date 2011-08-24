From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 24 Aug 2011 20:43:59 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 LCDC1 suspend fix
Message-Id: <201108242243.59656.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20110824093936.8230.53081.sendpatchset@rxone.opensource.se>
In-Reply-To: <20110824093936.8230.53081.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On Wednesday, August 24, 2011, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Associate the HDMI clock together with LCDC1 on sh7372.
> 
> Without this patch Suspend-to-RAM hangs on the boards
> AP4EVB and Mackerel. The code hangs in the LCDC driver
> where the software is waiting forever for the hardware to
> power down. By explicitly associating the HDMI clock with
> LCDC1 we can make sure the HDMI clock is enabled using
> Runtime PM whenever the driver is accessing the hardware.
> 
> This HDMI and LCDC1 dependency is documented in the sh7372
> data sheet. Older kernels did work as expected but the
> recently merged (3.1-rc)
> 
>  794d78f drivers: sh: late disabling of clocks V2
> 
> introduced code to turn off clocks lacking software reference
> which happens to include the HDMI clock that is needed by
> LCDC1 to operate as expected.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Rafael, since this patch is Suspend-to-RAM related, can you
>  please merge this with your other 3.1-rc fixes?

Yes, I'll do that.  Applied to linux-pm/pm-fixes and will be
pushed to Linus later this week.

Thanks,
Rafael


>  arch/arm/mach-shmobile/board-ap4evb.c   |    1 +
>  arch/arm/mach-shmobile/board-mackerel.c |    1 +
>  arch/arm/mach-shmobile/clock-sh7372.c   |    2 ++
>  3 files changed, 4 insertions(+)
> 
> --- 0001/arch/arm/mach-shmobile/board-ap4evb.c
> +++ work/arch/arm/mach-shmobile/board-ap4evb.c	2011-08-24 08:50:18.000000000 +0900
> @@ -1412,6 +1412,7 @@ static void __init ap4evb_init(void)
>  	fsi_init_pm_clock();
>  	sh7372_pm_init();
>  	pm_clk_add(&fsi_device.dev, "spu2");
> +	pm_clk_add(&hdmi_lcdc_device.dev, "hdmi");
>  }
>  
>  static void __init ap4evb_timer_init(void)
> --- 0001/arch/arm/mach-shmobile/board-mackerel.c
> +++ work/arch/arm/mach-shmobile/board-mackerel.c	2011-08-24 08:50:09.000000000 +0900
> @@ -1588,6 +1588,7 @@ static void __init mackerel_init(void)
>  	hdmi_init_pm_clock();
>  	sh7372_pm_init();
>  	pm_clk_add(&fsi_device.dev, "spu2");
> +	pm_clk_add(&hdmi_lcdc_device.dev, "hdmi");
>  }
>  
>  static void __init mackerel_timer_init(void)
> --- 0001/arch/arm/mach-shmobile/clock-sh7372.c
> +++ work/arch/arm/mach-shmobile/clock-sh7372.c	2011-08-24 08:49:58.000000000 +0900
> @@ -655,6 +655,8 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("renesas_usbhs.1", &mstp_clks[MSTP406]), /* USB1 */
>  	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
>  
> +	CLKDEV_ICK_ID("hdmi", "sh_mobile_lcdc_fb.1",
> +		      &div6_reparent_clks[DIV6_HDMI]),
>  	CLKDEV_ICK_ID("ick", "sh-mobile-hdmi", &div6_reparent_clks[DIV6_HDMI]),
>  	CLKDEV_ICK_ID("icka", "sh_fsi2", &div6_reparent_clks[DIV6_FSIA]),
>  	CLKDEV_ICK_ID("ickb", "sh_fsi2", &div6_reparent_clks[DIV6_FSIB]),
> 
> 

