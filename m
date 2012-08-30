From: Simon Horman <horms@verge.net.au>
Date: Thu, 30 Aug 2012 05:36:02 +0000
Subject: [GIT PULL v2] Renesas ARM-based SoC: Core for 3.7
Message-Id: <1346304963-23457-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following enhancement for the Renesas ARM-based SoC
Core from Kobayashi-san for inclusion in 3.7.

This replaces v1 of this pull request which included an
old and incorrect version of Kobayashi-san's patch.

----------------------------------------------------------------
The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc-core

for you to fetch changes up to c88a79a7789b2909ad1cf69ea2c9142030bbd6f4:

  ARM: mach-shmobile: Add compilation support for dtbs using 'make dtbs' (2012-08-30 14:21:54 +0900)

----------------------------------------------------------------
Tetsuyuki Kobayashi (1):
      ARM: mach-shmobile: Add compilation support for dtbs using 'make dtbs'

 arch/arm/mach-shmobile/Makefile.boot | 4 ++++
 1 file changed, 4 insertions(+)
