From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 29 May 2015 00:53:56 +0000
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Defconfig Updates for v4.2
Message-Id: <cover.1432860785.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1381222967.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1381222967.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC defconfig updates for v4.2.

This pull request is based on the previous round of
such requests, tagged as renesas-defconfig-for-v4.2,
which I have already sent a pull-request for.


The following changes since commit 90037558d5ed25a63499c3973cc1af25da02f673:

  ARM: shmobile: defconfig: Replace USB_RCAR_GEN2_PHY by PHY_RCAR_GEN2 (2015-05-01 21:25:43 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig2-for-v4.2

for you to fetch changes up to f2a5cefbbb2c69253a8a8aa7f7f77b22f0595811:

  ARM: multi_v7_defconfig: Enable shmobile r8a7778/bockw platform (2015-05-25 10:10:48 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Defconfig Updates for v4.2

* Enable shmobile r8a7778/bockw platform

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: multi_v7_defconfig: Enable shmobile r8a7778/bockw platform

 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)
