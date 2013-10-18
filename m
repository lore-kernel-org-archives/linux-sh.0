From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Oct 2013 00:44:18 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7790: add QSPI support
Message-Id: <87a9i71k81.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> >>>> +void __init r8a7790_add_qspi_device(struct rspi_plat_data *pdata)
> >>>> +{
> >>>> +	platform_device_register_resndata(
> >>>> +		&platform_bus, "qspi", 0,
> >>>> +		qspi_resources, ARRAY_SIZE(qspi_resources),
> >>>> +		pdata, sizeof(*pdata));
> >>>> +}
> >>> Please use -1 ID, and use just "qspi", instead of "qspi.0"
> >> I have tried to use -1 ID instead of 0, and then I saw that QSPI did not
> >> contact to Flash Memory.
> >> I found that in QSPI driver, ID is assigned to bus number:
> >> master->bus_num = pdev->id.
> >> So I wonder how to modify it.
> > According to spi_register_master(), bus_num = -1 seems not problem.
> > Did you exchanged clock name ?
> I saw that in "struct spi_board_info" has defined bus_num is u16
> so I'm afraid if is -1 ID, master->bus_num did not match to bus_num in 
> board_info.

Hmm...
spi master seems use dynamic value
as bus_num if ID was -1 (in spi_register_master())
So, using ID = 0 seems reasonable here

Best regards
---
Kuninori Morimoto
