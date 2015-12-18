From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Dec 2015 02:42:36 +0000
Subject: [PATCH 0/3] ARM: shmobile: r8a779x: use fallback pcie compatibility string
Message-Id: <1450406559-9076-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1450404705-5449-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1450404705-5449-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

this short series makes use of the recently added fallback pci
compatibility string in the r8a779[014] device trees.

Based on renesas-devel-20151218-v4.4-rc5.

Simon Horman (3):
  ARM: shmobile: r8a7790: use fallback pci compatibility string
  ARM: shmobile: r8a7791: use fallback pci compatibility string
  ARM: shmobile: r8a7794: use fallback pci compatibility string

 arch/arm/boot/dts/r8a7790.dtsi | 6 +++---
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 arch/arm/boot/dts/r8a7794.dtsi | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.1.4

