From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 08 Apr 2014 16:35:55 +0000
Subject: [PATCH 0/2] Add VSP1 devices to R8A779[01] DT
Message-Id: <1396974957-6046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch series adds VSP1 nodes to the R8A7790 and R8A7791 .dtsi files. It
is based on top of the "[PATCH 0/2] Fix VSP1 clock names in r8a779[01] .dtsi"
series that has been sent to the linux-sh mailing list, as well as the
"[PATCH] v4l: vsp1: Remove unexisting rt clocks" patch and "[PATCH 0/6] VSP1
Blend/ROP Unit and DT support" series sent to the linux-media mailing list.

The VSP1 DT bindings are still pending an ack, please don't apply this series
yet.

Laurent Pinchart (2):
  ARM: shmobile: r8a7790: Add VSP1 devices to DT
  ARM: shmobile: r8a7791: Add VSP1 devices to DT

 arch/arm/boot/dts/r8a7790.dtsi | 51 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi | 39 ++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

-- 
Regards,

Laurent Pinchart

