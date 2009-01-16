From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 16 Jan 2009 05:51:02 +0000
Subject: [PATCH] sh: fix sh-sci / early printk build on sh7723
Message-Id: <20090116055102.10290.84974.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds the SCSPTR register to the sh-sci driver in
the case of sh7723 to make sure early printk builds properly.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/serial/sh-sci.h |    1 +
 1 file changed, 1 insertion(+)

--- 0001/drivers/serial/sh-sci.h
+++ work/drivers/serial/sh-sci.h	2009-01-15 19:44:05.000000000 +0900
@@ -395,6 +395,7 @@ SCIx_FNS(SCSCR,  0x08, 16, 0x08, 16)
 SCIx_FNS(SCxTDR, 0x20,  8, 0x0c,  8)
 SCIx_FNS(SCxSR,  0x14, 16, 0x10, 16)
 SCIx_FNS(SCxRDR, 0x24,  8, 0x14,  8)
+SCIx_FNS(SCSPTR, 0,     0,    0,  0)
 SCIF_FNS(SCTDSR, 0x0c,  8)
 SCIF_FNS(SCFER,  0x10, 16)
 SCIF_FNS(SCFCR,  0x18, 16)
