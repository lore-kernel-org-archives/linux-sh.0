From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Jul 2014 06:03:45 +0000
Subject: Re: [PATCH 1/1] SH7724 clock fixes:  Fix the device name for the CMT  Add a clock called usb0 so tha
Message-Id: <87wqbf40qo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405403748-13622-1-git-send-email-danieruru@gmail.com>
In-Reply-To: <1405403748-13622-1-git-send-email-danieruru@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Daniel again

> @@ -332,6 +332,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_CON_ID("tsif0", &mstp_clks[HWBLK_TSIF]),
>  	CLKDEV_DEV_ID("renesas_usbhs.1", &mstp_clks[HWBLK_USB1]),
>  	CLKDEV_DEV_ID("renesas_usbhs.0", &mstp_clks[HWBLK_USB0]),
> +	CLKDEV_CON_ID("usb0", &mstp_clks[HWBLK_USB0]),
>  	CLKDEV_CON_ID("2dg0", &mstp_clks[HWBLK_2DG]),
>  	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[HWBLK_SDHI0]),
>  	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[HWBLK_SDHI1]),

Can you please care USB1 too ?

