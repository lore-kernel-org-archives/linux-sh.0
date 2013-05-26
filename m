From: Simon Horman <horms+renesas@verge.net.au>
Date: Sun, 26 May 2013 13:05:22 +0000
Subject: [GIT PULL] Renesas ARM based emev2 SoC updates for v3.11
Message-Id: <1369573523-10980-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-emev2-for-v3.11

for you to fetch changes up to 94a6af856df56ed39bb59ebe17bfa2d10fb333f2:

  ARM: shmobile: emev2: Remove init_irq declaration in machine description (2013-05-22 21:42:03 +0900)

----------------------------------------------------------------
Renesas ARM based emev2 SoC updates for v3.11

Clean-up from Maxime Ripard to remove unnecessary init_irq declaration in
machine description.

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: shmobile: emev2: Remove init_irq declaration in machine description

 arch/arm/mach-shmobile/setup-emev2.c |    2 --
 1 file changed, 2 deletions(-)
