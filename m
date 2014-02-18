From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 Feb 2014 02:12:01 +0000
Subject: [PATCH 08/08] PCI: rcar: Make the Kconfig dependencies more generic
Message-Id: <20140218021201.14164.83953.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140218021041.14164.56411.sendpatchset@w520>
In-Reply-To: <20140218021041.14164.56411.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pci@vger.kernel.org
Cc: horms@verge.net.au, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, valentine.barshak@cogentembedded.com, ben.dooks@codethink.co.uk, geert@linux-m68k.org, bhelgaas@google.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

Update the R-Car Generation 2 PCI driver Kconfig dependencies
to follow same style as other drivers - no SoC dependencies.

Also, update the COMPILE_TEST bits to depend on ARM. This since
the DMA bounce buffer and dma_ops handling code is ARM specific.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/pci/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0010/drivers/pci/host/Kconfig
+++ work/drivers/pci/host/Kconfig	2014-02-13 11:19:19.000000000 +0900
@@ -27,7 +27,7 @@ config PCI_TEGRA
 
 config PCI_RCAR_GEN2
 	bool "Renesas R-Car Gen2 Internal PCI controller"
-	depends on ARM && (ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST)
+	depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
 	select GENERIC_ALLOCATOR
 	select DMABOUNCE
 	select BOUNCE if HIGHMEM
