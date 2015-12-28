From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 28 Dec 2015 10:41:22 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a7793: gose: HDMI prototype
Message-Id: <9025713.1MtsRGHuE3@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20151217063328.27906.61335.sendpatchset@little-apple>
In-Reply-To: <20151217063328.27906.61335.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Monday 28 December 2015 12:20:36 Magnus Damm wrote:
> On Mon, Dec 28, 2015 at 2:42 AM, Laurent Pinchart wrote:
> > On Thursday 17 December 2015 15:33:28 Magnus Damm wrote:
> >> From: Magnus Damm <damm+renesas@opensource.se>
> >> 
> >> This prototype V2 patch adds r8a7793 GOSE HDMI video out support.
> >> 
> >> The r8a7793 GOSE board is similar to r8a7791 Koelsch. For those
> >> boards an on-board HDMI encoder chip drives an HDMI port and
> >> also a LVDS port is available for external LCD panels.
> >> 
> >> Basic testing with modetest seems to work well. The current state of
> >> r8a7793 SoC support is improving, however I2C support is still missing.
> >> 
> >> To check if the DU and HDMI drivers and hardware are working this
> >> patch simply ties together I2C2 and GPIO3 with the DU and HDMI
> >> devices. Once I2C is enabled in upstream for r8a7793 and GOSE then
> >> this patch can easily be reworked into something suitable for upstream.
> > 
> > Why don't you just split this patch to enable I2C and GPIO on r8a7793 ?
> 
> I broke out GPIO after doing V1 and posted that separately. It has now
> been merged.
> 
> Regarding I2C, I would prefer if someone else could do that.

Done :-)

> >> Tested on r8a7793 Gose with HDMI hooked up to a Toshiba TV.
> >> # modetest -M rcar-du -s 33:1280x720@AR24
> >> 
> >> Not-yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> >> ---
> >> 
> >>  Built on top of "renesas-devel-20151217v2-v4.4-rc5"
> >>  
> >>  arch/arm/boot/dts/r8a7793-gose.dts |   98 ++++++++++++++++++++++++++++++
> >>  arch/arm/boot/dts/r8a7793.dtsi     |   18 +++++-
> >>  2 files changed, 113 insertions(+), 3 deletions(-)
> >> 
> >> --- 0001/arch/arm/boot/dts/r8a7793-gose.dts
> >> +++ work/arch/arm/boot/dts/r8a7793-gose.dts   2015-12-17
> >> 11:48:47.880513000
> >> +0900 @@ -31,6 +31,54 @@
> >>               device_type = "memory";
> >>               reg = <0 0x40000000 0 0x40000000>;
> >>       };
> >> +
> >> +     hdmi-out {
> >> +             compatible = "hdmi-connector";
> >> +             type = "a";
> >> +
> >> +             port {
> >> +                     hdmi_con: endpoint {
> >> +                             remote-endpoint = <&adv7511_out>;
> >> +                     };
> >> +             };
> >> +     };
> >> +
> >> +     x2_clk: x2-clock {
> >> +             compatible = "fixed-clock";
> >> +             #clock-cells = <0>;
> >> +             clock-frequency = <74250000>;
> >> +     };
> >> +
> >> +     x13_clk: x13-clock {
> >> +             compatible = "fixed-clock";
> >> +             #clock-cells = <0>;
> >> +             clock-frequency = <148500000>;
> >> +     };
> >> +};
> >> +
> >> +&du {
> >> +     pinctrl-0 = <&du_pins>;
> >> +     pinctrl-names = "default";
> >> +     status = "okay";
> >> +
> >> +     clocks = <&mstp7_clks R8A7793_CLK_DU0>,
> >> +              <&mstp7_clks R8A7793_CLK_DU1>,
> >> +              <&mstp7_clks R8A7793_CLK_LVDS0>,
> >> +              <&x13_clk>, <&x2_clk>;
> >> +     clock-names = "du.0", "du.1", "lvds.0",
> >> +                   "dclkin.0", "dclkin.1";
> >> +
> >> +     ports {
> >> +             port@0 {
> >> +                     endpoint {
> >> +                             remote-endpoint = <&adv7511_in>;
> >> +                     };
> >> +             };
> >> +             port@1 {
> >> +                     lvds_connector: endpoint {
> >> +                     };
> >> +             };
> >> +     };
> >>  };
> >>  
> >>  &extal_clk {
> >> @@ -38,6 +86,16 @@
> >>  };
> >>  
> >>  &pfc {
> >> +     i2c2_pins: i2c2 {
> >> +             renesas,groups = "i2c2";
> >> +             renesas,function = "i2c2";
> >> +     };
> >> +
> >> +     du_pins: du {
> >> +             renesas,groups = "du_rgb666", "du_sync", "du_disp",
> >> "du_clk_out_0";
> >
> > How about taking the comments I've made about v1 into account ?
> 
> I must have missed those, sorry. Will do when when I post v3 - once
> someone has added I2C support.

Thanks.

-- 
Regards,

Laurent Pinchart

