From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 08 Jun 2020 08:06:36 +0000
Subject: [PATCH] Revert "sh: add missing EXPORT_SYMBOL() for __delay"
Message-Id: <20200608080636.27862-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "J . P . Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

This reverts commit d1f56f318d234fc5db230af2f3e0088f689ab3c0.

__delay() is an internal implementation detail on several architectures.
Drivers should not call __delay() directly, as it has non-standardized
semantics, or may not even exist.
Hence there is no need to export __delay() to modules.

See also include/asm-generic/delay.h:

    /* Undefined functions to get compile-time errors */
    ...
    extern void __delay(unsigned long loops);

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Sorry for missing this when Adrian posted his list of mising patches.

References:
[1] "Re: Build regressions/improvements in v5.4-rc2"
    https://lore.kernel.org/r/CAMuHMdUERaoHLNKi03zCuYi7NevgBFjXrV=pt0Yy=HOeRiL25Q@mail.gmail.com/
[2] "Re: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay"
    http://lore.kernel.org/r/CAMuHMdWb_ipn7FVHbz8=PTdGod=MW+2xHY7yuq3yJcWwNnDvcg@mail.gmail.com
---
 arch/sh/lib/delay.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/lib/delay.c b/arch/sh/lib/delay.c
index 540e670dbafcd826..dad8e6a54906bece 100644
--- a/arch/sh/lib/delay.c
+++ b/arch/sh/lib/delay.c
@@ -29,7 +29,6 @@ void __delay(unsigned long loops)
 		: "0" (loops)
 		: "t");
 }
-EXPORT_SYMBOL(__delay);
 
 inline void __const_udelay(unsigned long xloops)
 {
-- 
2.17.1
