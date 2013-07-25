From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 25 Jul 2013 22:50:58 +0000
Subject: [PATCH 0/2] ARM: shmobile: r8a7740: Add TPU support for DT platforms
Message-Id: <1374792660-15893-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set adds support for the TPU PWM generator to the r8a7740 DTS,
initially in the disabled state. Boards will enable the device as needed.

The code has been tested on an Armadillo800EVA board using the reference DT
implementation, with a board-specific DTS patch that I will submit next.

DT support for the TPU driver has been submitted separately to the linux-pwm
and linux-sh mailing lists and is required to use the TPU on DT platforms.
However, no compile-time dependency exist between the two series, they can
thus be merged independently.

Laurent Pinchart (2):
  ARM: shmobile: r8a7740: Add TPU clock entry for DT platforms
  ARM: shmobile: r8a7740: Add TPU node to the device tree

 arch/arm/boot/dts/r8a7740.dtsi         | 7 +++++++
 arch/arm/mach-shmobile/clock-r8a7740.c | 1 +
 2 files changed, 8 insertions(+)

-- 
Regards,

Laurent Pinchart

