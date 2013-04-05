From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 05 Apr 2013 02:57:47 +0000
Subject: [GIT PULL] Renesas ARM r8a7779 SoC update for v3.10
Message-Id: <1365130669-11662-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit 8585deb18580d04209a2986430aa0959ef38fce2:

  ARM: shmobile: r8a7790 SoC 64-bit DT support (2013-04-02 11:02:21 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas tags/renesas-soc-r8a7779-for-v3.10

for you to fetch changes up to dace48d04dee46a3409d5e13cd98031522e46377:

  ARM: shmobile: R8A7779: add Ether support (2013-04-05 10:47:03 +0900)

----------------------------------------------------------------
Renesas ARM r8a7779 SoC update for v3.10

Update to the r8a7779 SoC:
* Add SH Ethernet support
* Add comment describing clock ratios

This pull request is based on:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas renesas-soc2-for-v3.10

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: r8a7779: add each clocks ratio on comment area

Sergei Shtylyov (1):
      ARM: shmobile: R8A7779: add Ether support

 arch/arm/mach-shmobile/clock-r8a7779.c        |   23 ++++++++++++++++++++++-
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 ++
 arch/arm/mach-shmobile/setup-r8a7779.c        |   23 ++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 2 deletions(-)
