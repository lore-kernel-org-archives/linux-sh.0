From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 29 Dec 2014 01:43:40 +0000
Subject: [PATCH 6/7] ARM: shmobile: alt dts: Replace status value "ok" by "okay"
Message-Id: <38e02908f3a4bf261c618893649e88bc92197566.1419809027.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1419809027.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1419809027.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

While the DT parsing code recognizes "ok" as a valid value for the
"status" property, ePAPR v1.1 doesn't mention it in the list of valid
values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index f2cf757..0d848e6 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -40,9 +40,9 @@
 };
 
 &cmt0 {
-	status = "ok";
+	status = "okay";
 };
 
 &scif2 {
-	status = "ok";
+	status = "okay";
 };
-- 
2.1.3

