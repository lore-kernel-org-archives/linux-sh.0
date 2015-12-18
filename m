From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Dec 2015 02:11:42 +0000
Subject: [PATCH 0/3] ARM: shmobile: r8a779x: use fallback usbhs compatibility string
Message-Id: <1450404705-5449-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

this short series makes use of the recently added fallback usbhs
compatibility string in the r8a779[014] device trees.

Based on renesas-devel-20151218-v4.4-rc5.

Simon Horman (3):
  ARM: shmobile: r8a7790: use fallback usbhs compatibility string
  ARM: shmobile: r8a7791: use fallback usbhs compatibility string
  ARM: shmobile: r8a7794: use fallback usbhs compatibility string

 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 arch/arm/boot/dts/r8a7794.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.1.4

