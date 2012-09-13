From: Simon Horman <horms@verge.net.au>
Date: Thu, 13 Sep 2012 06:17:50 +0000
Subject: [GIT PULL] Renesas ARM-based SoC: Boards for 3.7 #2
Message-Id: <1347517071-30647-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1346897074-6276-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1346897074-6276-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following board enhancement from
Iwamatsu-san for inclusion in 3.7.

----------------------------------------------------------------
The following changes since commit eb8ca943bae2b84c3fc14dfd7a908cb334465fef:

  ARM: shmobile: marzen: enable thermal sensor (2012-09-06 10:24:17 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git boards

for you to fetch changes up to b22f6bb030ee0c98839fe2445571c57c9f89594e:

  ARM: shmobile: armadillo800eva: Add support RTC (2012-09-13 15:02:25 +0900)

----------------------------------------------------------------
Nobuhiro Iwamatsu (1):
      ARM: shmobile: armadillo800eva: Add support RTC

 arch/arm/configs/armadillo800eva_defconfig     |    3 +++
 arch/arm/mach-shmobile/board-armadillo800eva.c |   25 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
