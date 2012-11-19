From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:23:57 +0000
Subject: [PATCH 288/493] sh: remove use of __devinit
Message-Id: <1353349642-3677-288-git-send-email-wfp5p@virginia.edu>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-sh@vger.kernel.org 
---
 arch/sh/drivers/pci/fixups-dreamcast.c | 2 +-
 arch/sh/drivers/pci/pci.c              | 6 +++---
 arch/sh/drivers/pci/pcie-sh7786.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/drivers/pci/fixups-dreamcast.c b/arch/sh/drivers/pci/fixups-dreamcast.c
index a5fe1b5..d6cde70 100644
--- a/arch/sh/drivers/pci/fixups-dreamcast.c
+++ b/arch/sh/drivers/pci/fixups-dreamcast.c
@@ -28,7 +28,7 @@
 #include <asm/irq.h>
 #include <mach/pci.h>
 
-static void __devinit gapspci_fixup_resources(struct pci_dev *dev)
+static void gapspci_fixup_resources(struct pci_dev *dev)
 {
 	struct pci_channel *p = dev->sysdata;
 
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 81e5daf..102f5d5 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -32,7 +32,7 @@ static struct pci_channel *hose_head, **hose_tail = &hose_head;
 
 static int pci_initialized;
 
-static void __devinit pcibios_scanbus(struct pci_channel *hose)
+static void pcibios_scanbus(struct pci_channel *hose)
 {
 	static int next_busno;
 	static int need_domain_info;
@@ -82,7 +82,7 @@ static void __devinit pcibios_scanbus(struct pci_channel *hose)
 DEFINE_RAW_SPINLOCK(pci_config_lock);
 static DEFINE_MUTEX(pci_scan_mutex);
 
-int __devinit register_pci_controller(struct pci_channel *hose)
+int register_pci_controller(struct pci_channel *hose)
 {
 	int i;
 
@@ -156,7 +156,7 @@ subsys_initcall(pcibios_init);
  *  Called after each bus is probed, but before its children
  *  are examined.
  */
-void __devinit pcibios_fixup_bus(struct pci_bus *bus)
+void pcibios_fixup_bus(struct pci_bus *bus)
 {
 }
 
diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index 9e702f2..c2c85f6 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -132,7 +132,7 @@ static struct clk fixed_pciexclkp = {
 	.rate = 100000000,	/* 100 MHz reference clock */
 };
 
-static void __devinit sh7786_pci_fixup(struct pci_dev *dev)
+static void sh7786_pci_fixup(struct pci_dev *dev)
 {
 	/*
 	 * Prevent enumeration of root complex resources.
-- 
1.8.0

