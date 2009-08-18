From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 18 Aug 2009 06:51:47 +0000
Subject: [PATCH] clock-sh7724.c: modify divisors value
Message-Id: <ud46ty5q4.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


This patch modify divisors value becouse FRQCRA :: IFC can use b'0001

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index 34611d9..627588d 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -127,7 +127,7 @@ struct clk *main_clks[] = {
 	&div3_clk,
 };
 
-static int divisors[] = { 2, 0, 4, 6, 8, 12, 16, 0, 24, 32, 36, 48, 0, 72 };
+static int divisors[] = { 2, 3, 4, 6, 8, 12, 16, 0, 24, 32, 36, 48, 0, 72 };
 
 static struct clk_div_mult_table div4_table = {
 	.divisors = divisors,
-- 
1.6.0.4

