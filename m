From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 09 Nov 2015 01:33:17 +0000
Subject: [PATCH 0/2]  ARM: shmobile: r8a7793: Add PFC to DT
Message-Id: <1447032799-13155-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This short series adds PFC support to the r8a7793 and its gose board.

The PFC driver is already present and is the same driver as the r8a7791.

Simon Horman (2):
  ARM: shmobile: r8a7793: Add PFC to DT
  ARM: shmobile: gose: Configure PFC in DT

 arch/arm/boot/dts/r8a7793-gose.dts | 31 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7793.dtsi     |  6 ++++++
 2 files changed, 37 insertions(+)

-- 
2.1.4

