From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Dec 2010 16:15:35 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: mackerel: Add GPS support
Message-Id: <20101220161535.GA30700@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 20, 2010 at 10:06:04AM +0900, Yusuke Goda wrote:
> --- a/arch/arm/mach-shmobile/board-mackerel.c
> +++ b/arch/arm/mach-shmobile/board-mackerel.c
> @@ -807,6 +807,10 @@ static void __init mackerel_init(void)
>  	gpio_request(GPIO_FN_MMCCMD0, NULL);
>  	gpio_request(GPIO_FN_MMCCLK0, NULL);
> 
> +	/* enable GPS module (GT-720F) */
> +	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
> +	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
> +
>  	i2c_register_board_info(0, i2c0_devices,
>  				ARRAY_SIZE(i2c0_devices));
>  	i2c_register_board_info(1, i2c1_devices,

Applied to rmobile/mackerel, thanks.
