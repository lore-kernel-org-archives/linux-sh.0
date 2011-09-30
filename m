From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 30 Sep 2011 11:07:21 +0000
Subject: [PATCH v2 2/4] usb: r8a66597-udc: add function for external controller
Message-Id: <4E85A2E9.6070506@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

R8A66597 has the pin of WR0 and WR1. So, if one write-pin of CPU
connects to the pins, we have to change the setting of FIFOSEL
register in the controller. If we don't change the setting,
the controller cannot send the data of odd length.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v2:
  - divide a patch to only improve function.

 drivers/usb/gadget/r8a66597-udc.h |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.h b/drivers/usb/gadget/r8a66597-udc.h
index c6193fb..37d0dd5 100644
--- a/drivers/usb/gadget/r8a66597-udc.h
+++ b/drivers/usb/gadget/r8a66597-udc.h
@@ -182,6 +182,21 @@ static inline void r8a66597_write(struct r8a66597 *r8a66597, u16 val,
 	iowrite16(val, r8a66597->reg + offset);
 }

+static inline void r8a66597_mdfy(struct r8a66597 *r8a66597,
+				 u16 val, u16 pat, unsigned long offset)
+{
+	u16 tmp;
+	tmp = r8a66597_read(r8a66597, offset);
+	tmp = tmp & (~pat);
+	tmp = tmp | val;
+	r8a66597_write(r8a66597, tmp, offset);
+}
+
+#define r8a66597_bclr(r8a66597, val, offset)	\
+			r8a66597_mdfy(r8a66597, 0, val, offset)
+#define r8a66597_bset(r8a66597, val, offset)	\
+			r8a66597_mdfy(r8a66597, val, 0, offset)
+
 static inline void r8a66597_write_fifo(struct r8a66597 *r8a66597,
 				       struct r8a66597_ep *ep,
 				       unsigned char *buf,
@@ -215,18 +230,12 @@ static inline void r8a66597_write_fifo(struct r8a66597 *r8a66597,
 			adj = 0x01; /* 16-bit wide */
 	}

+	if (r8a66597->pdata->wr0_shorted_to_wr1)
+		r8a66597_bclr(r8a66597, MBW_16, ep->fifosel);
 	for (i = 0; i < len; i++)
 		iowrite8(buf[i], fifoaddr + adj - (i & adj));
-}
-
-static inline void r8a66597_mdfy(struct r8a66597 *r8a66597,
-				 u16 val, u16 pat, unsigned long offset)
-{
-	u16 tmp;
-	tmp = r8a66597_read(r8a66597, offset);
-	tmp = tmp & (~pat);
-	tmp = tmp | val;
-	r8a66597_write(r8a66597, tmp, offset);
+	if (r8a66597->pdata->wr0_shorted_to_wr1)
+		r8a66597_bclr(r8a66597, MBW_16, ep->fifosel);
 }

 static inline u16 get_xtal_from_pdata(struct r8a66597_platdata *pdata)
@@ -251,11 +260,6 @@ static inline u16 get_xtal_from_pdata(struct r8a66597_platdata *pdata)
 	return clock;
 }

-#define r8a66597_bclr(r8a66597, val, offset)	\
-			r8a66597_mdfy(r8a66597, 0, val, offset)
-#define r8a66597_bset(r8a66597, val, offset)	\
-			r8a66597_mdfy(r8a66597, val, 0, offset)
-
 #define get_pipectr_addr(pipenum)	(PIPE1CTR + (pipenum - 1) * 2)

 #define enable_irq_ready(r8a66597, pipenum)	\
-- 
1.7.1
