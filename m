From: Simon Horman <horms@verge.net.au>
Date: Fri, 06 Jun 2014 07:16:38 +0000
Subject: Re: [PATCH 2/2] ARM: lager: add i2c1, i2c2 pins
Message-Id: <20140606071638.GA20042@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1392224674-5328-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392224674-5328-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 05, 2014 at 09:49:22PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 06/05/2014 08:30 PM, Ben Dooks wrote:
> 
> >>>>Add pinctrl definitions for i2c1 and i2c2 busses on the Lager board
> >>>>to ensure these are setup correctly at initialisation time. The i2c0
> >>>>and i2c3 busses are connected to single function pins.
> 
> >>>>Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >>>>---
> >>>>   arch/arm/boot/dts/r8a7790-lager.dts | 14 ++++++++++++++
> >>>>   1 file changed, 14 insertions(+)
> 
> >>>I have queued up the following.
> 
> >>>There was some fuzz when applying this patch, please check that the
> >>>following is correct.
> 
> >>>From: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> >>>[PATCH] ARM: shmobile: lager: add i2c1, i2c2 pins
> 
> >>>Add pinctrl definitions for i2c1 and i2c2 busses on the Lager board
> >>>to ensure these are setup correctly at initialisation time. The i2c0
> >>>and i2c3 busses are connected to single function pins.
> 
> >>>Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >>>[horms+renesas@verge.net.au: Added shmobile to patch title]
> >>>Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >>>---
> >>>   arch/arm/boot/dts/r8a7790-lager.dts | 14 ++++++++++++++
> >>>   1 file changed, 14 insertions(+)
> 
> >>>diff --git a/arch/arm/boot/dts/r8a7790-lager.dts
> >>>b/arch/arm/boot/dts/r8a7790-lager.dts
> >>>index ee80788..e33ed0d 100644
> >>>--- a/arch/arm/boot/dts/r8a7790-lager.dts
> >>>+++ b/arch/arm/boot/dts/r8a7790-lager.dts
> >>>@@ -139,6 +139,16 @@
> >>>           states = <3300000 1
> >>>                 1800000 0>;
> >>>       };
> >>>+
> >>>+    i2c1_pins: i2c1 {
> >>>+        renesas,groups = "i2c1";
> >>>+        renesas,function = "i2c1";
> >>>+    };
> >>>+
> >>>+    i2c2_pins: i2c2 {
> >>>+        renesas,groups = "i2c2";
> >>>+        renesas,function = "i2c2";
> >>>+    };
> 
> >>    These subnodes ended up added to a wrong node, they should have been
> >>added to the PFC node below.
> 
> >Thanks, it is not obvious from just looking at them.
> 
>    It was obvious from the context, actually.

Thanks for pointing out my error.

I plan to queue up the following to resolve this problem.

From: Simon Horman <horms+renesas@verge.net.au>

[PATCH] ARM: shmobile: lager: Move i2c[12]_pins nodes to pfc node

Due to an error when resolving conflicts df40f256b18300e1 ("ARM: shmobile:
lager: add i2c1, i2c2 pins") added the i2c[12]_pins nodes to the wrong
node.

This patch moves them to their correct location in the pfc node.

Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index e33ed0d..2bb42bc 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -139,16 +139,6 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
-
-	i2c1_pins: i2c1 {
-		renesas,groups = "i2c1";
-		renesas,function = "i2c1";
-	};
-
-	i2c2_pins: i2c2 {
-		renesas,groups = "i2c2";
-		renesas,function = "i2c2";
-	};
 };
 
 &extal_clk {
@@ -210,6 +200,16 @@
 		renesas,function = "msiof1";
 	};
 
+	i2c1_pins: i2c1 {
+		renesas,groups = "i2c1";
+		renesas,function = "i2c1";
+	};
+
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
+
 	i2c3_pins: i2c3 {
 		renesas,groups = "i2c3";
 		renesas,function = "i2c3";
-- 
2.0.0.rc2

