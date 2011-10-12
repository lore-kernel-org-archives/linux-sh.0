From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 12 Oct 2011 08:03:24 +0000
Subject: [PATCH/RFC v2] sh: Use big endian ioread/write for SH2 platforms
Message-Id: <1318406604-16537-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Commit 37b7a97884ba64bf7d403351ac2a9476ab4f1bba makes all ioread/iowrite
functions treat registers as little endian. For SH2 this is not the case,
they are big endian.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v2: Modified so that it's used on all SH2 devices

 arch/sh/include/asm/io.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 28c5aa5..65f2d5a 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -35,6 +35,7 @@
 #define __raw_readl(a)		(__chk_io_ptr(a), *(volatile u32 __force *)(a))
 #define __raw_readq(a)		(__chk_io_ptr(a), *(volatile u64 __force *)(a))
 
+#ifndef CONFIG_CPU_SH2
 #define readb_relaxed(c)	({ u8  __v = __raw_readb(c); __v; })
 #define readw_relaxed(c)	({ u16 __v = le16_to_cpu((__force __le16) \
 					__raw_readw(c)); __v; })
@@ -50,6 +51,23 @@
 					cpu_to_le32(v),c))
 #define writeq_relaxed(v,c)	((void)__raw_writeq((__force u64) \
 					cpu_to_le64(v),c))
+#else
+#define readb_relaxed(c)	({ u8  __v = __raw_readb(c); __v; })
+#define readw_relaxed(c)	({ u16 __v = be16_to_cpu((__force __be16) \
+					__raw_readw(c)); __v; })
+#define readl_relaxed(c)	({ u32 __v = be32_to_cpu((__force __be32) \
+					__raw_readl(c)); __v; })
+#define readq_relaxed(c)	({ u64 __v = be64_to_cpu((__force __be64) \
+					__raw_readq(c)); __v; })
+
+#define writeb_relaxed(v,c)	((void)__raw_writeb(v,c))
+#define writew_relaxed(v,c)	((void)__raw_writew((__force u16) \
+					cpu_to_be16(v),c))
+#define writel_relaxed(v,c)	((void)__raw_writel((__force u32) \
+					cpu_to_be32(v),c))
+#define writeq_relaxed(v,c)	((void)__raw_writeq((__force u64) \
+					cpu_to_be64(v),c))
+#endif
 
 #define readb(a)		({ u8  r_ = readb_relaxed(a); rmb(); r_; })
 #define readw(a)		({ u16 r_ = readw_relaxed(a); rmb(); r_; })
-- 
1.7.0.4

