From: Simon Horman <horms@verge.net.au>
Date: Mon, 23 Jul 2012 01:21:35 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: enable restarting
Message-Id: <20120723012132.GA18360@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1342764990-30715-1-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1342764990-30715-1-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 20, 2012 at 03:16:30PM +0900, Tetsuyuki Kobayshi wrote:
> From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> 
> Do soft-power-on-reset in sys_reboot system call.
> 
> How to test this patch
>   Execute "sudo reboot" from command line. The system will start shutdown
>   sequence and finally reboot and U-Boot restarts.

Hi Kobayashi-san,

I am testing using Iwamatsu-san's uboot which can be found at
http://git.denx.de/?p=u-boot/u-boot-sh.git

I am using the next branch of Rafael's renesas branch,
commit 45c7a01f070146e08f5c838315ffca5ade6e3844 ("Merge branch
'renesas-marzen' into renesas-board").

I am using the default config with the following also enabled.

	CONFIG_ARM_APPENDED_DTB=y
	CONFIG_CMDLINE_FORCE=y

This patch seems to work fine when booting a uImage from uBoot using
bootp;bootm.  But it seems to prevent the board from booting a zImage from
uBoot using bootp;bootz.  I am unsure why.

Note that I am referring to the first boot: a cold start.
Not booting for a second time after issuing the reboot command in Linux.

> Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms@verge.net.au>
> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> ---
> This patch is based on renesas.git next branch.
> 
>  arch/arm/mach-shmobile/board-kzm9g.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
> index 53b7ea9..fd21fb6 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> @@ -763,6 +763,13 @@ static void __init kzm_init(void)
>  	platform_add_devices(kzm_devices, ARRAY_SIZE(kzm_devices));
>  }
>  
> +static void kzm9g_restart(char mode, const char *cmd)
> +{
> +#define RESCNT2 0xe6188020
> +	/* Do soft power on reset */
> +	writel((1 << 31), RESCNT2);
> +}
> +
>  static const char *kzm9g_boards_compat_dt[] __initdata = {
>  	"renesas,kzm9g",
>  	NULL,
> @@ -777,5 +784,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g")
>  	.init_machine	= kzm_init,
>  	.init_late	= shmobile_init_late,
>  	.timer		= &shmobile_timer,
> +	.restart	= kzm9g_restart,
>  	.dt_compat	= kzm9g_boards_compat_dt,
>  MACHINE_END
> -- 
> 1.7.9.5
> 
