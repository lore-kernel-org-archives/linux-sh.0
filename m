From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 07 Jan 2014 08:22:52 +0000
Subject: [PATCH 0/4] r8a779[01]: Add new clocks to the device tree
Message-Id: <1389082976-22254-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

These four patches add the VIN and SATA clocks to the device tree. Not much
else to be said, the changes should be safe and will be needed for VIN and
SATA DT support.

Laurent Pinchart (4):
  ARM: shmobile: r8a7790: Add VIN clocks to device tree
  ARM: shmobile: r8a7791: Add VIN clocks to device tree
  ARM: shmobile: r8a7790: Add SATA clocks to device tree
  ARM: shmobile: r8a7791: Add SATA clocks to device tree

 arch/arm/boot/dts/r8a7790.dtsi | 12 +++++++++---
 arch/arm/boot/dts/r8a7791.dtsi | 11 ++++++++---
 2 files changed, 17 insertions(+), 6 deletions(-)

-- 
Regards,

Laurent Pinchart

