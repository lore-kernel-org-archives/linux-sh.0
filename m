From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Mar 2014 10:42:58 +0000
Subject: [PATCH] sh: pci: Remove duplicate SH4A_PCIEPHYCTLR
Message-Id: <1395916978-14292-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/drivers/pci/pcie-sh7786.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/drivers/pci/pcie-sh7786.h b/arch/sh/drivers/pci/pcie-sh7786.h
index 1ee054e47eae..4a6ff55f759b 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.h
+++ b/arch/sh/drivers/pci/pcie-sh7786.h
@@ -145,9 +145,6 @@
 /*	PCIERMSGIER	*/
 #define	SH4A_PCIERMSGIER	(0x004040)	/* R/W - 0x0000 0000 32 */
 
-/*	PCIEPHYCTLR	*/
-#define SH4A_PCIEPHYCTLR	(0x010000)	/* R/W - 0x0000 0000 32 */
-
 /*	PCIEPHYADRR	*/
 #define	SH4A_PCIEPHYADRR	(0x010004)	/* R/W - 0x0000 0000 32 */
 #define		BITS_ACK	(24)			// Rev1.171
-- 
1.7.9.5

