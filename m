From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Wed, 02 Feb 2011 07:05:15 +0000
Subject: [PATCH] sh: Provide in/out{b,w,l}
Message-Id: <1296630315-21264-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

By commit 37b7a97884ba64bf7d403351ac2a9476ab4f1bba,
delete machvec IO routines.
Because the definition of in/out_{b,w,l} was deleted,
driver needing these cannot build.
This defines it again.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/include/asm/io.h |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 28c5aa5..408d3ed 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -69,6 +69,43 @@
 #define writesw(p,d,l)		__raw_writesw(p,d,l)
 #define writesl(p,d,l)		__raw_writesl(p,d,l)
 
+static inline u8 inb(unsigned long addr)
+{
+	return __raw_readb(addr);
+}
+
+static inline u16 inw(unsigned long addr)
+{
+	return __raw_readw(addr);
+}
+
+static inline u32 inl(unsigned long addr)
+{
+	return __raw_readl(addr);
+}
+
+static inline void outb(u8 b, unsigned long addr)
+{
+	__raw_writeb(b, addr);
+}
+
+static inline void outw(u16 b, unsigned long addr)
+{
+	__raw_writew(b, addr);
+}
+
+static inline void outl(u32 b, unsigned long addr)
+{
+	__raw_writel(b, addr);
+}
+
+#define inb_p(addr)		readb_relaxed(addr)
+#define inw_p(addr)		readw_relaxed(addr)
+#define inl_p(addr)		readl_relaxed(addr)
+#define outb_p(x, addr)	writeb_relaxed((x), (addr))
+#define outw_p(x, addr)	writew_relaxed((x), (addr))
+#define outl_p(x, addr)	writel_relaxed((x), (addr))
+
 #define __BUILD_UNCACHED_IO(bwlq, type)					\
 static inline type read##bwlq##_uncached(unsigned long addr)		\
 {									\
-- 
1.7.2.3

