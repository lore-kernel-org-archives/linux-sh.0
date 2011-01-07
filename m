From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 07 Jan 2011 02:58:15 +0000
Subject: [PATCH 2/5] sh: Fix IRQ macro in header of landisk
Message-Id: <1294369335-4064-2-git-send-email-iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/sh/include/mach-landisk/mach/iodata_landisk.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/mach-landisk/mach/iodata_landisk.h b/arch/sh/include/mach-landisk/mach/iodata_landisk.h
index 6fb04ab..8b40485 100644
--- a/arch/sh/include/mach-landisk/mach/iodata_landisk.h
+++ b/arch/sh/include/mach-landisk/mach/iodata_landisk.h
@@ -27,7 +27,7 @@
 
 #define IRQ_PCIINTA	5		/* PCI INTA IRQ */
 #define IRQ_PCIINTB	6		/* PCI INTB IRQ */
-#define IRQ_PCIINDC	7		/* PCI INTC IRQ */
+#define IRQ_PCIINTC	7		/* PCI INTC IRQ */
 #define IRQ_PCIINTD	8		/* PCI INTD IRQ */
 #define IRQ_ATA		9		/* ATA IRQ */
 #define IRQ_FATA	10		/* FATA IRQ */
-- 
1.7.2.3

