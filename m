From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 10 Feb 2009 09:04:00 +0000
Subject: [PATCH] sh-sci.h: fix typo for SH7785
Message-Id: <ud4dqy7nz.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
I think this is just typo.
But is it intention ?
If so, please ignore this patch...

 drivers/serial/sh-sci.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index 6a7cd49..bb9fe12 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -133,7 +133,7 @@
 # define SCSPTR3	0xffed0024	/* 16 bit SCIF */
 # define SCSPTR4	0xffee0024	/* 16 bit SCIF */
 # define SCSPTR5	0xffef0024	/* 16 bit SCIF */
-# define SCIF_OPER	0x0001		/* Overrun error bit */
+# define SCIF_ORER	0x0001		/* Overrun error bit */
 # define SCSCR_INIT(port)	0x3a	/* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7201) || \
       defined(CONFIG_CPU_SUBTYPE_SH7203) || \
-- 
1.5.6.3

