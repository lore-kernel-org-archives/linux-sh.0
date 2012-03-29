From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 29 Mar 2012 07:40:38 +0000
Subject: iomap API and big endian interactivity
Message-Id: <20120329074038.GZ26543@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 12, 2011 at 09:03:24AM +0100, Phil Edworthy wrote:
> Commit 37b7a97884ba64bf7d403351ac2a9476ab4f1bba makes all ioread/iowrite
> functions treat registers as little endian. For SH2 this is not the case,
> they are big endian.
> 
Ok, it looks like we're finally going to have to bite the bullet and
support I/O swabbing for the platforms that need it. I dislike this for
the reasons that the I/O accessors are supposed to be little endian and
in the PCI case we can deal with CPU vs host controller endianness
mismatches just fine, ensuring a consistent little endian space.

It's not sufficient to back off from the I/O accessors that are presently
employed given that they do a lot more with regards to ordering and cache
maintenance across the various platforms that the raw ones simply ignore.
While this was ok for the effected parts in the past, returning to that
approach would introduce far more subtle and hard to debug breakage on
newer parts than the current issues experienced on the big endian ones.
(SH7785 in big endian mode is one of the ones that needs the barrier
semantics provided by the non-relaxed variants, so we're not able to work
around it with this approach anyways).

For now I've added trivial I/O swabbing based on the MIPS port mangling
interface (though I dropped the actual port mangling bits, as we deal
with all of those gnarly SuperIOs with bizarre hookups through trapped
I/O these days). The resulting interface should permit platforms to
enable it unconditionally where necessary, and conditionally relative to
endianness (ie, SH7785 && BE).

Hopefully this will be all that's necessary for fixing up the SH-2(A) and
SH-4A big endian use cases. Boards can of course override the swabbing
behaviour where necessary, though I don't forsee much need to deviate
from the generic implementation any time soon given that we've ripped out
the address swizzling (in which case we could probably just inline it in
io.h directly).

---

 arch/sh/Kconfig                                |    3 +
 arch/sh/include/asm/io.h                       |   25 +++++-------
 arch/sh/include/mach-common/mach/mangle-port.h |   49 +++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 15 deletions(-)

commit b7e68d6876dfbab087bc3859211a9efc74cbe30c
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Thu Mar 29 16:05:10 2012 +0900

    sh: Support I/O space swapping where needed.
    
    This adopts a trimmed down version of the MIPS port mangling interface
    limited to the I/O swabbing for platforms that can't use little endian
    accessors. For platforms with mixed I/O spaces involving PCI it will
    still be necessary to enable byte swapping at the host controller level.
    Attention needs to be paid to all of host controller endianness, CPU
    endianness, and whether I/O accesses are explicitly swapped or not via
    SWAP_IO_SPACE. Fortunately the platforms that need this are in the
    minority.
    
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5d1ae85..2d9cd13 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -162,6 +162,9 @@ config NO_IOPORT
 config IO_TRAPPED
 	bool
 
+config SWAP_IO_SPACE
+	bool
+
 config DMA_COHERENT
 	bool
 
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 28c5aa5..eb76cb3 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -24,6 +24,7 @@
 #define __IO_PREFIX     generic
 #include <asm/io_generic.h>
 #include <asm/io_trapped.h>
+#include <mach/mangle-port.h>
 
 #define __raw_writeb(v,a)	(__chk_io_ptr(a), *(volatile u8  __force *)(a) = (v))
 #define __raw_writew(v,a)	(__chk_io_ptr(a), *(volatile u16 __force *)(a) = (v))
@@ -35,21 +36,15 @@
 #define __raw_readl(a)		(__chk_io_ptr(a), *(volatile u32 __force *)(a))
 #define __raw_readq(a)		(__chk_io_ptr(a), *(volatile u64 __force *)(a))
 
