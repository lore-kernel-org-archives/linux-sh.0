From: Simon Horman <horms@verge.net.au>
Date: Wed, 14 May 2014 05:15:04 +0000
Subject: Re: [RFC/PATCH 6/6] ARM: shmobile: koelsch: Enable SCIF0 and SCIF1 serial ports in DT
Message-Id: <20140514051503.GF18495@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1398817906-6023-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398817906-6023-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 30, 2014 at 06:28:55PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 30 April 2014 15:24:03 Simon Horman wrote:
> > On Wed, Apr 30, 2014 at 04:55:22AM +0000, Magnus Damm wrote:
> > > On Wed, Apr 30, 2014 at 12:31 AM, Laurent Pinchart wrote:
> > > > SCIF0 and SCIF1 are used as debug serial ports. Enable them and
> > > > configure pinmuxing appropriately. We can now remove the clkdev
> > > > registration hack for SCIF devices from the Koelsch reference board
> > > > file.
> > > > 
> > > > As a side effect of switching to DT-based serial port instantiation,
> > > > ttySC6 and ttySC7 get renamed to ttySC0 and ttySC1. As the device tree
> > > > source if now shared between koelsch and koelsch-reference, we need to
> > > > update the serial ports in C code as well.
> > > 
> > > Hi Laurent,
> > > 
> > > Thanks for your efforts. I'm a bit confused, because I thought we
> > > agreed on keeping the serial order intact earlier?
> > > 
> > > With that in mind, shouldn't aliases be updated in this patch to avoid
> > > rename of ttySC6 and 7?
> > 
> > Given that the patch for the lager contains the aliases required
> > to avoid the rename I believe that this is an oversight.
> 
> It was indeed.
> 
> > For the record I have things working with the following incremental patch.
> 
> I've squashed that change into the original patch in my tree.
> 
> > diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts
> > b/arch/arm/boot/dts/r8a7791-koelsch.dts index 99a4452..05d44f9 100644
> > --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> > +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> > @@ -19,6 +19,11 @@
> >  	model = "Koelsch";
> >  	compatible = "renesas,koelsch", "renesas,r8a7791";
> > 
> > +	aliases {
> > +		serial6 = &scif0;
> > +		serial7 = &scif1;
> > +	};
> > +
> >  	chosen {
> >  		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs
> > ip=dhcp"; };

As discussed privately I have queued up the following.

I have also queued up a modified version of the similar patch
you posted for the lager board as part of this series.

I have not queued up any of the other patches in this series.


From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

[PATCH] ARM: shmobile: koelsch: Enable SCIF0 and SCIF1 serial ports in DT

SCIF0 and SCIF1 are used as debug serial ports. Enable them and
configure pinmuxing appropriately. We can now remove the clkdev
registration hack for SCIF devices from the Koelsch reference board
file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[horms+renesas@verge.net.au: added aliases to avoid device renumbering]
[horms+renesas@verge.net.au: resolved conflicts]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts            | 21 ++++++++++++++++++++-
 arch/arm/mach-shmobile/board-koelsch-reference.c | 15 ---------------
 arch/arm/mach-shmobile/setup-r8a7791.c           | 10 +++++-----
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index bdd73e6..10c6b40 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -18,6 +18,11 @@
 	model = "Koelsch";
 	compatible = "renesas,koelsch", "renesas,r8a7791";
 
+	aliases {
+		serial6 = &scif0;
+		serial7 = &scif1;
+	};
+
 	chosen {
 		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
 	};
@@ -196,7 +201,7 @@
 };
 
 &pfc {
-	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
+	pinctrl-0 = <&du_pins>;
 	pinctrl-names = "default";
 
 	i2c2_pins: i2c {
@@ -269,6 +274,20 @@
 	status = "okay";
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
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index bd90932..0b0ce5a 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -87,21 +87,6 @@ static void __init koelsch_add_du_device(void)
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
-	{ "scif2", NULL, "sh-sci.8" },
-	{ "scif3", NULL, "sh-sci.9" },
-	{ "scif4", NULL, "sh-sci.10" },
-	{ "scif5", NULL, "sh-sci.11" },
-	{ "scifa3", NULL, "sh-sci.12" },
-	{ "scifa4", NULL, "sh-sci.13" },
-	{ "scifa5", NULL, "sh-sci.14" },
 	{ "du0", "du.0", "rcar-du-r8a7791" },
 	{ "du1", "du.1", "rcar-du-r8a7791" },
 	{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 561653d..b3f42b5 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -182,6 +182,11 @@ static const struct resource thermal_resources[] __initconst = {
 
 void __init r8a7791_add_dt_devices(void)
 {
+	r8a7791_register_cmt(0);
+}
+
+void __init r8a7791_add_standard_devices(void)
+{
 	r8a7791_register_scif(0);
 	r8a7791_register_scif(1);
 	r8a7791_register_scif(2);
@@ -197,11 +202,6 @@ void __init r8a7791_add_dt_devices(void)
 	r8a7791_register_scif(12);
 	r8a7791_register_scif(13);
 	r8a7791_register_scif(14);
-	r8a7791_register_cmt(0);
-}
-
-void __init r8a7791_add_standard_devices(void)
-{
 	r8a7791_add_dt_devices();
 	r8a7791_register_irqc(0);
 	r8a7791_register_thermal();
-- 
1.8.5.2

