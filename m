From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 23 Jul 2020 08:20:17 +0000
Subject: [PATCH] sh: clk: Fix assignment from incompatible pointer type for ioreadX()
Message-Id: <20200723082017.24053-1-krzk@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Krzysztof Kozlowski <krzk@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>

The ioreadX() helpers accept now pointer to const memory so declaration
of read function needs updating.

This fixes build errors like:

    drivers/sh/clk/cpg.c: In function ‘sh_clk_mstp_enable’:
    drivers/sh/clk/cpg.c:49:9: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
        read = ioread8;

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Dear Andrew,

This was part of my v3 patchset commit 9ab7fb303cc1 ("iomap: Constify
ioreadX() iomem argument (as in generic implementation)") but I think it
was skipped when applying to your tree.

Maybe because it depends on commit 58c4d8659186 ("sh: clkfwk: remove
r8/r16/r32") which landed later?  Anyway it should go through your tree,
I think.
---
 drivers/sh/clk/cpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index a5cacfe24a42..fd72d9088bdc 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -40,7 +40,7 @@ static int sh_clk_mstp_enable(struct clk *clk)
 {
 	sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
 	if (clk->status_reg) {
-		unsigned int (*read)(void __iomem *addr);
+		unsigned int (*read)(const void __iomem *addr);
 		int i;
 		void __iomem *mapped_status = (phys_addr_t)clk->status_reg -
 			(phys_addr_t)clk->enable_reg + clk->mapped_reg;
-- 
2.17.1
