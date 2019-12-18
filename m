From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Dec 2019 02:08:35 +0000
Subject: [PATCH v3] SH: Convert ins[bwl]/outs[bwl] macros to inline functions
Message-Id: <87sglijsgs.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Macro ins[bwl]/outs[bwl] are just calling BUG(), but that results in
unused variable warnings all over the place.
This patch convert macro to inline to avoid warning

We will get this kind of warning without this patch

	${LINUX}/drivers/iio/adc/ad7606_par.c:21:23: \
	  warning: unused variable 'st' [-Wunused-variable]
	struct ad7606_state *st = iio_priv(indio_dev);
	^~

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

	- tidyup function name vs white-space

 arch/sh/include/asm/io_noioport.h | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/io_noioport.h b/arch/sh/include/asm/io_noioport.h
index 90d6109..f7938fe 100644
--- a/arch/sh/include/asm/io_noioport.h
+++ b/arch/sh/include/asm/io_noioport.h
@@ -53,12 +53,34 @@ static inline void ioport_unmap(void __iomem *addr)
 #define outw_p(x, addr)	outw((x), (addr))
 #define outl_p(x, addr)	outl((x), (addr))
 
-#define insb(a, b, c)	BUG()
-#define insw(a, b, c)	BUG()
-#define insl(a, b, c)	BUG()
+static inline void insb(unsigned long port, void *dst, unsigned long count)
+{
+	BUG();
+}
+
+static inline void insw(unsigned long port, void *dst, unsigned long count)
+{
+	BUG();
+}
+
+static inline void insl(unsigned long port, void *dst, unsigned long count)
+{
+	BUG();
+}
 
-#define outsb(a, b, c)	BUG()
-#define outsw(a, b, c)	BUG()
-#define outsl(a, b, c)	BUG()
+static inline void outsb(unsigned long port, const void *src, unsigned long count)
+{
+	BUG();
+}
+
+static inline void outsw(unsigned long port, const void *src, unsigned long count)
+{
+	BUG();
+}
+
+static inline void outsl(unsigned long port, const void *src, unsigned long count)
+{
+	BUG();
+}
 
 #endif /* __ASM_SH_IO_NOIOPORT_H */
-- 
2.7.4
