From: Lucas Stach <l.stach@pengutronix.de>
Date: Fri, 09 May 2014 08:28:39 +0000
Subject: Re: [PATCH] of/irq: provide int of_irq_parse_and_map_pci wrapper
Message-Id: <1399624119.4833.3.camel@weser.hi.pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <4527717.yJh2gX3xCP@wuerfel>
In-Reply-To: <4527717.yJh2gX3xCP@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am Freitag, den 09.05.2014, 08:58 +0200 schrieb Arnd Bergmann:
> The pci-rcar driver is enabled for compile tests, and this has
> now shown that the driver cannot build without CONFIG_OF,
> following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
> interrupt mapping when possible":
> 
> drivers/built-in.o: In function `rcar_pci_map_irq':
> :(.text+0x1cc7c): undefined reference to `of_irq_parse_and_map_pci'
> 
> As pointed out by Ben Dooks and Geert Uytterhoeven, this is actually
> supposed to build fine, which we can achieve if we make the
> declaration of of_irq_parse_and_map_pci conditional on CONFIG_OF
> and provide an empty inline function otherwise, as we do for
> a lot of other of interfaces.
> 
> This lets us build the rcar_pci driver again without CONFIG_OF,
> which won't work but give us compile time coverage.
> 
This part of the commit message is confusing. The driver is explicitly
written to fall back to a platform irq when OF interrupt mapping doesn't
work (return 0 or error), to keep non DT enabled boards working.

I hadn't thought of the compile time dependency, so thanks for fixing
this up.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Magnus Damm <damm@opensource.se>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> 
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 1a1f5ff..1e29bf4 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -7,13 +7,18 @@
>  struct pci_dev;
>  struct of_phandle_args;
>  int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq);
> -int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
>  
>  struct device_node;
>  struct device_node *of_pci_find_child_device(struct device_node *parent,
>  					     unsigned int devfn);
>  int of_pci_get_devfn(struct device_node *np);
>  int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
> +#ifdef CONFIG_OF
> +int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
> +#else
> +static inline int
> +of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin) { return 0; }
> +#endif
>  
>  #if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
>  int of_pci_msi_chip_add(struct msi_chip *chip);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

