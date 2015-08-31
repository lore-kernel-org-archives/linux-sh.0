From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 31 Aug 2015 23:52:58 +0000
Subject: Re: [PATCH][resent] PCI: rcar: Add PCIE_CONF_REGNO macro for PCIECAR register
Message-Id: <87d1y3ggsx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <HKNPR06MB049BFAE520321568794CA8FC5600@HKNPR06MB049.apcprd06.prod.outlook.com>
	<874mjlefty.wl%kuninori.morimoto.gx@renesas.com>
	<8737z5efjt.wl%kuninori.morimoto.gx@renesas.com>
	<20150831062200.GB27319@verge.net.au>
In-Reply-To: <20150831062200.GB27319@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, HARUNOBU KUROKAWA <harunobu.kurokawa.dn@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>, TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>


Hi Simon

Thank you for your feedback

> > From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > 
> > The reg variable used when setting PCIECAR register need to be masked by 0xFC
> > by restriction of the corresponding register.
> > This adds PCIE_CONF_REGNO are macros for masking changes that PCIE_CONF_REGNO
> > is used when setting PCIECAR register.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > ---
(snip)
> This seems to partially duplicate the following line earlier on
> in rcar_pcie_config_access().
> 
> 	reg = where & ~3;
> 
> I wonder if that line could be updated to use the new PCIE_CONF_REGNO()
> macro. If so it seems that the second hunk of the patch could be dropped.

We double checked this, and yes, you are correct.
We don't need this patch. Thank you for pointing it.
