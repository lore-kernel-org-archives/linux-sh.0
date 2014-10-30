From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 30 Oct 2014 05:58:53 +0000
Subject: [PATCH 0/3] ARM: shmobile: r8a7794: Add VIN, SGX, MMP and VSP1 to device tree
Message-Id: <1414648736-31412-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

this short series adds VIN, SGX, MMP and VSP1 clocks to device
tree for the r8a7794 SoC

Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree

Compile tested only


Koji Matsuoka (1):
  ARM: shmobile: r8a7794: Add VIN clock to device tree

Kouei Abe (1):
  ARM: shmobile: r8a7794: Add SGX clock to device tree

Yoshifumi Hosoya (1):
  ARM: shmobile: r8a7794: Add MMP and VSP1 clocks to device tree

 arch/arm/boot/dts/r8a7794.dtsi            | 21 ++++++++++++---------
 include/dt-bindings/clock/r8a7794-clock.h |  9 +++++++++
 2 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.1.1

