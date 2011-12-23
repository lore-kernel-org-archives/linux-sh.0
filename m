From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 23 Dec 2011 11:06:59 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: fix AP4EVB A3SP domain PM
Message-Id: <Pine.LNX.4.64.1112231205170.1911@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1112131208520.17205@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1112131208520.17205@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 13 Dec 2011, Guennadi Liakhovetski wrote:

> On SH7372 it is important to stop MSTP clock of all registered USB host
> devices. Otherwise powering down the A3SP domain will become impossible:
> the domain-specific bit in SPDCR will remain set. Subsequently, any attempt
> to power down any further domains will fail in the same way. To fix this
> problem the USB1 host device has to be added to the A3SP domain on AP4EVB,
> similarly as it is done on mackerel.
> While not that critical, this patch also adds the HDMI device to the A4LC
> domain.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Ok, upon closer inspection it turned out, that this patch is not so 
urgently needed, the reason for my problem was different. Please, drop for 
now.

Thanks
Guennadi

> ---
>  arch/arm/mach-shmobile/board-ap4evb.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
> index 7e90d06..15a210a 100644
> --- a/arch/arm/mach-shmobile/board-ap4evb.c
> +++ b/arch/arm/mach-shmobile/board-ap4evb.c
> @@ -1412,6 +1412,8 @@ static void __init ap4evb_init(void)
>  	sh7372_add_device_to_domain(&sh7372_a3sp, &sh_mmcif_device);
>  	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi0_device);
>  	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi1_device);
> +	sh7372_add_device_to_domain(&sh7372_a3sp, &usb1_host_device);
> +	sh7372_add_device_to_domain(&sh7372_a4lc, &hdmi_device);
>  	sh7372_add_device_to_domain(&sh7372_a4r, &ceu_device);
>  
>  	hdmi_init_pm_clock();
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
