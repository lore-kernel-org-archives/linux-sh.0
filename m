From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Fri, 18 Dec 2015 13:43:21 +0000
Subject: RE: [PATCH 4/4] PCI: rcar: Add Gen2 PHY setup to pcie-rcar
Message-Id: <PS1PR06MB1180B9A7108987F56F5A1288F5E10@PS1PR06MB1180.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
 <1450358557-28376-5-git-send-email-phil.edworthy@renesas.com>
 <20151217133308.GB20372@katana>
In-Reply-To: <20151217133308.GB20372@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Wolfram,

On 17 December 2015 13:33, Wolfram Sang wrote:
> > +	rcar_pci_write_reg(pcie, 0x000f0030, GEN2_PCIEPHYADDR);
> > +	rcar_pci_write_reg(pcie, 0x00381203, GEN2_PCIEPHYDATA);
> > +	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
> > +	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
> > +
> > +	rcar_pci_write_reg(pcie, 0x000f0054, GEN2_PCIEPHYADDR);
> > +	/* The following value is for DC connection, no termination resistor */
> > +	rcar_pci_write_reg(pcie, 0x13802007, GEN2_PCIEPHYDATA);
> > +	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
> > +	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
> 
> I'd vote for a comment saying where these magic values come from, i.e.
> which manual, which chapter, etc...
Ok, will do.

Thanks
Phil
