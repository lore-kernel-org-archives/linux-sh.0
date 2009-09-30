From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Sep 2009 11:57:24 +0000
Subject: [PATCH] usb: r8a66597-udc unaligned fifo fix
Message-Id: <20090930115724.5579.76782.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Rework the r8a66597-udc fifo code to avoid unaligned accesses.

Without this patch unaligned exceptions will degrade the
USB performance. The exceptions come from the fact that
the usb fifo data buffers may be misaligned.

This patch updates the fifo access code to only use
insl()/outsl() and insw()/outsw() in the case of properly
aligned data buffers. The fallback case is that inl()/inw()
are used for misaligned buffer reads together with outb()
that is used for misaligned buffer writes.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Tested on kfr2r09 with CONFIG_USB_CDC_COMPOSITE=y

 drivers/usb/gadget/r8a66597-udc.h |  105 +++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 43 deletions(-)

--- 0001/drivers/usb/gadget/r8a66597-udc.h
+++ work/drivers/usb/gadget/r8a66597-udc.h	2009-09-30 17:00:36.000000000 +0900
@@ -131,31 +131,48 @@ static inline u16 r8a66597_read(struct r
 }
 
 static inline void r8a66597_read_fifo(struct r8a66597 *r8a66597,
-				      unsigned long offset, u16 *buf,
+				      unsigned long offset,
+				      unsigned char *buf,
 				      int len)
 {
+	unsigned long fifoaddr = r8a66597->reg + offset;
+	unsigned int data;
+	int i;
+
 	if (r8a66597->pdata->on_chip) {
-		unsigned long fifoaddr = r8a66597->reg + offset;
-		unsigned long count;
-		union {
-			unsigned long dword;
-			unsigned char byte[4];
-		} data;
-		unsigned char *pb;
-		int i;
-
-		count = len / 4;
-		insl(fifoaddr, buf, count);
-
-		if (len & 0x00000003) {
-			data.dword = inl(fifoaddr);
-			pb = (unsigned char *)buf + count * 4;
-			for (i = 0; i < (len & 0x00000003); i++)
-				pb[i] = data.byte[i];
+		/* 32-bit accesses for on_chip controllers */
+
+		/* aligned buf case */
+		if (len >= 4 && !((unsigned long)buf & 0x03)) {
+			insl(fifoaddr, buf, len / 4);
+			buf += len & ~0x03;
+			len &= 0x03;
+		}
+
+		/* unaligned buf case */
+		for (i = 0; i < len; i++) {
+			if (!(i & 0x03))
+				data = inl(fifoaddr);
+
+			buf[i] = (data >> ((i & 0x03) * 8)) & 0xff;
 		}
 	} else {
-		len = (len + 1) / 2;
-		insw(r8a66597->reg + offset, buf, len);
+		/* 16-bit accesses for external controllers */
+
+		/* aligned buf case */
+		if (len >= 2 && !((unsigned long)buf & 0x01)) {
+			insw(fifoaddr, buf, len / 2);
+			buf += len & ~0x01;
+			len &= 0x01;
+		}
+
+		/* unaligned buf case */
+		for (i = 0; i < len; i++) {
+			if (!(i & 0x01))
+				data = inw(fifoaddr);
+
+			buf[i] = (data >> ((i & 0x01) * 8)) & 0xff;
+		}
 	}
 }
 
@@ -166,38 +183,40 @@ static inline void r8a66597_write(struct
 }
 
 static inline void r8a66597_write_fifo(struct r8a66597 *r8a66597,
-				       unsigned long offset, u16 *buf,
+				       unsigned long offset,
+				       unsigned char *buf,
 				       int len)
 {
 	unsigned long fifoaddr = r8a66597->reg + offset;
+	int adj = 0;
+	int i;
 
 	if (r8a66597->pdata->on_chip) {
-		unsigned long count;
-		unsigned char *pb;
-		int i;
-
-		count = len / 4;
-		outsl(fifoaddr, buf, count);
-
-		if (len & 0x00000003) {
-			pb = (unsigned char *)buf + count * 4;
-			for (i = 0; i < (len & 0x00000003); i++) {
-				if (r8a66597_read(r8a66597, CFIFOSEL) & BIGEND)
-					outb(pb[i], fifoaddr + i);
-				else
-					outb(pb[i], fifoaddr + 3 - i);
-			}
+		/* 32-bit access only if buf is 32-bit aligned */
+		if (len >= 4 && !((unsigned long)buf & 0x03)) {
+			outsl(fifoaddr, buf, len / 4);
+			buf += len & ~0x03;
+			len &= 0x03;
 		}
 	} else {
-		int odd = len & 0x0001;
-
-		len = len / 2;
-		outsw(fifoaddr, buf, len);
-		if (unlikely(odd)) {
-			buf = &buf[len];
-			outb((unsigned char)*buf, fifoaddr);
+		/* 16-bit access only if buf is 16-bit aligned */
+		if (len >= 2 && !((unsigned long)buf & 0x01)) {
+			outsw(fifoaddr, buf, len / 2);
+			buf += len & ~0x01;
+			len &= 0x01;
 		}
 	}
+
+	/* adjust fifo address in the little endian case */
+	if (!(r8a66597_read(r8a66597, CFIFOSEL) & BIGEND)) {
+		if (r8a66597->pdata->on_chip)
+			adj = 0x03; /* 32-bit wide */
+		else
+			adj = 0x01; /* 16-bit wide */
+	}
+
+	for (i = 0; i < len; i++)
+		outb(buf[i], fifoaddr + adj - (i & adj));
 }
 
 static inline void r8a66597_mdfy(struct r8a66597 *r8a66597,
