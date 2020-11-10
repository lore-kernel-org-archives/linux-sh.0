From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 10 Nov 2020 15:50:29 +0000
Subject: [PATCH resend v2] sh: boards: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Message-Id: <20201110155029.3286090-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@kernel.org>

The SuperH/J2 DT platform code is not a clock provider, and just needs
to call of_clk_init().

Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
v2:
  - Add Reviewed-by.
---
 arch/sh/boards/of-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index bffbe69b2236a1ee..921d76fc33583f78 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -6,10 +6,10 @@
  */
 
 #include <linux/of.h>
+#include <linux/of_clk.h>
 #include <linux/of_fdt.h>
 #include <linux/clocksource.h>
 #include <linux/irqchip.h>
-#include <linux/clk-provider.h>
 #include <asm/machvec.h>
 #include <asm/rtc.h>
 
-- 
2.25.1
