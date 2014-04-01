From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 01 Apr 2014 11:02:14 +0000
Subject: [PATCH 0/4] r8a779[01] I2C clocks fixes
Message-Id: <1396350138-26850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

The I2C clocks select an incorrect parent on r8a7790 and r8a7791, both in the
legacy C code and in DT. This patch set fixes that.

Laurent Pinchart (4):
  ARM: shmobile: r8a7790: Fix the I2C clocks parents in legacy code
  ARM: shmobile: r8a7791: Fix the I2C clocks parents in legacy code
  ARM: shmobile: r8a7790: Fix the I2C clocks parents in DT
  ARM: shmobile: r8a7791: Fix the I2C clocks parents in DT

 arch/arm/boot/dts/r8a7790.dtsi         |  2 +-
 arch/arm/boot/dts/r8a7791.dtsi         |  6 +++---
 arch/arm/mach-shmobile/clock-r8a7790.c |  8 ++++----
 arch/arm/mach-shmobile/clock-r8a7791.c | 12 ++++++------
 4 files changed, 14 insertions(+), 14 deletions(-)

-- 
Regards,

Laurent Pinchart

