From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 12 Feb 2014 17:04:33 +0000
Subject: [PATCH 1/2] ARM: lager: enable i2c devices
Message-Id: <1392224674-5328-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add i2c0, i2c1, i2c2 and i2c3 nodes to the Lager reference device tree as
these busses all have devices on them that can be probed even if they
are no drivers yet.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 1081c5e..890e39d 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -95,3 +95,19 @@
 &sata1 {
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
1.8.5.3

