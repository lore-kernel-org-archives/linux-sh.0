From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 13 Feb 2014 03:03:02 +0000
Subject: [PATCH 00/08] PCI: rcar: Recent driver patches from Ben Dooks and me
Message-Id: <20140213030302.10398.37322.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pci@vger.kernel.org
Cc: horms@verge.net.au, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, valentine.barshak@cogentembedded.com, ben.dooks@codethink.co.uk, geert@linux-m68k.org, bhelgaas@google.com, Magnus Damm <magnus.damm@gmail.com>

PCI: rcar: Recent driver patches from Ben Dooks and me

[PATCH 01/08] PCI: rcar: check platform_get_irq() return code
[PATCH v2 02/08] PCI: rcar: add error interrupt handling
[PATCH 03/08] PCI: rcar: fix bridge logic configuration accesses
[PATCH v2 04/08] PCI: rcar: Register each instance independently
[PATCH v2 05/08] PCI: rcar: Break out window size handling
[PATCH v2 06/08] PCI: rcar: Add DMABOUNCE support
[PATCH 07/08] PCI: rcar: Enable BOUNCE in case of HIGHMEM
[PATCH 08/08] PCI: rcar: Make the Kconfig dependencies more generic

These patches update the pci-rcar-gen2.c driver with patches from
Ben Dooks and me. The first 3 are written by Ben (thanks!) and are
included here to show what I would like to have merged and what I
rebased my patches on. The following 4 are updated versions of

[PATCH 00/04] PCI: rcar: Driver model and physical address space update

The final patch is a new one that fixes up the Kconfig dependencies.

Patch 1-3:
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Patch 4-8:
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.14-rc1-20140207

 drivers/pci/host/Kconfig         |    5 
 drivers/pci/host/pci-rcar-gen2.c |  445 ++++++++++++++++++++++++++++++++------
 2 files changed, 385 insertions(+), 65 deletions(-)
