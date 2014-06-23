From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Jun 2014 02:28:19 +0000
Subject: [PATCH 10/29] ARM: shmobile: lager: enable i2c devices
Message-Id: <e489c2a9bc82713167d9f721ca764f4b0d37e543.1403487225.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403487225.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1403487225.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Add i2c0, i2c1, i2c2 and i2c3 nodes to the Lager reference device tree as
these busses all have devices on them that can be probed even if they
are no drivers yet.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[horms+renesas@verge.net.au: Added shmobile to title]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index cc65e3f..bd92dcf 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -342,3 +342,19 @@
 &cpu0 {
 	cpu0-supply = <&vdd_dvfs>;
 };
+
+&i2c0	{
+	status = "ok";
+};
+
+&i2c1	{
+	status = "ok";
+};
+
+&i2c2	{
+	status = "ok";
+};
+
+&i2c3	{
+	status = "ok";
+};
-- 
2.0.0.rc2

