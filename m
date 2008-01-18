From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 18 Jan 2008 09:06:05 +0000
Subject: Re: [PATCH] sh: Add SH Ethernet platform device for Solution Engine
Message-Id: <20080118090605.GA25652@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <479065E5.70109@renesas.com>
In-Reply-To: <479065E5.70109@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 18, 2008 at 05:40:05PM +0900, Yoshihiro Shimoda wrote:
> @@ -115,9 +116,61 @@ static struct platform_device heartbeat_
>  	.resource	= heartbeat_resources,
>  };
> 
> +#if defined(CONFIG_SH_ETH)
> +static struct resource sh_eth0_resources[] = {
> +	[0] = {
> +		.start	= SH_ETH0_BASE,
> +		.end	= SH_ETH0_BASE + 0x1B8,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= IRQ_SH_ETH0,
> +		.end	= IRQ_SH_ETH0,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
Do not use ifdefs for platform devices. If they are unclaimed, they are
freed up due to being __initdata. ifdefs just make the code ugly.

Also, there's no point in merging the board stuff until the driver itself
has been merged. If people are going to keep the ethernet driver out of
tree, then the patch adding it to the board can go along with it.
