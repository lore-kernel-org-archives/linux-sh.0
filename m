From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 02 Jun 2015 01:34:35 +0000
Subject: [PATCH 0/2] ARM: Enable r8a7793/gose in defconfigs
Message-Id: <1433208877-3284-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

this small series enables the r8a7793/gose in both
multi_v7_defconfig and shmobile_defconfig.

Based on the defconfig-for-v4.3 branch of my renesas tree,
which is in turn based on v4.1-rc1.

Simon Horman (2):
  ARM: shmobile: Enable gose board in multiplatform defconfig
  ARM: multi_v7_defconfig: Enable shmobile r8a7793/gose platform

 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/shmobile_defconfig | 1 +
 2 files changed, 2 insertions(+)

-- 
2.1.4

