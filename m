From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 24 Oct 2019 15:27:00 +0000
Subject: [PATCH trivial] sh: mach-highlander: Spelling s/Conector/Connector/
Message-Id: <20191024152700.30520-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jiri Kosina <trivial@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Fix misspellings of "Connector".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/include/mach-common/mach/highlander.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/mach-common/mach/highlander.h b/arch/sh/include/mach-common/mach/highlander.h
index 66d3e40fd0464b9c..fb44c299d0337e3f 100644
--- a/arch/sh/include/mach-common/mach/highlander.h
+++ b/arch/sh/include/mach-common/mach/highlander.h
@@ -18,7 +18,7 @@
 #define PA_IRLPRI4      (PA_BCR+0x000a) /* Interrupt Priorty 4 */
 #define PA_RSTCTL       (PA_BCR+0x000c) /* Reset Control */
 #define PA_PCIBD        (PA_BCR+0x000e) /* PCI Board detect control */
-#define PA_PCICD        (PA_BCR+0x0010) /* PCI Conector detect control */
+#define PA_PCICD        (PA_BCR+0x0010) /* PCI Connector detect control */
 #define PA_EXTGIO       (PA_BCR+0x0016) /* Extension GPIO Control */
 #define PA_IVDRMON      (PA_BCR+0x0018) /* iVDR Moniter control */
 #define PA_IVDRCTL      (PA_BCR+0x001a) /* iVDR control */
@@ -80,7 +80,7 @@
 #define	PA_SDPOW	(PA_BCR+0x0004)	/* SD Power control */
 #define	PA_RSTCTL	(PA_BCR+0x0006)	/* Device Reset control */
 #define	PA_PCIBD	(PA_BCR+0x0008)	/* PCI Board detect control */
-#define	PA_PCICD	(PA_BCR+0x000a)	/* PCI Conector detect control */
+#define	PA_PCICD	(PA_BCR+0x000a)	/* PCI Connector detect control */
 #define	PA_ZIGIO1	(PA_BCR+0x000c)	/* Zigbee IO control 1 */
 #define	PA_ZIGIO2	(PA_BCR+0x000e)	/* Zigbee IO control 2 */
 #define	PA_ZIGIO3	(PA_BCR+0x0010)	/* Zigbee IO control 3 */
-- 
2.17.1
