From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Wed, 18 Jun 2008 09:32:14 +0000
Subject: [PATCH] sh: Remove sh_pcic_io_xxx function from Solution Engine IO code
Message-Id: <4858D61E.6050204@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_pcic_io_xxx function are very old.
In linux-2.4, mrshpc_ss socket driver used this function.
But there is not this driver to the present kernel.
I deleted these cords and checked operation.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/boards/se/770x/io.c |   44 ++++++++----------------------------------
 1 files changed, 9 insertions(+), 35 deletions(-)

diff --git a/arch/sh/boards/se/770x/io.c b/arch/sh/boards/se/770x/io.c
index c455047..388a0dc 100644
--- a/arch/sh/boards/se/770x/io.c
+++ b/arch/sh/boards/se/770x/io.c
@@ -13,13 +13,6 @@
 #include <asm/io.h>
 #include <asm/se.h>

-/* SH pcmcia io window base, start and end.  */
-int sh_pcic_io_wbase = 0xb8400000;
-int sh_pcic_io_start;
-int sh_pcic_io_stop;
-int sh_pcic_io_type;
-int sh_pcic_io_dummy;
-
 /* MS7750 requires special versions of in*, out* routines, since
    PC-like io ports are located at upper half byte of 16-bit word which
    can be accessed only with 16-bit wide.  */
@@ -33,8 +26,6 @@ port2adr(unsigned int port)
 		return (volatile __u16 *) (PA_MRSHPC + (port - 0x2000));
 	else if (port >= 0x1000)
 		return (volatile __u16 *) (PA_83902 + (port << 1));
-	else if (sh_pcic_io_start <= port && port <= sh_pcic_io_stop)
-		return (volatile __u16 *) (sh_pcic_io_wbase + (port &~ 1));
 	else
 		return (volatile __u16 *) (PA_SUPERIO + (port << 1));
 }
@@ -51,9 +42,7 @@ shifted_port(unsigned long port)

 unsigned char se_inb(unsigned long port)
 {
-	if (sh_pcic_io_start <= port && port <= sh_pcic_io_stop)
-		return *(__u8 *) (sh_pcic_io_wbase + 0x40000 + port);
-	else if (shifted_port(port))
+	if (shifted_port(port))
 		return (*port2adr(port) >> 8);
 	else
 		return (*port2adr(port))&0xff;
@@ -63,9 +52,7 @@ unsigned char se_inb_p(unsigned long port)
 {
 	unsigned long v;

-	if (sh_pcic_io_start <= port && port <= sh_pcic_io_stop)
-		v = *(__u8 *) (sh_pcic_io_wbase + 0x40000 + port);
-	else if (shifted_port(port))
+	if (shifted_port(port))
 		v = (*port2adr(port) >> 8);
 	else
 		v = (*port2adr(port))&0xff;
@@ -75,8 +62,7 @@ unsigned char se_inb_p(unsigned long port)

 unsigned short se_inw(unsigned long port)
 {
-	if (port >= 0x2000 ||
-	    (sh_pcic_io_start <= port && port <= sh_pcic_io_stop))
+	if (port >= 0x2000)
 		return *port2adr(port);
 	else
 		maybebadio(port);
@@ -91,9 +77,7 @@ unsigned int se_inl(unsigned long port)

 void se_outb(unsigned char value, unsigned long port)
 {
-	if (sh_pcic_io_start <= port && port <= sh_pcic_io_stop)
-		*(__u8 *)(sh_pcic_io_wbase + port) = value;
-	else if (shifted_port(port))
+	if (shifted_port(port))
 		*(port2adr(port)) = value << 8;
 	else
 		*(port2adr(port)) = value;
@@ -101,9 +85,7 @@ void se_outb(unsigned char value, unsigned long port)

 void se_outb_p(unsigned char value, unsigned long port)
 {
-	if (sh_pcic_io_start <= port && port <= sh_pcic_io_stop)
-		*(__u8 *)(sh_pcic_io_wbase + port) = value;
-	else if (shifted_port(port))
+	if (shifted_port(port))
 		*(port2adr(port)) = value << 8;
 	else
 		*(port2adr(port)) = value;
@@ -112,8 +94,7 @@ void se_outb_p(unsigned char value, unsigned long port)

 void se_outw(unsigned short value, unsigned long port)
 {
-	if (port >= 0x2000 ||
-	    (sh_pcic_io_start <= port && port <= sh_pcic_io_stop))
+	if (port >= 0x2000)
 		*port2adr(port) = value;
 	else
 		maybebadio(port);
@@ -129,11 +110,7 @@ void se_insb(unsigned long port, void *addr, unsigned long count)
 	volatile __u16 *p = port2adr(port);
 	__u8 *ap = addr;

-	if (sh_pcic_io_start <= port && port <= sh_pcic_io_stop) {
-		volatile __u8 *bp = (__u8 *) (sh_pcic_io_wbase + 0x40000 + port);
-		while (count--)
-			*ap++ = *bp;
-	} else if (shifted_port(port)) {
+	if (shifted_port(port)) {
 		while (count--)
 			*ap++ = *p >> 8;
 	} else {
@@ -160,11 +137,7 @@ void se_outsb(unsigned long port, const void *addr, unsigned long count)
 	volatile __u16 *p = port2adr(port);
 	const __u8 *ap = addr;

-	if (sh_pcic_io_start <= port && port <= sh_pcic_io_stop) {
-		volatile __u8 *bp = (__u8 *) (sh_pcic_io_wbase + port);
-		while (count--)
-			*bp = *ap++;
-	} else if (shifted_port(port)) {
+	if (shifted_port(port)) {
 		while (count--)
 			*p = *ap++ << 8;
 	} else {
@@ -177,6 +150,7 @@ void se_outsw(unsigned long port, const void *addr, unsigned long count)
 {
 	volatile __u16 *p = port2adr(port);
 	const __u16 *ap = addr;
+
 	while (count--)
 		*p = *ap++;
 }
-- 
1.5.5.1


