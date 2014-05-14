From: Simon Horman <horms@verge.net.au>
Date: Wed, 14 May 2014 05:13:10 +0000
Subject: Re: [RFC/PATCH 5/6] ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT
Message-Id: <20140514051309.GE18495@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1398817906-6023-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398817906-6023-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 01, 2014 at 03:04:32PM +0900, Simon Horman wrote:
> On Wed, Apr 30, 2014 at 11:47:16PM +0200, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > On Thursday 01 May 2014 07:44:57 Simon Horman wrote:
> > > On Wed, Apr 30, 2014 at 06:23:40PM +0200, Laurent Pinchart wrote:
> > > > On Wednesday 30 April 2014 10:34:12 Simon Horman wrote:
> > > > > On Wed, Apr 30, 2014 at 10:29:23AM +0900, Simon Horman wrote:
> > > > > > On Wed, Apr 30, 2014 at 03:02:20AM +0200, Laurent Pinchart wrote:
> > > > > > > On Wednesday 30 April 2014 09:59:56 Simon Horman wrote:
> > > > > > > > On Wed, Apr 30, 2014 at 02:31:45AM +0200, Laurent Pinchart wrote:
> > > > > > > > > SCIF0 and SCIF1 are used as debug serial ports. Enable them and
> > > > > > > > > configure pinmuxing appropriately. We can now remove the clkdev
> > > > > > > > > registration hack for SCIF devices from the Lager reference
> > > > > > > > > board file.
> > > > > > > > > 
> > > > > > > > > As a side effect of switching to DT-based serial port
> > > > > > > > > instantiation, ttySC6 and ttySC7 get renamed to ttySC0 and
> > > > > > > > > ttySC1. As the device tree source if now shared between lager
> > > > > > > > > and lager-reference, we need to update the serial ports in C
> > > > > > > > > code as well.
> > > > > > > > 
> > > > > > > > I believe the second paragraph is no longer correct.
> > > > > > > 
> > > > > > > Oops, you're right. If no other problem is found with the series,
> > > > > > > could you please just drop that paragraph ?
> > > > > > 
> > > > > > Yes. But could you look at my other comment below?
> > > > > 
> > > > > I mean yes with the following caveat.
> > > > > 
> > > > > It seems to me that each of patch 4 and 5 could applied independently
> > > > > of the earlier patches in the series. This seems nice.
> > > > 
> > > > I suppose you mean patches 5 and 6.
> > > 
> > > Yes, that is what I meant :)
> > > 
> > > > > It seems to me that patches 3 and 4 depend on patch 2 which in turn
> > > > > depends on patch 1. This is less fun. So I was thinking of waiting
> > > > > for at least patch 2 to be accepted (by Greg) before applying
> > > > > 3 and 4.
> > > > 
> > > > That's fine with me.
> > > > 
> > > > > With regards to patch 1. Perhaps it would be best for Greg to take
> > > > > that with patch 2?
> > > > 
> > > > That's fine with me as well.
> > > 
> > > I wrote the above asuming that patch 2 maintained compatibility with
> > > for existing DT nodes (in particular the ones modified in patches 3 and 4).
> > > I'd prefer to finalise the discussion regarding patch 2 that before
> > > applying 5 and 6 as I see a chance of regression if we are not careful.
> > 
> > Sure. I'll reply to "RFC/PATCH 2/6] serial: sh-sci: Drop the interface clock", 
> > let's discuss that there.
> 
> Yes, lets.

As discussed privately I have queued up the following modified version
of your patch without any of the earlier patches in this series.

I will also apply the last patch of this series, which is similar
but for the koelsch board, with minor modifications.

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

[PATCH] ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT

SCIF0 and SCIF1 are used as debug serial ports. Enable them and
configure pinmuxing appropriately. We can now remove the clkdev
registration hack for SCIF devices from the Lager reference board file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[horms+renesas@verge.net.au: updated changelog to remove references to
                             device renaming]
[horms+renesas@verge.net.au: resolved conflicts]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts            | 21 ++++++++++++++++++++-
 arch/arm/mach-shmobile/board-lager-reference.c | 10 ----------
 arch/arm/mach-shmobile/setup-r8a7790.c         | 10 +++++-----
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 6e99eb2..25e0485 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -17,6 +17,11 @@
 	model = "Lager";
 	compatible = "renesas,lager", "renesas,r8a7790";
 
+	aliases {
+		serial6 = &scif0;
+		serial7 = &scif1;
+	};
+
 	chosen {
 		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
 	};
@@ -112,7 +117,7 @@
 };
 
 &pfc {
-	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
+	pinctrl-0 = <&du_pins>;
 	pinctrl-names = "default";
 
 	du_pins: du {
@@ -221,6 +226,20 @@
 	};
 };
 
+&scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 1bca2748..749832e 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -91,16 +91,6 @@ static void __init lager_add_du_device(void)
  */
 static const struct clk_name clk_names[] __initconst = {
 	{ "cmt0", "fck", "sh-cmt-48-gen2.0" },
-	{ "scifa0", NULL, "sh-sci.0" },
-	{ "scifa1", NULL, "sh-sci.1" },
-	{ "scifb0", NULL, "sh-sci.2" },
-	{ "scifb1", NULL, "sh-sci.3" },
-	{ "scifb2", NULL, "sh-sci.4" },
-	{ "scifa2", NULL, "sh-sci.5" },
-	{ "scif0", NULL, "sh-sci.6" },
-	{ "scif1", NULL, "sh-sci.7" },
-	{ "hscif0", NULL, "sh-sci.8" },
-	{ "hscif1", NULL, "sh-sci.9" },
 	{ "du0", "du.0", "rcar-du-r8a7790" },
 	{ "du1", "du.1", "rcar-du-r8a7790" },
 	{ "du2", "du.2", "rcar-du-r8a7790" },
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 87327f3..5fc9b17 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -287,6 +287,11 @@ static struct resource cmt0_resources[] = {
 
 void __init r8a7790_add_dt_devices(void)
 {
+	r8a7790_register_cmt(0);
+}
+
+void __init r8a7790_add_standard_devices(void)
+{
 	r8a7790_register_scif(0);
 	r8a7790_register_scif(1);
 	r8a7790_register_scif(2);
@@ -297,11 +302,6 @@ void __init r8a7790_add_dt_devices(void)
 	r8a7790_register_scif(7);
 	r8a7790_register_scif(8);
 	r8a7790_register_scif(9);
-	r8a7790_register_cmt(0);
-}
-
-void __init r8a7790_add_standard_devices(void)
-{
 	r8a7790_add_dt_devices();
 	r8a7790_register_irqc(0);
 	r8a7790_register_thermal();
-- 
1.8.5.2

