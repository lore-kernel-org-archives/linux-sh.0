From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 17 Dec 2015 07:21:31 +0000
Subject: [PATCH 0/4] Enable DU on Salvator-X board
Message-Id: <1450336895-4279-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch series enables support for DU on the Salvator-X board. Only the VGA
output is supported for now.

The patches are pretty straightforward but depend on two large patch series
(plus the oddball patches) for the VSP1 and DU drivers.

On the VSP1 side the series has been posted to the linux-media and linux-sh
mailing lists under the subject "[PATCH v2 00/32] VSP: Add R-Car Gen3
support". A pull request for v4.5 has been submitted. An additional patch
named "[RFC/PATCH] v4l: vsp1: Configure device based on IP version" is also
needed. It has posted to the same mailing lists but has not been included in
the pull request.

On the DU side the series has been posted to the dri-devel and linux-sh
mailing lists under the subject "[PATCH 00/22] R-Car DU: Add Gen3 support".
As the series depends on the VSP1 series integration is a bit tricky and the
pull request will be submitted for v4.6.

The code has been tested on Salvator-X (quite obviously), and the changes have
also been tested on Lager and Koelsch to try and prevent regressions. You can
find the code with all its dependencies (including R-Car H3 CCF support) at

	git://linuxtv.org/pinchartl/media.git drm/du/vsp1-kms/boards

Please note that the branch is a working branch and is thus frequently rebased
with the latest code. You can alternatively use the vsp1-kms-20151217 tag
which corresponds to the above branch as of today.

Laurent Pinchart (4):
  clk: shmobile: r8a7795: Add LVDS module clock
  ARM64: renesas: r8a7795: Add VSP instances
  ARM64: renesas: r8a7795: Add DU device to DT
  ARM64: renesas: salvator-x: Enable DU

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  44 ++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 160 +++++++++++++++++++++
 drivers/clk/shmobile/r8a7795-cpg-mssr.c            |   1 +
 3 files changed, 205 insertions(+)

-- 
Regards,

Laurent Pinchart

