From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 28 Feb 2014 19:24:39 +0000
Subject: Re: [PATCH v2 34/40] ARM: shmobile: sh73a0: Switch to new style CMT device
Message-Id: <5310F080.20901@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393603090-23144-35-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1393603090-23144-35-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 02/28/2014 06:58 PM, Laurent Pinchart wrote:

> The CMT (Compare Match Timer) driver implements a new style of platform
> data that handles the timer as a single device with multiple channel.
> Switch from the old-style platform data to the new-style platform data.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[...]

> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
> index f74ab53..61b15d9 100644
> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> @@ -104,35 +104,23 @@ SH73A0_SCIF(PORT_SCIFA, 6, 0xe6cc0000, gic_spi(156));
>   SH73A0_SCIF(PORT_SCIFA, 7, 0xe6cd0000, gic_spi(143));
>   SH73A0_SCIF(PORT_SCIFB, 8, 0xe6c30000, gic_spi(80));
>
> -static struct sh_timer_config cmt10_platform_data = {
> -	.name = "CMT10",
> -	.channel_offset = 0x10,
> -	.timer_bit = 0,
> -	.clockevent_rating = 80,
> -	.clocksource_rating = 125,
> +static struct sh_timer_config cmt1_platform_data = {
> +	.channels_mask = 0x3f,
>   };
>
> -static struct resource cmt10_resources[] = {
> -	[0] = {
> -		.name	= "CMT10",
> -		.start	= 0xe6138010,
> -		.end	= 0xe613801b,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= gic_spi(65),
> -		.flags	= IORESOURCE_IRQ,
> -	},
> +static struct resource cmt1_resources[] = {
> +	DEFINE_RES_MEM(0xe6138010, 0x200),

    Not 0xe6138000 by chance? Otherwise address and size look a bit strange...

> +	DEFINE_RES_IRQ(gic_spi(65)),
>   };

WBR, Sergei

