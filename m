From: Simon Horman <horms@verge.net.au>
Date: Thu, 13 Feb 2014 04:39:54 +0000
Subject: Re: [PATCH 00/08] PCI: rcar: Recent driver patches from Ben Dooks and me
Message-Id: <20140213043951.GA22116@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140213030302.10398.37322.sendpatchset@w520>
In-Reply-To: <20140213030302.10398.37322.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, valentine.barshak@cogentembedded.com, ben.dooks@codethink.co.uk, geert@linux-m68k.org

On Thu, Feb 13, 2014 at 12:03:02PM +0900, Magnus Damm wrote:
> PCI: rcar: Recent driver patches from Ben Dooks and me
> 
> [PATCH 01/08] PCI: rcar: check platform_get_irq() return code
> [PATCH v2 02/08] PCI: rcar: add error interrupt handling
> [PATCH 03/08] PCI: rcar: fix bridge logic configuration accesses
> [PATCH v2 04/08] PCI: rcar: Register each instance independently
> [PATCH v2 05/08] PCI: rcar: Break out window size handling
> [PATCH v2 06/08] PCI: rcar: Add DMABOUNCE support
> [PATCH 07/08] PCI: rcar: Enable BOUNCE in case of HIGHMEM
> [PATCH 08/08] PCI: rcar: Make the Kconfig dependencies more generic
> 
> These patches update the pci-rcar-gen2.c driver with patches from
> Ben Dooks and me. The first 3 are written by Ben (thanks!) and are
> included here to show what I would like to have merged and what I
> rebased my patches on. The following 4 are updated versions of
> 
> [PATCH 00/04] PCI: rcar: Driver model and physical address space update
> 
> The final patch is a new one that fixes up the Kconfig dependencies.
> 
> Patch 1-3:
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Patch 4-8:
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas.git tag renesas-devel-v3.14-rc1-20140207
> 
>  drivers/pci/host/Kconfig         |    5 
>  drivers/pci/host/pci-rcar-gen2.c |  445 ++++++++++++++++++++++++++++++++------
>  2 files changed, 385 insertions(+), 65 deletions(-)

Bjorn,

I am happy with these.
Could you consider merging this series?

Acked-by: Simon Horman <horms+renesas@verge.net.au>

