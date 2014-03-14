From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 14 Mar 2014 00:34:08 +0000
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC Clock Updates for v3.15
Message-Id: <cover.1394757110.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1394080829.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1394080829.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this fourth round of
Renesas ARM based SoC clock updates for v3.15.

I am sending this pull request after the release of v3.14-rc6
as it only includes a fix.

This pull request is based on the previous round of
such requests, tagged as renesas-clock3-for-v3.15,
which I have already sent a pull-request for.


The following changes since commit d93023f81d2c79595e64e4f516f03af4e4c73c13:

  ARM: shmobile: r7s72100: fix bus clock calculation (2014-03-06 13:22:02 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock4-for-v3.15

for you to fetch changes up to a51a9d67ba061c1263d078c27e8a3020d61fe236:

  ARM: shmobile: r8a7791: Fix SCIFA3-5 clocks (2014-03-13 10:37:14 +0900)

----------------------------------------------------------------
Fourth Round of Renesas ARM Based SoC Clock Updates for v3.15

r8a7791 (R-Car M2) SoC
* Correct SCIFA3-5 clocks

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: r8a7791: Fix SCIFA3-5 clocks

 arch/arm/mach-shmobile/clock-r8a7791.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)
