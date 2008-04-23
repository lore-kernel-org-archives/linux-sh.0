From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Apr 2008 12:16:06 +0000
Subject: [PATCH] sh: reset hardware from early printk
Message-Id: <20080423121606.7664.54153.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Reset the transmitter and receiver when setting up early printk.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/early_printk.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0008/arch/sh/kernel/early_printk.c
+++ work/arch/sh/kernel/early_printk.c	2008-04-23 21:12:06.000000000 +0900
@@ -167,6 +167,7 @@ static void scif_sercon_init(char *s)
 	} while (!(status & SCxSR_TEND(port)));
 
 	sci_out(port, SCSCR, 0);	 /* TE=0, RE=0 */
+	sci_out(port, SCFCR, SCFCR_RFRST | SCFCR_TFRST);
 	sci_out(port, SCSMR, 0);
 
 	/* Set baud rate */
@@ -174,12 +175,11 @@ static void scif_sercon_init(char *s)
 		(32 * baud) - 1);
 	udelay((1000000+(baud-1)) / baud); /* Wait one bit interval */
 
-	sci_out(port, SCFCR, 12);
-	sci_out(port, SCFCR, 8);
-
 	sci_out(port, SCSPTR, 0);
 	sci_out(port, SCxSR, 0x60);
 	sci_out(port, SCLSR, 0);
+
+	sci_out(port, SCFCR, 0);
 	sci_out(port, SCSCR, 0x30);	 /* TE=1, RE=1 */
 }
 #endif /* defined(CONFIG_CPU_SUBTYPE_SH7720) */
