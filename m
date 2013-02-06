From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 06 Feb 2013 02:03:20 +0000
Subject: [GIT PULL] Renesas ARM-based SoC for v3.9 #4
Message-Id: <1360116201-9362-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1352277298-23312-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1352277298-23312-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit 58079fa7d54a0929d304054ee759187a2ccd3cdf:

  ARM: shmobile: r8a7779: Correct TMU clock support (2013-02-05 12:31:18 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc4-for-v3.9

for you to fetch changes up to dbe1c3defb3844772634446492ea6c13882596ec:

  ARM: shmobile: Register ARM architected timer (2013-02-05 17:13:55 +0900)

----------------------------------------------------------------
Fourth round of Renesas ARM-based SoC changes for v3.9

Register ARM architected timer.

This is preparatory work by Magnus Damm for SoC(s) that use
the ARM architected timer.

----------------------------------------------------------------
Magnus Damm (1):
      ARM: shmobile: Register ARM architected timer

 arch/arm/mach-shmobile/timer.c |    3 +++
 1 file changed, 3 insertions(+)
