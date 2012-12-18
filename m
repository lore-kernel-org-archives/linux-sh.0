From: Bastian Hecht <hechtb@gmail.com>
Date: Tue, 18 Dec 2012 17:22:37 +0000
Subject: [PATCH 0/2] Armadillo DT Reference Implementation
Message-Id: <1355851359-8871-1-git-send-email-hechtb+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This is the design approch of Simon Horman's kzm9g implementation transferred
to the Armadillo board.

It is based on the branch next of 
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
and was tested on the branch devel/of of
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

For the ethernet controller to work the series assumes the patch
net: sh_eth: Add support of device tree probe
http://patchwork.ozlabs.org/patch/191713/ to be applied.

Bastian Hecht (2):
  ARM: r8a7740: Add interim sh-eth device name to clocks list
  ARM: shmobile: armadillo800eva: Reference DT implementation

 arch/arm/boot/dts/Makefile                         |    1 +
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   33 ++++
 arch/arm/mach-shmobile/Kconfig                     |   10 ++
 arch/arm/mach-shmobile/Makefile                    |    1 +
 .../board-armadillo800eva-reference.c              |  172 ++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7740.c             |    1 +
 arch/arm/mach-shmobile/include/mach/common.h       |    2 +
 7 files changed, 220 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-armadillo800eva-reference.c

-- 
1.7.9.5

