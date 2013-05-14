From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 14 May 2013 02:39:28 +0000
Subject: [PATCH v2 0/3]
Message-Id: <1368499171-22427-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

this short series enables the on-board ethernet
of the r8a7790 SoC for on lager board.

It is based on the renesas-next-20130513 tag of my renesas tree.

Dependencies noted in individual patches.

Simon Horman (3):
  ARM: shmobile: r8a7790: add Ether support
  ARM: shmobile: lager: enable Ether
  ARM: shmobile: lager: enable nfsroot in DTS

 arch/arm/boot/dts/r8a7790-lager.dts           |  2 +-
 arch/arm/mach-shmobile/board-lager.c          | 25 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c        |  4 ++++
 arch/arm/mach-shmobile/include/mach/r8a7790.h |  3 +++
 arch/arm/mach-shmobile/setup-r8a7790.c        | 15 +++++++++++++++
 5 files changed, 48 insertions(+), 1 deletion(-)

-- 
1.8.2.1

