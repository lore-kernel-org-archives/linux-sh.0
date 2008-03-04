From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 04 Mar 2008 09:17:02 +0000
Subject: Re: [PATCH 08/09] sh: pci io port base address code
Message-Id: <20080304091517.GA7577@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 19, 2008 at 09:35:31PM +0900, Magnus Damm wrote:
> --- 0010/include/asm-sh/pci.h
> +++ work/include/asm-sh/pci.h	2008-02-19 20:24:06.000000000 +0900
> @@ -37,33 +37,6 @@ extern struct pci_channel board_pci_chan
>  #define PCIBIOS_MIN_IO		((struct pci_channel *)bus->sysdata)->io_resource->start
>  #define PCIBIOS_MIN_MEM		((struct pci_channel *)bus->sysdata)->mem_resource->start
>  
> -/*
> - * I/O routine helpers
> - */
> -#if defined(CONFIG_CPU_SUBTYPE_SH7780) || defined(CONFIG_CPU_SUBTYPE_SH7785)
> -#define PCI_IO_AREA		0xFE400000
> -#define PCI_IO_SIZE		0x00400000
> -#elif defined(CONFIG_CPU_SH5)
> -extern unsigned long PCI_IO_AREA;
> -#define PCI_IO_SIZE		0x00010000
> -#else
> -#define PCI_IO_AREA		0xFE240000
> -#define PCI_IO_SIZE		0x00040000
> -#endif
> -
> -#define PCI_MEM_SIZE		0x01000000
> -
> -#define SH4_PCIIOBR_MASK	0xFFFC0000
> -#define pci_ioaddr(addr)	(PCI_IO_AREA + (addr & ~SH4_PCIIOBR_MASK))
> -
> -#if defined(CONFIG_PCI)
> -#define is_pci_ioaddr(port)		\
> -	(((port) >= PCIBIOS_MIN_IO) &&	\
> -	 ((port) < (PCIBIOS_MIN_IO + PCI_IO_SIZE)))
> -#else
> -#define is_pci_ioaddr(port)	(0)
> -#endif
> -
>  struct pci_dev;
>  
This bit kills off is_pci_ioaddr(), but none of the actual users. So this
will break all over the place (a quick grep shows systemh, se7751,
snapgear, and titan need some special attention).

R2D/R2D+ used a different approach for the PCI I/O port access, so the
conversion there may not be as straightforward. You may want to look in
to converting a few of those and see if you hit any problems.
