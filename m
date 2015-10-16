From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 16 Oct 2015 15:14:55 +0000
Subject: [PATCH] clk: shmobile: r8a7778: Make r8a7778_rates[] and r8a7778_divs[] static const
Message-Id: <1445008495-27708-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-clk@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

r8a7778_rates[] and r8a7778_divs[] are only used in clk-r8a7778.c, and
never modified.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/shmobile/clk-r8a7778.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/shmobile/clk-r8a7778.c b/drivers/clk/shmobile/clk-r8a7778.c
index 87c1d2f2fb57a46c..b1741551fff2a6c9 100644
--- a/drivers/clk/shmobile/clk-r8a7778.c
+++ b/drivers/clk/shmobile/clk-r8a7778.c
@@ -20,10 +20,10 @@ struct r8a7778_cpg {
 };
 
 /* PLL multipliers per bits 11, 12, and 18 of MODEMR */
-struct {
+static const struct {
 	unsigned long plla_mult;
 	unsigned long pllb_mult;
-} r8a7778_rates[] __initdata = {
+} r8a7778_rates[] __initconst = {
 	[0] = { 21, 21 },
 	[1] = { 24, 24 },
 	[2] = { 28, 28 },
@@ -34,10 +34,10 @@ struct {
 };
 
 /* Clock dividers per bits 1 and 2 of MODEMR */
-struct {
+static const struct {
 	const char *name;
 	unsigned int div[4];
-} r8a7778_divs[6] __initdata = {
+} r8a7778_divs[6] __initconst = {
 	{ "b",   { 12, 12, 16, 18 } },
 	{ "out", { 12, 12, 16, 18 } },
 	{ "p",   { 16, 12, 16, 12 } },
-- 
1.9.1

