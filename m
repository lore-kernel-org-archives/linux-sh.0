From: Simon Horman <horms@verge.net.au>
Date: Mon, 09 Feb 2015 05:27:08 +0000
Subject: Re: [PATCH 12/12] ARM: shmobile: koelsch: Add DU HDMI output support
Message-Id: <20150209052707.GA16111@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2760366.et6DDZxN2B@avalon>
 <20150206005842.GA10620@verge.net.au>
 <1659503.1z5khf1Cxm@avalon>
In-Reply-To: <1659503.1z5khf1Cxm@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, Damian Hobson-Garcia <dhobsong@igel.co.jp>, Magnus Damm <magnus.damm@gmail.com>

On Sun, Feb 08, 2015 at 06:08:19PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Friday 06 February 2015 09:58:43 Simon Horman wrote:
> > [CC Damian, Magnus]
> > 
> > On Mon, Oct 27, 2014 at 02:12:56PM +0200, Laurent Pinchart wrote:
> > > On Monday 27 October 2014 09:38:29 Simon Horman wrote:
> > > > On Wed, Sep 24, 2014 at 11:04:32PM +0300, Laurent Pinchart wrote:
> > > >> Add DT nodes for the ADV7511 HDMI encoder and its HDMI output
> > > >> connector and configure the DISP pin group that drives the HDMI
> > > >> transmitter DE pin.
> > > >> 
> > > >> Signed-off-by: Laurent Pinchart
> > > >> <laurent.pinchart+renesas@ideasonboard.com>
> > > > 
> > > > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> > > > 
> > > > Please be careful of any conflicts that may arise if this patch
> > > > doesn't go through my renesas tree.
> > > 
> > > I think it would be best if the patch went through your tree. There's no
> > > compile time or runtime dependency on the DU HDMI code, so as soon as the
> > > ADV7511 DT bindings get accepted I plan to ask you to merge this patch.
> > 
> > Hi Laurent,
> > 
> > I'd like to enquire about the status of this change as
> > Damian has asked me about it.
> > 
> > It seems that I could pick this up for v3.21 as the bindings seem to be in
> > v3.19-rc1. But perhaps events have overtaken the discussion above which was
> > some months ago now.
> 
> For Koelsch everything should be fine, you can pick the patch for v3.21.
> 
> For Lager, there's an additional dependency on "drm: rcar-du: Don't fail probe 
> in case of partial encoder init error" (to avoid regressions) and on "drm: 
> rcar-du: Remove LVDS and HDMI encoders chaining restriction" (to make it work 
> at all). Both are in Dave's drm-next branch and should land in v3.20-rc1. To 
> avoid bisection breakages we would have to merge Dave's branch first.

Thanks, I have queued up the version of this patch which you posted
in December:

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

[PATCH] ARM: shmobile: koelsch: Add DU HDMI output support

Add DT nodes for the ADV7511 HDMI encoder and its HDMI output connector
and configure the DISP pin group that drives the HDMI transmitter DE
pin.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 50 ++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 691e4c6..d2ea19f 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -258,6 +258,17 @@
 			system-clock-frequency = <11289600>;
 		};
 	};
+
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&adv7511_out>;
+			};
+		};
+	};
 };
 
 &du {
@@ -266,6 +277,11 @@
 	status = "okay";
 
 	ports {
+		port@0 {
+			endpoint {
+				remote-endpoint = <&adv7511_in>;
+			};
+		};
 		port@1 {
 			lvds_connector: endpoint {
 			};
@@ -284,7 +300,7 @@
 	};
 
 	du_pins: du {
-		renesas,groups = "du_rgb666", "du_sync", "du_clk_out_0";
+		renesas,groups = "du_rgb666", "du_sync", "du_disp", "du_clk_out_0";
 		renesas,function = "du";
 	};
 
@@ -506,6 +522,38 @@
 		};
 	};
 
+	hdmi@39 {
+		compatible = "adi,adv7511w";
+		reg = <0x39>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+
+		adi,input-depth = <8>;
+		adi,input-colorspace = "rgb";
+		adi,input-clock = "1x";
+		adi,input-style = <1>;
+		adi,input-justification = "evenly";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				adv7511_in: endpoint {
+					remote-endpoint = <&du_out_rgb>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				adv7511_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+
 	eeprom@50 {
 		compatible = "renesas,24c02";
 		reg = <0x50>;
-- 
2.1.4

