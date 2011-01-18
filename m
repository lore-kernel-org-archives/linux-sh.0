From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 Jan 2011 08:53:06 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0 CPGA fix for FRQCRA M3
Message-Id: <20110118085306.9304.40981.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20101222061405.25163.82564.sendpatchset@t400s>
In-Reply-To: <20101222061405.25163.82564.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix the M3 field offset for the FRQCRA register
in the sh73a0 CPGA. It should be 12, not 8.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh73a0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0004/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2011-01-18 17:49:22.000000000 +0900
@@ -212,7 +212,7 @@ enum { DIV4_I, DIV4_ZG, DIV4_M3, DIV4_B,
 static struct clk div4_clks[DIV4_NR] = {
 	[DIV4_I] = DIV4(FRQCRA, 20, 0xfff, CLK_ENABLE_ON_INIT),
 	[DIV4_ZG] = DIV4(FRQCRA, 16, 0xbff, CLK_ENABLE_ON_INIT),
-	[DIV4_M3] = DIV4(FRQCRA, 8, 0xfff, CLK_ENABLE_ON_INIT),
+	[DIV4_M3] = DIV4(FRQCRA, 12, 0xfff, CLK_ENABLE_ON_INIT),
 	[DIV4_B] = DIV4(FRQCRA, 8, 0xfff, CLK_ENABLE_ON_INIT),
 	[DIV4_M1] = DIV4(FRQCRA, 4, 0xfff, 0),
 	[DIV4_M2] = DIV4(FRQCRA, 0, 0xfff, 0),
