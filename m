From: Rich Felker <dalias@libc.org>
Date: Fri, 08 Jan 2016 04:40:54 +0000
Subject: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <20160108044054.GA7130@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <20160108043907.GA7005@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uClinux.org>, Rob Landley <rob@landley.net>

From: Rich Felker <dalias@libc.org>

Recently the bulk of traffic on the linux-sh list has been unrelated
to arch/sh but instead focused on Renesas hardware for their ARM-based
SoCs. As part of resuming maintenance of arch/sh, remove the linux-sh
list from the MAINTAINERS file sections for these other components so
that new arch/sh development is not drowned out by unrelated
cross-postings.

Signed-off-by: Rich Felker <dalias@libc.org>
Acked-by: D. Jeff Dionne <jeff@uClinux.org>
Acked-by: Rob Landley <rob@landley.net>

---

diff --git a/MAINTAINERS b/MAINTAINERS
index 9bff63c..8f5f953 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1516,9 +1516,7 @@ F:	drivers/media/platform/s5p-jpeg/
 ARM/SHMOBILE ARM ARCHITECTURE
 M:	Simon Horman <horms@verge.net.au>
 M:	Magnus Damm <magnus.damm@gmail.com>
-L:	linux-sh@vger.kernel.org
 W:	http://oss.renesas.com
-Q:	http://patchwork.kernel.org/project/linux-sh/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
 S:	Supported
 F:	arch/arm/boot/dts/emev2*
@@ -3721,7 +3719,6 @@ F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
 DRM DRIVERS FOR RENESAS
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	dri-devel@lists.freedesktop.org
-L:	linux-sh@vger.kernel.org
 T:	git git://people.freedesktop.org/~airlied/linux
 S:	Supported
 F:	drivers/gpu/drm/rcar-du/
@@ -6829,7 +6826,6 @@ F:	drivers/iio/potentiometer/mcp4531.c
 MEDIA DRIVERS FOR RENESAS - VSP1
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	linux-media@vger.kernel.org
-L:	linux-sh@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
 S:	Supported
 F:	Documentation/devicetree/bindings/media/renesas,vsp1.txt
@@ -8192,7 +8188,6 @@ F:	drivers/pci/host/pci-dra7xx.c
 PCI DRIVER FOR RENESAS R-CAR
 M:	Simon Horman <horms@verge.net.au>
 L:	linux-pci@vger.kernel.org
-L:	linux-sh@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*rcar*
 
@@ -8369,7 +8364,6 @@ F:	drivers/pinctrl/intel/
 
 PIN CONTROLLER - RENESAS
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
-L:	linux-sh@vger.kernel.org
 S:	Maintained
 F:	drivers/pinctrl/sh-pfc/
 
