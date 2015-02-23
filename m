From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 23 Feb 2015 23:47:56 +0000
Subject: Re: Rcar-du Initialization errors on Koelsch
Message-Id: <2501755.ZY2tNT0lYX@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <54EAB5C0.5030304@jinso.co.jp>
In-Reply-To: <54EAB5C0.5030304@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Hiep-san,

On Monday 23 February 2015 14:08:16 Cao Minh Hiep wrote:
> Hi Laurent-san
> I am Hiep from Jinzai Solution.
> 
> We have tested the linux ver 3.19 on Koelsch, we found some error
> messages from Rcar-Du as show below:
> The error messages:
> "[drm] Initialized drm 1.1.0 20060810
>   rcar-du feb00000.display: Failed to initialize drm fb helper.
>   rcar-du feb00000.display: failed to initialize DRM/KMS
>   rcar-du: probe of feb00000.display failed with error -22"
> 
> Then, we find out these patches as below are causing of this bug:
> 0ee56d4 ARM: shmobile: koelsch: Enable DU device in DT
> 910343e ARM: shmobile: koelsch-reference: Remove DU platform device

This is due to the fact that no connector has been instantiated. The error 
message is pretty confusing, I'll submit a patch to make it clearer, but it 
won't fix the issue.

With the platform data based DU instantiation the Lager and Koelsch board file 
contained LVDS panel information, and the DU driver instantiated one LVDS 
connector. I wanted to replicate that when moving to DT, but the approach has 
been rejected during review due to the fact that the panel isn't part of the 
Lager and Koelsch boards, and thus shouldn't be described in r8a7790-lager.dts 
or r8a7791-koelsch.dts.

I've thus created a separate DT file (r8a77xx-aa104xd12-panel.dtsi) to 
describe the panel, which can be included directly in r8a7790-lager.dts or 
r8a7791-koelsch.dts as in the following patch.

Please note that the patch won't be upstreamed due to the reason explained 
above.

commit eca4ad5b98775c9a8cf5ee03598c3e5421f65030
Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date:   Fri Oct 24 14:53:13 2014 +0300

    ARM: shmobile: koelsch: Add panel to DT
    
    Signed-off-by: Laurent Pinchart 
<laurent.pinchart+renesas@ideasonboard.com>

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts 
b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 624bb2c30513..5119ed12fe63 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -648,3 +648,5 @@
 &ssi1 {
 	shared-pin;
 };
+
+#include "r8a77xx-aa104xd12-panel.dtsi"

-- 
Regards,

Laurent Pinchart

