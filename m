From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 15 Dec 2014 04:57:52 +0000
Subject: [PATCH] ARM: shmobile: r8a7779: Use R8A7779_CLK_P as SCIF parent clock
Message-Id: <20141215050034.357.93456.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Use R8A7779_CLK_P as parent clock for SCIF devices on r8a7779.
With this change in place the SCIF CCF handling matches the
legacy clock code. Also, this matches the data sheet.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-20141211-v3.18
 Broken out from previously submitted
 [PATCH] ARM: shmobile: r8a7779 CCF DTS update

 arch/arm/boot/dts/r8a7779.dtsi |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- 0002/arch/arm/boot/dts/r8a7779.dtsi
+++ work/arch/arm/boot/dts/r8a7779.dtsi	2014-12-15 12:31:16.000000000 +0900
@@ -464,12 +464,12 @@
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_S>,
 				 <&cpg_clocks R8A7779_CLK_S>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
