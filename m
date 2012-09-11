From: Simon Horman <horms@verge.net.au>
Date: Tue, 11 Sep 2012 08:05:25 +0000
Subject: [GIT] Renesas ARM-based SoC: pmu/cleanup for 3.7
Message-Id: <1347350727-11962-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Will,

please consider the following changes from Kobayashi-san
for the pmu/cleanup branch.

----------------------------------------------------------------
The following changes since commit 051f1b13144dd8553d5a5104dde94c7263ae3ba7:

  ARM: perf: move irq registration into pmu implementation (2012-08-23 11:35:52 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git pmu/cleanup

for you to fetch changes up to e433d4440bf7dd5955a4616cfb9bffd1ec6ab839:

  ARM: shmobile: emev2: enable PMU(Performance Monitoring Unit) (2012-09-11 16:27:41 +0900)

----------------------------------------------------------------
Tetsuyuki Kobayashi (2):
      ARM: shmobile: sh73a0: enable PMU(Performance Monitoring Unit)
      ARM: shmobile: emev2: enable PMU(Performance Monitoring Unit)

 arch/arm/configs/kzm9d_defconfig      |    1 +
 arch/arm/configs/kzm9g_defconfig      |    1 +
 arch/arm/mach-shmobile/setup-emev2.c  |   21 +++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c |   21 +++++++++++++++++++++
 4 files changed, 44 insertions(+)
