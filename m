From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Feb 2008 05:05:57 +0000
Subject: [PATCH] sh: fix pci io access for r2d boards
Message-Id: <20080214050557.6873.78234.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080214050411.6870.20292.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080214050411.6870.20292.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use generic_io_base to point out the pci io window, and make sure the
highest port address used is SH7751_PCI_IO_SIZE - 1.

This patch fixes pci io port access for the r2d boards - CONFIG_8139TOO_PIO
now works as expected. So does the alsa driver for CMI8738.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
Acked-by: Katsuya MATSUBARA <matsu@igel.co.jp>
---

 (This is the correct patch, sorry about that)

 arch/sh/drivers/pci/ops-rts7751r2d.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 0001/arch/sh/drivers/pci/ops-rts7751r2d.c
+++ work/arch/sh/drivers/pci/ops-rts7751r2d.c	2008-02-14 13:00:01.000000000 +0900
@@ -33,7 +33,7 @@ int __init pcibios_map_platform_irq(stru
 static struct resource sh7751_io_resource = {
 	.name	= "SH7751_IO",
 	.start	= 0x4000,
-	.end	= 0x4000 + SH7751_PCI_IO_SIZE - 1,
+	.end	= SH7751_PCI_IO_SIZE - 1,
 	.flags	= IORESOURCE_IO
 };
 
@@ -68,6 +68,7 @@ static struct sh4_pci_address_map sh7751
 
 int __init pcibios_init_platform(void)
 {
+	__set_io_port_base(SH7751_PCI_IO_BASE);
 	return sh7751_pcic_init(&sh7751_pci_map);
 }
 
