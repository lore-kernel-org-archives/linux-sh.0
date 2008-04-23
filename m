From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Apr 2008 12:31:14 +0000
Subject: [PATCH] sh-sci: sh7722 lacks scsptr registers
Message-Id: <20080423123114.7704.15221.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The sh7722 serial ports all lack SCSPTR registers, so mark them as
nonexistent in the register table.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/serial/sh-sci.h |    4 ++++
 1 file changed, 4 insertions(+)

--- 0010/drivers/serial/sh-sci.h
+++ work/drivers/serial/sh-sci.h	2008-04-23 19:44:12.000000000 +0900
@@ -452,7 +452,11 @@ SCIF_FNS(SCSPTR,			0,  0, 0x24, 16)
 SCIF_FNS(SCLSR,				0,  0, 0x28, 16)
 #else
 SCIF_FNS(SCFDR,                      0x0e, 16, 0x1C, 16)
+#if defined(CONFIG_CPU_SUBTYPE_SH7722)
+SCIF_FNS(SCSPTR,                        0,  0, 0, 0)
+#else
 SCIF_FNS(SCSPTR,                        0,  0, 0x20, 16)
+#endif
 SCIF_FNS(SCLSR,                         0,  0, 0x24, 16)
 #endif
 #endif
