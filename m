From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Feb 2014 06:53:34 +0000
Subject: [PATCH 04/04] PCI: rcar: Enable BOUNCE in case of HIGHMEM
Message-Id: <20140205065334.29445.56887.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140205065243.29445.76593.sendpatchset@w520>
In-Reply-To: <20140205065243.29445.76593.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, valentine.barshak@cogentembedded.com, horms@verge.net.au, bhelgaas@google.com, Magnus Damm <magnus.damm@gmail.com>, ben.dooks@codethink.co.uk

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
