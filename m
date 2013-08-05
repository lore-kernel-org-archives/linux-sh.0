From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 05 Aug 2013 01:56:37 +0000
Subject: [GIT PULL 0/2 v2] Renesas ARM based SoC clocksource updates for v3.12
Message-Id: <1375667799-6327-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Daniel,

please consider the following Renesas ARM based SoC clocksource updates
for v3.12.


The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clocksource-for-v3.12

for you to fetch changes up to 172705f8a40b6e72c53f8cceda079504ed71c4e0:

  clocksource: em_sti: Convert to devm_* managed helpers (2013-08-05 10:47:10 +0900)

----------------------------------------------------------------
Renesas ARM based SoC clocksource updates for v3.12

* Add support for CMT hardware with 32-bit control and counter registers
* em_sti: Convert to devm_* managed helpers

----------------------------------------------------------------
Laurent Pinchart (1):
      clocksource: em_sti: Convert to devm_* managed helpers

Magnus Damm (1):
      clocksource: sh_cmt: 32-bit control register support

 drivers/clocksource/em_sti.c | 49 +++++++++++++------------------------------
 drivers/clocksource/sh_cmt.c | 50 +++++++++++++++++++++++++++++++-------------
 2 files changed, 50 insertions(+), 49 deletions(-)
