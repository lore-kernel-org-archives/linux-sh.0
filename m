From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 14 Jan 2011 10:57:08 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ag5evm: Add IrDA support
Message-Id: <w3pk4i7oirf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pk4jw518f.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pk4jw518f.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> +	/* IrDA */
> +	gpio_request(GPIO_FN_PORT241_IRDA_OUT, NULL);
> +	gpio_request(GPIO_FN_PORT242_IRDA_IN,  NULL);
> +	gpio_request(GPIO_FN_PORT243_IRDA_FIRSEL, NULL);
> +	set_irq_type(IRQ_IRDA, IRQ_TYPE_LEVEL_LOW);

This set_irq_type is not needed for now.
I will send v2 patch soon.
Thank you Magnus for your advice.

Best regards
--
Kuninori Morimoto
 
