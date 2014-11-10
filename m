From: Simon Horman <horms@verge.net.au>
Date: Mon, 10 Nov 2014 01:15:29 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: sh73a0: Add restart callback
Message-Id: <20141110011528.GO16836@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415367993-31033-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415367993-31033-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 07, 2014 at 02:46:33PM +0100, Geert Uytterhoeven wrote:
> Port the sh73a0 restart handling from the kzm9g-legacy board code to the
> generic sh73a0 code.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Tested on kzm9g-multiplatform

Thanks, I have queued this up.

> 
>  arch/arm/mach-shmobile/setup-sh73a0.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
> index 179c2b65be9f6829..73b25f999a98ab0a 100644
> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> @@ -786,6 +786,13 @@ void __init sh73a0_add_standard_devices_dt(void)
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>  
> +#define RESCNT2 IOMEM(0xe6188020)
> +static void sh73a0_restart(enum reboot_mode mode, const char *cmd)
> +{
> +	/* Do soft power on reset */
> +	writel((1 << 31), RESCNT2);
> +}
> +
>  static const char *sh73a0_boards_compat_dt[] __initdata = {
>  	"renesas,sh73a0",
>  	NULL,
> @@ -797,6 +804,7 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
>  	.init_early	= shmobile_init_delay,
>  	.init_machine	= sh73a0_add_standard_devices_dt,
>  	.init_late	= shmobile_init_late,
> +	.restart	= sh73a0_restart,
>  	.dt_compat	= sh73a0_boards_compat_dt,
>  MACHINE_END
>  #endif /* CONFIG_USE_OF */
> -- 
> 1.9.1
> 
