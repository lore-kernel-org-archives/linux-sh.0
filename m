From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Dec 2015 02:36:01 +0000
Subject: [PATCH 0/2] ARM: shmobile: r8a779x: use fallback pcie compatibility string
Message-Id: <1450406163-23795-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

this short series makes use of the recently added fallback pcie
compatibility string in the r8a779[01] device trees.

Based on renesas-devel-20151218-v4.4-rc5.

Simon Horman (2):
  ARM: shmobile: r8a7790: use fallback pcie compatibility string
  ARM: shmobile: r8a7791: use fallback pcie compatibility string

 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.1.4

