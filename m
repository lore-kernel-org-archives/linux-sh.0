From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 19 Jun 2012 04:18:20 +0000
Subject: Re: [PATCH 4/4] ARM: shmobile: kzm9g: enable MicroSD
Message-Id: <871ulcsznb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877gv4t4xk.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877gv4t4xk.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Kobayashi-san

> genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 802
> mmc0: new high speed SDHC card at address e624
> mmcblk0: mmc0:e624 SU04G 3.69 GiB
>  mmcblk0: p1 p2
> sh_mobile_sdhi: probe of sh_mobile_sdhi.2 failed with error -22
>   ...
> 
> Using debugger I found
>   drivers/mmc/host/sh_mobile_sdhi.c: 168 
> 	ret = tmio_mmc_host_probe(&host, pdev, mmc_data);
> returns -22.

Oops. yes indeed.
Sorry, I didn't explain about this.
It depends on latest mmc ML branch too.
I'm not sure detail of mmc branch status,
but is below patch solve your issue ?

------------------------------------------
diff --git a/drivers/mmc/core/cd-gpio.c b/drivers/mmc/core/cd-gpio.c
index f13e38d..f303cbc 100644
--- a/drivers/mmc/core/cd-gpio.c
+++ b/drivers/mmc/core/cd-gpio.c
@@ -50,7 +50,7 @@ int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio)
 		goto egpioreq;
 
 	ret = request_threaded_irq(irq, NULL, mmc_cd_gpio_irqt,
-				   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				   cd->label, host);
 	if (ret < 0)
 		goto eirqreq;
------------------------------------------


Best regards
---
Kuninori Morimoto
