From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 10 Nov 2013 14:49:52 +0000
Subject: [PATCH v2 0/2] ARM: shmobile: Lager reference serial port support
Message-Id: <1384094994-5115-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

This patch set implements serial port support for the Lager reference board.

The code is available in my git tree at

        git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/serial-lager

The patches are based on top of the "[PATCH v2 00/29] Add OF support to the
sh-sci serial port driver" patch series posted yesterday.

Compared to v1 I've removed early debugging support as it requires more work
before being mainlined.

Laurent Pinchart (2):
  ARM: shmobile: r8a7790: Add serial ports to the device tree
  ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT

 arch/arm/boot/dts/r8a7790-lager.dts            |  24 +++++-
 arch/arm/boot/dts/r8a7790.dtsi                 | 100 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-lager-reference.c |  18 +----
 arch/arm/mach-shmobile/clock-r8a7790.c         |  16 ++--
 arch/arm/mach-shmobile/setup-r8a7790.c         |  26 +++----
 5 files changed, 143 insertions(+), 41 deletions(-)

-- 
Regards,

Laurent Pinchart

