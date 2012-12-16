From: Bastian Hecht <hechtb@gmail.com>
Date: Sun, 16 Dec 2012 13:54:24 +0000
Subject: [PATCH 0/2] Preliminary Armadillo DT support
Message-Id: <1355666066-25649-1-git-send-email-hechtb+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is a minimal setup for DT booting Armadillo boards. It's based on Simon
Horman's reference implementation for the kz9mg board.

The only device added so far is the ethernet controller sh_eth. For this the
driver is enhanced to support DT-based probing in the 2nd patch.

Care should be taken as the lines
-       /* armadillo 800 eva extal1 is 24MHz */
-       clk_set_rate(xtal1, 24000000);
are removed and the r8a7740 code uses 25MHz by default. I'm unsure if just some clock
calculations get incorrect or if we overclock our board somewhere.

The patches are based on git://git.kernel.org/pub/scm/linux/kernel/git/horms/devel/of
revision 9fcbfcfd31c782840ebb57f283c174c749467434.

Bastian Hecht (2):
  ARM: shmobile: Armadillo800eva: DT boot testcase with ethernet
    support
  net: sh_eth: Add Device Tree support

 arch/arm/boot/dts/r8a7740-armadillo800eva.dts  |    7 +
 arch/arm/mach-shmobile/board-armadillo800eva.c | 1167 +-----------------------
 arch/arm/mach-shmobile/clock-r8a7740.c         |    1 +
 arch/arm/mach-shmobile/include/mach/common.h   |    2 +
 drivers/net/ethernet/renesas/sh_eth.c          |   72 +-
 5 files changed, 86 insertions(+), 1163 deletions(-)

-- 
1.7.9.5

