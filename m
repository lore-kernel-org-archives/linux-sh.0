From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Jun 2014 00:32:54 +0000
Subject: Re: [PATCH 2/2] ARM: lager: add i2c1, i2c2 pins
Message-Id: <20140605003254.GC10759@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1392224674-5328-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392224674-5328-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 12, 2014 at 05:04:34PM +0000, Ben Dooks wrote:
> Add pinctrl definitions for i2c1 and i2c2 busses on the Lager board
> to ensure these are setup correctly at initialisation time. The i2c0
> and i2c3 busses are connected to single function pins.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

I have queued up the following.

There was some fuzz when applying this patch, please check that the
following is correct.

From: Ben Dooks <ben.dooks@codethink.co.uk>

[PATCH] ARM: shmobile: lager: add i2c1, i2c2 pins

Add pinctrl definitions for i2c1 and i2c2 busses on the Lager board
to ensure these are setup correctly at initialisation time. The i2c0
and i2c3 busses are connected to single function pins.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[horms+renesas@verge.net.au: Added shmobile to patch title]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index ee80788..e33ed0d 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -139,6 +139,16 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	i2c1_pins: i2c1 {
+		renesas,groups = "i2c1";
+		renesas,function = "i2c1";
+	};
+
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
 };
 
 &extal_clk {
@@ -331,10 +341,14 @@
 
 &i2c1	{
 	status = "ok";
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
 };
 
 &i2c2	{
 	status = "ok";
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
 };
 
 &i2c3	{
-- 
2.0.0.rc2

