From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 24 Dec 2013 20:45:19 +0000
Subject: Re: [PATCH RFC 3/3] [RFC] ARM: shmobile: genmai: Enable r7s72100-gether
Message-Id: <52BA006E.205@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387095886-15163-1-git-send-email-horms+renesas@verge.net.au> <1387095886-15163-4-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1387095886-15163-4-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>

Hello.

On 12/15/2013 11:24 AM, Simon Horman wrote:

> ---
>   arch/arm/mach-shmobile/board-genmai.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

> diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
> index 3e92e3c..838325b 100644
> --- a/arch/arm/mach-shmobile/board-genmai.c
> +++ b/arch/arm/mach-shmobile/board-genmai.c
> @@ -20,15 +20,35 @@
>
>   #include <linux/kernel.h>
>   #include <linux/platform_device.h>
> +#include <linux/sh_eth.h>
>   #include <mach/common.h>
> +#include <mach/irqs.h>
>   #include <mach/r7s72100.h>
>   #include <asm/mach-types.h>
>   #include <asm/mach/arch.h>
>
> +/* GEther */

    Just Ether.

> +static const struct sh_eth_plat_data gether_pdata __initconst = {
> +	.phy			= 0x00, /* PD60610 */
> +	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
> +	.phy_interface		= PHY_INTERFACE_MODE_MII,

    I think .no_ether_link should be set to 1 -- I don't see the LINK signal 
in the manual.

> +};
> +
> +static const struct resource gether_resources[] __initconst = {
> +	DEFINE_RES_MEM(0xe8203000, 0x800),
> +	DEFINE_RES_MEM(0xe8204800, 0x200),
> +	DEFINE_RES_IRQ(gic_iid(359)),
> +};
> +
>   static void __init genmai_add_standard_devices(void)
>   {
>   	r7s72100_clock_init();
>   	r7s72100_add_dt_devices();
> +
> +	platform_device_register_resndata(&platform_bus, "r7s72100-gether", -1,

    We can't call it "-gether" if it lacks 1000 Mbps support. And the manual 
explicitly calls it ETHER.

WBR, Sergei

