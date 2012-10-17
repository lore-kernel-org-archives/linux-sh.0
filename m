From: Simon Horman <horms@verge.net.au>
Date: Wed, 17 Oct 2012 04:38:16 +0000
Subject: [GIT PULL] Renesas ARM-based SoC defconfig for v3.8
Message-Id: <1350448698-26985-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following defconfig enhancements for 3.8.

----------------------------------------------------------------
The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git defconfig

for you to fetch changes up to 9a32fd6529e90d1dde157d155ae8e3fca61c31f7:

  ARM: shmobile: armadillo800eva: enable L2X0 cache on defconfig (2012-10-15 10:23:59 +0900)

----------------------------------------------------------------
Kuninori Morimoto (2):
      ARM: shmobile: mackerel: defconfig update
      ARM: shmobile: armadillo800eva: enable L2X0 cache on defconfig

 arch/arm/configs/armadillo800eva_defconfig |    2 +-
 arch/arm/configs/mackerel_defconfig        |   18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)
