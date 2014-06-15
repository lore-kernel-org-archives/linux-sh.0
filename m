From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 15 Jun 2014 19:56:26 +0000
Subject: [PATCH 1/9] ARM: lager: enable i2c devices
Message-Id: <1402862194-17743-2-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1402862194-17743-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1402862194-17743-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, linux-media@vger.kernel.org
Cc: robert.jarzmik@free.fr, g.liakhovetski@gmx.de, magnus.damm@opensource.se, horms@verge.net.au, ian.molton@codethink.co.uk, william.towle@codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>

Add i2c0, i2c1, i2c2 and i2c3 nodes to the Lager reference device tree as
these busses all have devices on them that can be probed even if they
are no drivers yet.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index dd2fe46..8617755 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -317,3 +317,19 @@
 	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
 	status = "okay";
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
2.0.0

