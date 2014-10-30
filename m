From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 30 Oct 2014 05:57:55 +0000
Subject: [PATCH 0/2] ARM: shmobile: r8a7790: Fix SD3CKCR address
Message-Id: <1414648677-31104-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This short series corrects the SD3CKCR address in both C and DT

Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree

Shinobu Uehara (2):
  ARM: shmobile: r8a7790: Fix SD3CKCR address
  ARM: shmobile: r8a7790: Fix SD3CKCR address to device tree

 arch/arm/boot/dts/r8a7790.dtsi         | 4 ++--
 arch/arm/mach-shmobile/clock-r8a7790.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.1.1

