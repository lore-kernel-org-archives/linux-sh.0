From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 01 Aug 2013 07:40:56 +0000
Subject: Re: [PATCH v6 2/3] ARM: shmobile: lager: enable Ether
Message-Id: <87d2px3lkr.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375175361-23027-1-git-send-email-horms+renesas@verge.net.au>
 <1375175361-23027-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1375175361-23027-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Simon

> @@ -114,6 +138,7 @@ static void __init lager_add_standard_devices(void)
>  	r8a7790_pinmux_init();
>  
>  	r8a7790_add_standard_devices();
> +
>  	platform_device_register_data(&platform_bus, "leds-gpio", -1,
>  				      &lager_leds_pdata,
>  				      sizeof(lager_leds_pdata));
>@@ -125,6 +150,11 @@ static void __init lager_add_standard_devices(void)

I guess above is not needed :)

Except above

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


Best regards
---
Kuninori Morimoto
