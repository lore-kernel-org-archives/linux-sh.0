From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Oct 2013 04:32:51 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7790: add QSPI support
Message-Id: <87mwm81pqo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Hiep-san

> >> +void __init r8a7790_add_qspi_device(struct rspi_plat_data *pdata)
> >> +{
> >> +	platform_device_register_resndata(
> >> +		&platform_bus, "qspi", 0,
> >> +		qspi_resources, ARRAY_SIZE(qspi_resources),
> >> +		pdata, sizeof(*pdata));
> >> +}
> > Please use -1 ID, and use just "qspi", instead of "qspi.0"
> I have tried to use -1 ID instead of 0, and then I saw that QSPI did not 
> contact to Flash Memory.
> I found that in QSPI driver, ID is assigned to bus number: 
> master->bus_num = pdev->id.
> So I wonder how to modify it.

According to spi_register_master(), bus_num = -1 seems not problem.
Did you exchanged clock name ?

Best regards
---
Kuninori Morimoto
