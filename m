From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 13 Feb 2014 03:04:13 +0000
Subject: [PATCH 07/08] PCI: rcar: Enable BOUNCE in case of HIGHMEM
Message-Id: <20140213030413.10398.20246.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140213030302.10398.37322.sendpatchset@w520>
In-Reply-To: <20140213030302.10398.37322.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pci@vger.kernel.org
Cc: horms@verge.net.au, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, valentine.barshak@cogentembedded.com, ben.dooks@codethink.co.uk, geert@linux-m68k.org, bhelgaas@google.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

Select BOUNCE in case of HIGHMEM to enable bounce buffers in
the block layer. Without this patch the DMABOUNCE code will
error out due to lack of HIGHMEM support, and without DMABOUNCE
there will be silent errors.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/pci/host/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- 0009/drivers/pci/host/Kconfig
+++ work/drivers/pci/host/Kconfig	2014-02-04 16:11:27.000000000 +0900
@@ -30,6 +30,7 @@ config PCI_RCAR_GEN2
 	depends on ARM && (ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST)
 	select GENERIC_ALLOCATOR
 	select DMABOUNCE
+	select BOUNCE if HIGHMEM
 	help
 	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
 	  There are 3 internal PCI controllers available with a single
