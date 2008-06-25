From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Wed, 25 Jun 2008 23:02:49 +0000
Subject: Re: [2.6 patch] remove pcibios_update_resource() functions
Message-Id: <200806251602.49856.jbarnes@virtuousgeek.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080617223332.GM25911@cs181133002.pp.htv.fi>
In-Reply-To: <20080617223332.GM25911@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dhowells@redhat.com, gerg@uclinux.org, ralf@linux-mips.org, linux-mips@linux-mips.org, lethal@linux-sh.org, linux-sh@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>

On Tuesday, June 17, 2008 3:33 pm Adrian Bunk wrote:
> Russell King did the following back in 2003:
>
> <--  snip  -->
>
>     [PCI] pci-9: Kill per-architecture pcibios_update_resource()
>
>     Kill pcibios_update_resource(), replacing it with
> pci_update_resource(). pci_update_resource() uses pcibios_resource_to_bus()
> to convert a resource to a device BAR - the transformation should be
> exactly the same as the transformation used for the PCI bridges.

Ralf, I assume you're ok with this?

Thanks,
Jesse

> diff --git a/arch/mips/pmc-sierra/yosemite/ht.c
> b/arch/mips/pmc-sierra/yosemite/ht.c index 6380662..678388f 100644
> --- a/arch/mips/pmc-sierra/yosemite/ht.c
> +++ b/arch/mips/pmc-sierra/yosemite/ht.c
> @@ -345,42 +345,6 @@ int pcibios_enable_device(struct pci_dev *dev, int
> mask) return pcibios_enable_resources(dev);
>  }
>
> -
> -
> -void pcibios_update_resource(struct pci_dev *dev, struct resource *root,
> -                             struct resource *res, int resource)
> -{
> -        u32 new, check;
> -        int reg;
> -
> -        return;
> -
> -        new = res->start | (res->flags & PCI_REGION_FLAG_MASK);
> -        if (resource < 6) {
> -                reg = PCI_BASE_ADDRESS_0 + 4 * resource;
> -        } else if (resource = PCI_ROM_RESOURCE) {
> -		res->flags |= IORESOURCE_ROM_ENABLE;
> -                reg = dev->rom_base_reg;
> -        } else {
> -                /*
> -                 * Somebody might have asked allocation of a non-standard
> -                 * resource
> -                 */
> -                return;
> -        }
> -
> -        pci_write_config_dword(dev, reg, new);
> -        pci_read_config_dword(dev, reg, &check);
> -        if ((new ^ check) &
> -            ((new & PCI_BASE_ADDRESS_SPACE_IO) ? PCI_BASE_ADDRESS_IO_MASK
> : -             PCI_BASE_ADDRESS_MEM_MASK)) {
> -                printk(KERN_ERR "PCI: Error while updating region "
> -                       "%s/%d (%08x != %08x)\n", pci_name(dev), resource,
> -                       new, check);
> -        }
> -}
> -
> -
>  void pcibios_align_resource(void *data, struct resource *res,
>                              resource_size_t size, resource_size_t align)
>  {

