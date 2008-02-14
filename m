From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Feb 2008 05:04:11 +0000
Subject: [PATCH] sh: fix pci io access for r2d boards
Message-Id: <20080214050411.6870.20292.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch is a fix to make sure readsN/writesN are used over insN/outsN for
ioreadN_rep/iowriteN_rep.

The current state of the sh io code is that mmio operations like readN/writeN
and ioreadN/iowriteN are unaffected by the value of generic_io_base. This is
different fom port based io like inN/outN which gets adjusted using the value
in generic_io_base.

Without this patch ioreadN_rep/iowriteN_rep get their addresses adjusted.
The address for mmio access is adjusted using generic_io_base. This is wrong.
The ata core code currently crashes if generic_io_base is set.

This patch changes ioreadN_rep/iowriteN_rep to follow the same rules as the
rest of the mmio operations, ie don't adjust using generic_io_base.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
Acked-by: Katsuya MATSUBARA <matsu@igel.co.jp>
---

 include/asm-sh/io.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- 0001/include/asm-sh/io.h
+++ work/include/asm-sh/io.h	2008-02-14 12:58:07.000000000 +0900
@@ -182,13 +182,13 @@ __BUILD_MEMORY_STRING(w, u16)
 #define iowrite32(v,a)		writel((v),(a))
 #define iowrite32be(v,a)	__raw_writel(cpu_to_be32((v)),(a))
 
-#define ioread8_rep(a,d,c)	insb((a),(d),(c))
-#define ioread16_rep(a,d,c)	insw((a),(d),(c))
-#define ioread32_rep(a,d,c)	insl((a),(d),(c))
-
-#define iowrite8_rep(a,s,c)	outsb((a),(s),(c))
-#define iowrite16_rep(a,s,c)	outsw((a),(s),(c))
-#define iowrite32_rep(a,s,c)	outsl((a),(s),(c))
+#define ioread8_rep(a, d, c)	readsb((a), (d), (c))
+#define ioread16_rep(a, d, c)	readsw((a), (d), (c))
+#define ioread32_rep(a, d, c)	readsl((a), (d), (c))
+
+#define iowrite8_rep(a, s, c)	writesb((a), (s), (c))
+#define iowrite16_rep(a, s, c)	writesw((a), (s), (c))
+#define iowrite32_rep(a, s, c)	writesl((a), (s), (c))
 
 #define mmiowb()	wmb()	/* synco on SH-4A, otherwise a nop */
 
