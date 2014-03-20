From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Thu, 20 Mar 2014 17:31:07 +0000
Subject: Re: DMABOUNCE in pci-rcar
Message-Id: <20140320173106.GA19395@obsidianresearch.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201402241200.21944.arnd@arndb.de> <5527822.QYtFYiIpiW@wuerfel>
 <532B137B.7010900@codethink.co.uk> <4884083.IuNl44Y6XD@wuerfel>
 <532B2485.6010005@codethink.co.uk>
In-Reply-To: <532B2485.6010005@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Mar 20, 2014 at 06:25:25PM +0100, Ben Dooks wrote:
> So doing:
> 
> static void pci_rcar_fixup(struct pci_dev *dev)
> {
> 	if (dev->bus->ops = &rcar_pci_ops) {
> 		dev_info(&dev->dev, "applying new dma mask\n");
> 		dev->dma_mask = DMA_BIT_MASK(31);
> 	}
> }
> 
> DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pci_rcar_fixup);
> 
> Did not work for me :(

Seems like it should work, do you have CONFIG_PCI_QUIRKS turned on?

Jason
