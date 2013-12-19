From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 19 Dec 2013 15:51:00 +0000
Subject: [PATCH 0/6] ARM: shmobile: r8a779x: Add more clocks to DT
Message-Id: <1387468266-13625-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set adds the MSIOF, QSPI and SSI clocks to DT for the r8a7790 and
r8a7791 SoCs.

Laurent Pinchart (6):
  ARM: shmobile: r8a7790: Add MSIOF clocks in device tree
  ARM: shmobile: r8a7791: Add MSIOF clocks in device tree
  ARM: shmobile: r8a7790: Add QSPI module clock in device tree
  ARM: shmobile: r8a7791: Add QSPI module clock in device tree
  ARM: shmobile: r8a7790: Add SSI clocks in device tree
  ARM: shmobile: r8a7791: Add SSI clocks in device tree

 arch/arm/boot/dts/r8a7790.dtsi            | 48 +++++++++++++++++++++++-----
 arch/arm/boot/dts/r8a7791.dtsi            | 52 ++++++++++++++++++++++++-------
 include/dt-bindings/clock/r8a7790-clock.h | 20 ++++++++++++
 include/dt-bindings/clock/r8a7791-clock.h | 19 +++++++++++
 4 files changed, 120 insertions(+), 19 deletions(-)

-- 
Regards,

Laurent Pinchart

