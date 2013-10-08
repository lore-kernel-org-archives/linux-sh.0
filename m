From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 08 Oct 2013 09:01:27 +0000
Subject: [GIT PULL] Renesas ARM based SoC clocksource updates for v3.13
Message-Id: <1381222888-4199-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Daniel,

please consider the following Renesas ARM based SoC clocksource updates
for v3.13.


The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clocksource-for-v3.13

for you to fetch changes up to c93031270dfb9b60dba1fc63073406e31acfc7b4:

  clocksource: em_sti: convert to clk_prepare/unprepare (2013-10-08 09:37:24 +0900)

----------------------------------------------------------------
Renesas ARM based SoC clocksource updates for v3.13

* Convert em_sti to clk_prepare/unprepare

----------------------------------------------------------------
Shinya Kuribayashi (1):
      clocksource: em_sti: convert to clk_prepare/unprepare

 drivers/clocksource/em_sti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
