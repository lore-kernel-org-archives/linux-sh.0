From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 28 Oct 2008 06:33:48 +0000
Subject: [PATCH] SH 7366 needs SCIF_ONLY
Message-Id: <u63ndp678.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


SH 7366 has compile bug.
because there is no SCIF_ONLY for SH 7366.
this patch add it.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 drivers/serial/sh-sci.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index 7cd28b2..44e952b 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -88,6 +88,7 @@
 # define SCSPTR0		SCPDR0
 # define SCIF_ORER		0x0001  /* overrun error bit */
 # define SCSCR_INIT(port)	0x0038  /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
+# define SCIF_ONLY
 #elif defined(CONFIG_CPU_SUBTYPE_SH7723)
 # define SCSPTR0                0xa4050160
 # define SCSPTR1                0xa405013e
-- 
1.5.4.3

