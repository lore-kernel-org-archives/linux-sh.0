From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 30 Jul 2018 11:55:24 +0000
Subject: Re: [PATCH] PCI: call dma_debug_add_bus for pci_bus_type in common code
Message-Id: <alpine.DEB.2.21.1807301355030.2518@nanos.tec.linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20180730073842.16092-1-hch@lst.de>
In-Reply-To: <20180730073842.16092-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

On Mon, 30 Jul 2018, Christoph Hellwig wrote:

> There is nothing arch specific about PCI or dma-debug, so move this
> call to common code just after registering the bus type.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
