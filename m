From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Sun, 04 Dec 2011 10:48:59 +0000
Subject: Re: [PATCH-RFC 09/10] sh: switch to GENERIC_PCI_IOMAP
Message-Id: <20111204104858.GK15464@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 24, 2011 at 10:20:37PM +0200, Michael S. Tsirkin wrote:
> sh copied pci_iomap from generic code, probably to avoid
> pulling the rest of iomap.c in.  Since that's in
> a separate file now, we can reuse the common implementation.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sorry to nag, any ACKs/NACKs on the sh changes?
I intend to send this to Linus if there are no
objections. Thanks!

> ---
>  arch/sh/Kconfig           |    1 +
>  arch/sh/drivers/pci/pci.c |   23 -----------------------
>  2 files changed, 1 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 5aeab58..ead1640 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -857,6 +857,7 @@ config PCI
>  	bool "PCI support"
>  	depends on SYS_SUPPORTS_PCI
>  	select PCI_DOMAINS
> +	select GENERIC_PCI_IOMAP
>  	help
>  	  Find out whether you have a PCI motherboard. PCI is the name of a
>  	  bus system, i.e. the way the CPU talks to the other stuff inside
> diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
> index c2691af..11aaf2f 100644
> --- a/arch/sh/drivers/pci/pci.c
> +++ b/arch/sh/drivers/pci/pci.c
> @@ -393,29 +393,6 @@ static void __iomem *ioport_map_pci(struct pci_dev *dev,
>  	return (void __iomem *)(chan->io_map_base + port);
>  }
>  
> -void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
> -{
> -	resource_size_t start = pci_resource_start(dev, bar);
> -	resource_size_t len = pci_resource_len(dev, bar);
> -	unsigned long flags = pci_resource_flags(dev, bar);
> -
> -	if (unlikely(!len || !start))
> -		return NULL;
> -	if (maxlen && len > maxlen)
> -		len = maxlen;
> -
> -	if (flags & IORESOURCE_IO)
> -		return ioport_map_pci(dev, start, len);
> -	if (flags & IORESOURCE_MEM) {
> -		if (flags & IORESOURCE_CACHEABLE)
> -			return ioremap(start, len);
> -		return ioremap_nocache(start, len);
> -	}
> -
> -	return NULL;
> -}
> -EXPORT_SYMBOL(pci_iomap);
> -
>  void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
>  {
>  	iounmap(addr);
> -- 
> 1.7.5.53.gc233e
