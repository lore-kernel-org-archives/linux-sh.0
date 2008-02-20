From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Feb 2008 09:10:21 +0000
Subject: [PATCH 2.6.25] sh: revert dreamcast pci change
Message-Id: <20080220091021.20631.4358.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Commit e036eaa681a17f71b64f6d9040fe605555623919 broke dreamcast pci, this
patch fixes that by reverting the dreamcast specific bits.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
Acked-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

 arch/sh/drivers/pci/ops-dreamcast.c |   44 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

--- 0001/arch/sh/drivers/pci/ops-dreamcast.c
+++ work/arch/sh/drivers/pci/ops-dreamcast.c	2008-02-20 17:56:48.000000000 +0900
@@ -83,9 +83,9 @@ static int gapspci_read(struct pci_bus *
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	switch (size) {
-		case 1: *val = ctrl_inb(GAPSPCI_BBA_CONFIG+where); break;
-		case 2: *val = ctrl_inw(GAPSPCI_BBA_CONFIG+where); break;
-		case 4: *val = ctrl_inl(GAPSPCI_BBA_CONFIG+where); break;
+		case 1: *val = inb(GAPSPCI_BBA_CONFIG+where); break;
+		case 2: *val = inw(GAPSPCI_BBA_CONFIG+where); break;
+		case 4: *val = inl(GAPSPCI_BBA_CONFIG+where); break;
 	}	
 
         return PCIBIOS_SUCCESSFUL;
@@ -97,9 +97,9 @@ static int gapspci_write(struct pci_bus 
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	switch (size) {
-		case 1: ctrl_outb(( u8)val, GAPSPCI_BBA_CONFIG+where); break;
-		case 2: ctrl_outw((u16)val, GAPSPCI_BBA_CONFIG+where); break;
-		case 4: ctrl_outl((u32)val, GAPSPCI_BBA_CONFIG+where); break;
+		case 1: outb(( u8)val, GAPSPCI_BBA_CONFIG+where); break;
+		case 2: outw((u16)val, GAPSPCI_BBA_CONFIG+where); break;
+		case 4: outl((u32)val, GAPSPCI_BBA_CONFIG+where); break;
 	}
 
         return PCIBIOS_SUCCESSFUL;
@@ -127,36 +127,36 @@ int __init gapspci_init(void)
 	 */
 
 	for (i=0; i<16; i++)
-		idbuf[i] = ctrl_inb(GAPSPCI_REGS+i);
+		idbuf[i] = inb(GAPSPCI_REGS+i);
 
 	if (strncmp(idbuf, "GAPSPCI_BRIDGE_2", 16))
 		return -ENODEV;
 
-	ctrl_outl(0x5a14a501, GAPSPCI_REGS+0x18);
+	outl(0x5a14a501, GAPSPCI_REGS+0x18);
 
 	for (i=0; i<1000000; i++)
 		;
 
-	if (ctrl_inl(GAPSPCI_REGS+0x18) != 1)
+	if (inl(GAPSPCI_REGS+0x18) != 1)
 		return -EINVAL;
 
-	ctrl_outl(0x01000000, GAPSPCI_REGS+0x20);
-	ctrl_outl(0x01000000, GAPSPCI_REGS+0x24);
+	outl(0x01000000, GAPSPCI_REGS+0x20);
+	outl(0x01000000, GAPSPCI_REGS+0x24);
 
-	ctrl_outl(GAPSPCI_DMA_BASE, GAPSPCI_REGS+0x28);
-	ctrl_outl(GAPSPCI_DMA_BASE+GAPSPCI_DMA_SIZE, GAPSPCI_REGS+0x2c);
+	outl(GAPSPCI_DMA_BASE, GAPSPCI_REGS+0x28);
+	outl(GAPSPCI_DMA_BASE+GAPSPCI_DMA_SIZE, GAPSPCI_REGS+0x2c);
 
-	ctrl_outl(1, GAPSPCI_REGS+0x14);
-	ctrl_outl(1, GAPSPCI_REGS+0x34);
+	outl(1, GAPSPCI_REGS+0x14);
+	outl(1, GAPSPCI_REGS+0x34);
 
 	/* Setting Broadband Adapter */
-	ctrl_outw(0xf900, GAPSPCI_BBA_CONFIG+0x06);
-	ctrl_outl(0x00000000, GAPSPCI_BBA_CONFIG+0x30);
-	ctrl_outb(0x00, GAPSPCI_BBA_CONFIG+0x3c);
-	ctrl_outb(0xf0, GAPSPCI_BBA_CONFIG+0x0d);
-	ctrl_outw(0x0006, GAPSPCI_BBA_CONFIG+0x04);
-	ctrl_outl(0x00002001, GAPSPCI_BBA_CONFIG+0x10);
-	ctrl_outl(0x01000000, GAPSPCI_BBA_CONFIG+0x14);
+	outw(0xf900, GAPSPCI_BBA_CONFIG+0x06);
+	outl(0x00000000, GAPSPCI_BBA_CONFIG+0x30);
+	outb(0x00, GAPSPCI_BBA_CONFIG+0x3c);
+	outb(0xf0, GAPSPCI_BBA_CONFIG+0x0d);
+	outw(0x0006, GAPSPCI_BBA_CONFIG+0x04);
+	outl(0x00002001, GAPSPCI_BBA_CONFIG+0x10);
+	outl(0x01000000, GAPSPCI_BBA_CONFIG+0x14);
 
 	return 0;
 }
