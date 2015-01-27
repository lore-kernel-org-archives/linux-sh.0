From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Jan 2015 09:13:22 +0000
Subject: [PATCH 0/3] Renesas IPMMU DT nodes for R-Car H2, M2 and E2
Message-Id: <1422350005-20573-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set adds DT nodes for the IPMMU instances found in the R-Car H2, M2
and E2 SoCs. The nodes are currently all disabled until the first users show
up.

The IPMMU DT bindings have been applied to the IOMMU tree and are scheduled to
hit mainline in v3.20-rc1. This set depends on the DT bindings but has no
compile-time or runtime dependency on any of the queued IPMMU patches.

Laurent Pinchart (3):
  ARM: shmobile: r8a7790: Add IPMMU DT nodes
  ARM: shmobile: r8a7791: Add IPMMU DT nodes
  ARM: shmobile: r8a7794: Add IPMMU DT nodes

 arch/arm/boot/dts/r8a7790.dtsi | 51 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7794.dtsi | 50 +++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+)

-- 
Regards,

Laurent Pinchart

