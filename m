From: Ralf Baechle <ralf@linux-mips.org>
Date: Fri, 13 May 2011 12:17:46 +0000
Subject: [PATCH] SH: SE7751: Fix pcibios_map_platform_irq prototype.
Message-Id: <20110513121746.GA21764@linux-mips.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/sh/drivers/pci/fixups-se7751.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/drivers/pci/fixups-se7751.c b/arch/sh/drivers/pci/fixups-se7751.c
index a4c7d3a..fd3e6b0 100644
--- a/arch/sh/drivers/pci/fixups-se7751.c
+++ b/arch/sh/drivers/pci/fixups-se7751.c
@@ -6,7 +6,7 @@
 #include <linux/io.h>
 #include "pci-sh4.h"
 
-int __init pcibios_map_platform_irq(u8 slot, u8 pin)
+int __init pcibios_map_platform_irq(struct pci_dev *, u8 slot, u8 pin)
 {
         switch (slot) {
         case 0: return 13;
