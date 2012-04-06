From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 06 Apr 2012 05:21:47 +0000
Subject: Re: [PATCH 5/6] ARM: mach-shmobile: armadillo800eva: add support gpio_key
Message-Id: <87y5q9juzc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87iphe4lx7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87iphe4lx7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

Thank you for checking patch.

> I am seeing the following, is it expected?
> 
> gpio-keys gpio-keys: Unable to get irq number for GPIO 99, error -38
> gpio-keys: probe of gpio-keys failed with error -38

Sorry for confusion.
Yes. gpio-keys support needs +1 patch.

I expected it on [0/6] mail :)

------------------------------------------
#5 patch require R8A7740 .gipo_irq support patch which I posted this morning.
[PATCH] ARM: mach-shmobile: pfc-r8a7740: add .gpio_irq support
------------------------------------------

Best regards
---
Kuninori Morimoto
