From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 06 Jan 2018 09:24:32 +0000
Subject: Re: [PATCH 2/2] SolutionEngine771x: add Ether TSU resource
Message-Id: <405370a2-d421-be13-c051-ac972d083d95@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180103201137.255228853@cogentembedded.com>
In-Reply-To: <20180103201137.255228853@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc: netdev@vger.kernel.org

Hello!

On 1/3/2018 11:08 PM, Sergei Shtylyov wrote:

> After the  Ether platform data is fixed, the driver probe() method would
> still fail since the 'struct sh_eth_cpu_data' corresponding  to SH771x
> indicates the presence of TSU but the memory resource for it is absent.
> Add the missing TSU resource  to both Ether devices and fix the harmless
> off-by-one error in the main memory resources, while at it...
> 
> Fixes: 4986b996882d ("net: sh_eth: remove the SH_TSU_ADDR")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/sh/boards/mach-se/770x/setup.c |   14 ++++++++++++--
>  arch/sh/include/mach-se/mach/se.h   |    1 +
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> Index: linux/arch/sh/boards/mach-se/770x/setup.c
> =================================> --- linux.orig/arch/sh/boards/mach-se/770x/setup.c
> +++ linux/arch/sh/boards/mach-se/770x/setup.c
> @@ -123,10 +123,15 @@ static struct sh_eth_plat_data sh_eth_pl
>  static struct resource sh_eth0_resources[] = {
>  	[0] = {
>  		.start = SH_ETH0_BASE,
> -		.end = SH_ETH0_BASE + 0x1B8,
> +		.end = SH_ETH0_BASE + 0x1B8 - 1,
>  		.flags = IORESOURCE_MEM,
>  	},
>  	[1] = {
> +		.start = SH_TSU_BASE,
> +		.end = SH_TSU_BASE + 0xA00 - 1,

     Oops, should be 0x200, not 0xA00.

> +		.flags = IORESOURCE_MEM,
> +	},
> +	[2] = {
>  		.start = SH_ETH0_IRQ,
>  		.end = SH_ETH0_IRQ,
>  		.flags = IORESOURCE_IRQ,
> @@ -146,10 +151,15 @@ static struct platform_device sh_eth0_de
>  static struct resource sh_eth1_resources[] = {
>  	[0] = {
>  		.start = SH_ETH1_BASE,
> -		.end = SH_ETH1_BASE + 0x1B8,
> +		.end = SH_ETH1_BASE + 0x1B8 - 1,
>  		.flags = IORESOURCE_MEM,
>  	},
>  	[1] = {
> +		.start = SH_TSU_BASE,
> +		.end = SH_TSU_BASE + 0xA00 - 1,

    Same here. I''ll repost...

> +		.flags = IORESOURCE_MEM,
> +	},
> +	[2] = {
>  		.start = SH_ETH1_IRQ,

MBR, Sergei

