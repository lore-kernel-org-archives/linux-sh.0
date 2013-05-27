From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 27 May 2013 09:59:41 +0000
Subject: [GIT PULL v2] Renesas ARM based sh7372 SoC updates for v3.11
Message-Id: <1369648782-8024-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-sh7372-for-v3.11

for you to fetch changes up to 98a443fd3cb4460dd9bec09b3e1d602bc9efa93c:

  ARM: shmobile: sh7372 pinmux platform device cleanup (2013-05-27 18:18:22 +0900)

----------------------------------------------------------------
Renesas ARM based sh7372 SoC updates for v3.11

* Clean-up from Magnus Damm to use DEFINE_RES_MEM() to slightly reduce code size

----------------------------------------------------------------
Magnus Damm (1):
      ARM: shmobile: sh7372 pinmux platform device cleanup

 arch/arm/mach-shmobile/setup-sh7372.c |   24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)
