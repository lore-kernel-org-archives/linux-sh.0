From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 28 May 2015 01:05:48 +0000
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.2
Message-Id: <cover.1432773909.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1397627619.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1397627619.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.2.

This small pull-request consists of a Kconfig fix from Arnd.
From my point of view does not seem severe enough to go through
a fixes channel.


The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.2

for you to fetch changes up to 66f72f0c8e0d37339b6be1373c61d2a133c8b422:

  ARM: shmobile: only select sound drivers that build (2015-05-25 10:36:01 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.2

* Only select sound drivers that build

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: shmobile: only select sound drivers that build

 arch/arm/mach-shmobile/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
