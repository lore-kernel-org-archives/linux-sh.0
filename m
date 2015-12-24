From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 24 Dec 2015 10:14:18 +0000
Subject: [PATCH] clk: shmobile: r8a7795: Add SATA0 clock
Message-Id: <1450952058-15888-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-clk@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Hi Mike, Stephen,

This is the sole missing piece to make SATA work on r8a7795 in v4.5.
All other pieces (bindings, driver, pinctrl, dts) are already queued for
v4.5.

Thanks for applying!

 drivers/clk/shmobile/r8a7795-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/shmobile/r8a7795-cpg-mssr.c b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
index 57c413635d1af135..13e994772dfd0cf2 100644
--- a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
+++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
@@ -150,6 +150,7 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
 	DEF_MOD("hdmi1",		 728,	R8A7795_CLK_HDMI),
 	DEF_MOD("hdmi0",		 729,	R8A7795_CLK_HDMI),
 	DEF_MOD("etheravb",		 812,	R8A7795_CLK_S3D2),
+	DEF_MOD("sata0",		 815,	R8A7795_CLK_S3D2),
 	DEF_MOD("gpio7",		 905,	R8A7795_CLK_CP),
 	DEF_MOD("gpio6",		 906,	R8A7795_CLK_CP),
 	DEF_MOD("gpio5",		 907,	R8A7795_CLK_CP),
-- 
1.9.1