-#define readb_relaxed(c)	({ u8  __v = __raw_readb(c); __v; })
-#define readw_relaxed(c)	({ u16 __v = le16_to_cpu((__force __le16) \
-					__raw_readw(c)); __v; })
-#define readl_relaxed(c)	({ u32 __v = le32_to_cpu((__force __le32) \
-					__raw_readl(c)); __v; })
-#define readq_relaxed(c)	({ u64 __v = le64_to_cpu((__force __le64) \
-					__raw_readq(c)); __v; })
-
-#define writeb_relaxed(v,c)	((void)__raw_writeb(v,c))
-#define writew_relaxed(v,c)	((void)__raw_writew((__force u16) \
-					cpu_to_le16(v),c))
-#define writel_relaxed(v,c)	((void)__raw_writel((__force u32) \
-					cpu_to_le32(v),c))
-#define writeq_relaxed(v,c)	((void)__raw_writeq((__force u64) \
-					cpu_to_le64(v),c))
+#define readb_relaxed(c)	({ u8  __v = ioswabb(__raw_readb(c)); __v; })
+#define readw_relaxed(c)	({ u16 __v = ioswabw(__raw_readw(c)); __v; })
+#define readl_relaxed(c)	({ u32 __v = ioswabl(__raw_readl(c)); __v; })
+#define readq_relaxed(c)	({ u64 __v = ioswabq(__raw_readq(c)); __v; })
+
+#define writeb_relaxed(v,c)	((void)__raw_writeb((__force  u8)ioswabb(v),c))
+#define writew_relaxed(v,c)	((void)__raw_writew((__force u16)ioswabw(v),c))
+#define writel_relaxed(v,c)	((void)__raw_writel((__force u32)ioswabl(v),c))
+#define writeq_relaxed(v,c)	((void)__raw_writeq((__force u64)ioswabq(v),c))
 
 #define readb(a)		({ u8  r_ = readb_relaxed(a); rmb(); r_; })
 #define readw(a)		({ u16 r_ = readw_relaxed(a); rmb(); r_; })
diff --git a/arch/sh/include/mach-common/mach/mangle-port.h b/arch/sh/include/mach-common/mach/mangle-port.h
new file mode 100644
index 0000000..4ca1769
--- /dev/null
+++ b/arch/sh/include/mach-common/mach/mangle-port.h
@@ -0,0 +1,49 @@
+/*
+ * SH version cribbed from the MIPS copy:
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003, 2004 Ralf Baechle
+ */
+#ifndef __MACH_COMMON_MANGLE_PORT_H
+#define __MACH_COMMON_MANGLE_PORT_H
+
+/*
+ * Sane hardware offers swapping of PCI/ISA I/O space accesses in hardware;
+ * less sane hardware forces software to fiddle with this...
+ *
+ * Regardless, if the host bus endianness mismatches that of PCI/ISA, then
+ * you can't have the numerical value of data and byte addresses within
+ * multibyte quantities both preserved at the same time.  Hence two
+ * variations of functions: non-prefixed ones that preserve the value
+ * and prefixed ones that preserve byte addresses.  The latters are
+ * typically used for moving raw data between a peripheral and memory (cf.
+ * string I/O functions), hence the "__mem_" prefix.
+ */
+#if defined(CONFIG_SWAP_IO_SPACE)
+
+# define ioswabb(x)		(x)
+# define __mem_ioswabb(x)	(x)
+# define ioswabw(x)		le16_to_cpu(x)
+# define __mem_ioswabw(x)	(x)
+# define ioswabl(x)		le32_to_cpu(x)
+# define __mem_ioswabl(x)	(x)
+# define ioswabq(x)		le64_to_cpu(x)
+# define __mem_ioswabq(x)	(x)
+
+#else
+
+# define ioswabb(x)		(x)
+# define __mem_ioswabb(x)	(x)
+# define ioswabw(x)		(x)
+# define __mem_ioswabw(x)	cpu_to_le16(x)
+# define ioswabl(x)		(x)
+# define __mem_ioswabl(x)	cpu_to_le32(x)
+# define ioswabq(x)		(x)
+# define __mem_ioswabq(x)	cpu_to_le32(x)
+
+#endif
+
+#endif /* __MACH_COMMON_MANGLE_PORT_H */
