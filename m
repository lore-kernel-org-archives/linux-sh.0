From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 14 Feb 2019 19:20:16 +0000
Subject: [PATCH] sh: sh7786: Add explicit I/O cast to sh7786_mm_sel()
Message-Id: <20190214192016.25532-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

When compile-testing on arm:

    arch/sh/include/cpu-sh4/cpu/sh7786.h: In function ‘sh7786_mm_sel’:
    arch/sh/include/cpu-sh4/cpu/sh7786.h:135:21: warning: passing argument 1 of ‘__raw_readl’ makes pointer from integer without a cast [-Wint-conversion]
      return __raw_readl(0xFC400020) & 0x7;
			 ^~~~~~~~~~
    In file included from include/linux/io.h:25:0,
		     from arch/sh/include/cpu-sh4/cpu/sh7786.h:14,
		     from drivers/pinctrl/sh-pfc/pfc-sh7786.c:15:
    arch/arm/include/asm/io.h:113:21: note: expected ‘const volatile void *’ but argument is of type ‘unsigned int’
     #define __raw_readl __raw_readl
			 ^
    arch/arm/include/asm/io.h:114:19: note: in expansion of macro ‘__raw_readl’
     static inline u32 __raw_readl(const volatile void __iomem *addr)
		       ^~~~~~~~~~~

__raw_readl() on SuperH is a macro that casts the passed I/O address to
the correct type, while its implementations on most other architectures
expect to be passed the correct pointer type.

Add an explicit cast to fix this.

Note that this also gets rid of a sparse warning on SuperH:

    arch/sh/include/cpu-sh4/cpu/sh7786.h:135:16: warning: incorrect type in argument 1 (different base types)
    arch/sh/include/cpu-sh4/cpu/sh7786.h:135:16:    expected void const volatile [noderef] <asn:2>*<noident>
    arch/sh/include/cpu-sh4/cpu/sh7786.h:135:16:    got unsigned int

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
As this is a dependency for sh-pfc compile-testing, I intend to queue
this up in sh-pfc-for-v5.2, unless it appears in v5.1 first.
---
 arch/sh/include/cpu-sh4/cpu/sh7786.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/sh7786.h b/arch/sh/include/cpu-sh4/cpu/sh7786.h
index 8f9bfbf3cdb1097f..d6cce65b48713f60 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7786.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7786.h
@@ -132,7 +132,7 @@ enum {
 
 static inline u32 sh7786_mm_sel(void)
 {
-	return __raw_readl(0xFC400020) & 0x7;
+	return __raw_readl((const volatile void __iomem *)0xFC400020) & 0x7;
 }
 
 #endif /* __CPU_SH7786_H__ */
-- 
2.17.1
