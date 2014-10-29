From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 29 Oct 2014 04:58:37 +0000
Subject: [GIT PULL] Renesas ARM Based SoC Kconfig Cleanups for v3.19
Message-Id: <cover.1414557793.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1409792454.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1409792454.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC kconfig cleanups for v3.19.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-kconfig-cleanups-for-v3.19

for you to fetch changes up to 383d3f3e979bfbace3101dacb21387806b44e847:

  ARM: shmobile: Remove ARCH_HAS_OPP completely (2014-10-24 10:41:56 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Kconfig Cleanups for v3.19

* Remove reference to ARCH_HAS_OPP, it has been removed

----------------------------------------------------------------
Paul Bolle (1):
      ARM: shmobile: Remove ARCH_HAS_OPP completely

 arch/arm/mach-shmobile/Kconfig | 1 -
 1 file changed, 1 deletion(-)
