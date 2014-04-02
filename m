From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 02 Apr 2014 14:31:45 +0000
Subject: [PATCH 0/2] Fix VSP1 clock names in r8a779[01] .dtsi
Message-Id: <1396449107-4732-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

The VSP1 clocks were incorrectly named in the r8a7790 and r8a7791 .dtsi. This
patch set fixes the problem.

Laurent Pinchart (2):
  ARM: shmobile: r8a7790: Rename VSP1_(SY|RT) clocks to VSP1_(S|R)
  ARM: shmobile: r8a7791: Rename VSP1_SY clocks to VSP1_S

 arch/arm/boot/dts/r8a7790.dtsi            | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi            | 2 +-
 include/dt-bindings/clock/r8a7790-clock.h | 4 ++--
 include/dt-bindings/clock/r8a7791-clock.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
Regards,

Laurent Pinchart

