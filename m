From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Mar 2010 13:52:35 +0000
Subject: [PATCH] SH: fix SCIFA SCASCR register bit definitions
Message-Id: <Pine.LNX.4.64.1003191451290.5412@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/serial/sh-sci.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index 988dc87..5ac23c0 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -96,7 +96,9 @@
 # define SCSCR_INIT(port)       0x0038  /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7724)
 # define SCIF_ORER              0x0001  /* overrun error bit */
-# define SCSCR_INIT(port)       0x0038  /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
+# define SCSCR_INIT(port) ((port)->type = PORT_SCIFA ? \
+	0x30 /* TIE=0,RIE=0,TE=1,RE=1 */ : \
+	0x38 /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */ )
 #elif defined(CONFIG_CPU_SUBTYPE_SH4_202)
 # define SCSPTR2 0xffe80020 /* 16 bit SCIF */
 # define SCIF_ORER 0x0001   /* overrun error bit */
@@ -199,6 +201,8 @@
     defined(CONFIG_CPU_SUBTYPE_SH7786)  || \
     defined(CONFIG_CPU_SUBTYPE_SHX3)
 #define SCI_CTRL_FLAGS_REIE 0x08 /* 7750 SCIF */
+#elif defined(CONFIG_CPU_SUBTYPE_SH7724)
+#define SCI_CTRL_FLAGS_REIE ((port)->type = PORT_SCIFA ? 0 : 8)
 #else
 #define SCI_CTRL_FLAGS_REIE 0
 #endif
-- 
1.6.2.4

