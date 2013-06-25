From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 25 Jun 2013 07:07:06 +0000
Subject: [PATCH] regulator: max8973: fix a typo in documentation
Message-Id: <Pine.LNX.4.64.1306250905050.30321@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Magnus Damm <magnus.damm@gmail.com>

Fix a s/maxium/maxim/ typo in DT binding documentation.

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

Mark, if still possible, feel free to merge this with the original patch.
Thanks
Guennadi

 .../bindings/regulator/max8973-regulator.txt       |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/max8973-regulator.txt b/Documentation/devicetree/bindings/regulator/max8973-regulator.txt
index 8d38ab2..4f15d8a 100644
--- a/Documentation/devicetree/bindings/regulator/max8973-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/max8973-regulator.txt
@@ -2,7 +2,7 @@
 
 Required properties:
 
-- compatible:	must be "maxium,max8973"
+- compatible:	must be "maxim,max8973"
 - reg:		the i2c slave address of the regulator. It should be 0x1b.
 
 Any standard regulator properties can be used to configure the single max8973
@@ -11,7 +11,7 @@ DCDC.
 Example:
 
 	max8973@1b {
-		compatible = "maxium,max8973";
+		compatible = "maxim,max8973";
 		reg = <0x1b>;
 
 		regulator-min-microvolt = <935000>;
-- 
1.7.2.5

