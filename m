From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 26 Feb 2013 22:41:06 +0000
Subject: Re: [PATCH] gpio: em: Add Device Tree support
Message-Id: <20130226224106.GC20670@core.coreip.homeip.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20130226132623.18365.36583.sendpatchset@w520>
In-Reply-To: <20130226132623.18365.36583.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, horms@verge.net.au, linus.walleij@linaro.org, linux-sh@vger.kernel.org

Hi Magnus,

On Tue, Feb 26, 2013 at 10:26:23PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the Emma Mobile GPIO driver to add DT support.
> 

...

> @@ -366,15 +387,33 @@ static int em_gio_remove(struct platform
>  	return 0;
>  }
>  

#ifdef CONFIG_OF here? No need to have extra aliases in modules if OF
support is not enabled (or is entire ARM arch now enables device tree?).

> +static const struct of_device_id em_gio_dt_ids[] = {
> +	{ .compatible = "renesas,em-gio", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, em_gio_dt_ids);
> +
>  static struct platform_driver em_gio_device_driver = {
>  	.probe		= em_gio_probe,
>  	.remove		= em_gio_remove,
>  	.driver		= {
>  		.name	= "em_gio",
> +		.of_match_table = em_gio_dt_ids,
> +		.owner		= THIS_MODULE,
>  	}
>  };
>  

-- 
Dmitry
