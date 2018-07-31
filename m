From: Joerg Roedel <jroedel@suse.de>
Date: Tue, 31 Jul 2018 07:36:02 +0000
Subject: Re: [PATCH] PCI: call dma_debug_add_bus for pci_bus_type in common code
Message-Id: <20180731073602.jbbcr4twd2gnkfoc@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20180730073842.16092-1-hch@lst.de>
 <20180730211713.GA45322@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180730211713.GA45322@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 04:17:13PM -0500, Bjorn Helgaas wrote:
> [+cc Joerg]
> 
> On Mon, Jul 30, 2018 at 09:38:42AM +0200, Christoph Hellwig wrote:
> > There is nothing arch specific about PCI or dma-debug, so move this
> > call to common code just after registering the bus type.
> 
> I assume that previously, even if the user set CONFIG_DMA_API_DEBUG=y
> we only got PCI DMA debug on powerpc, sh, and x86.  And after this
> patch, we'll get PCI DMA debug on *all* arches?
> 
> If that's true, I'll add a comment to that effect to the commitlog
> since that new functionality might be of interest to other arches.

There should be implicit support for dma-debug for all arches that use
the generic dma_ops code. The dma_debug_add_bus() function just adds the
reporting of pending dma-allocations on driver-unload for a device. 

Regards,

	Joerg

