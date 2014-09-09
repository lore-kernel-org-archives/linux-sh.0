From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 09 Sep 2014 02:40:09 +0000
Subject: [GIT PULL] Renesas ARM Based SoC Clocksource Updates for v3.18
Message-Id: <cover.1410230283.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1381222888-4199-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1381222888-4199-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Daniel,

Please consider these Renesas ARM based SoC clocksource updates for v3.18.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clocksource-for-v3.18

for you to fetch changes up to fb0eee2f141976b5d7f31e477a71556d312f7dc3:

  clocksource: sh_tmu: Document r8a7779 binding (2014-09-06 10:20:53 +0900)

----------------------------------------------------------------
Renesas Clocksource Updates for v3.18

* Document per-SoC bindings

----------------------------------------------------------------
Simon Horman (3):
      clocksource: sh_cmt: Document SoC specific bindings
      clocksource: sh_mtu2: Document r7s72100 binding
      clocksource: sh_tmu: Document r8a7779 binding

 .../devicetree/bindings/timer/renesas,cmt.txt      | 44 +++++++++++++++++++---
 .../devicetree/bindings/timer/renesas,mtu2.txt     |  7 +++-
 .../devicetree/bindings/timer/renesas,tmu.txt      |  7 +++-
 3 files changed, 48 insertions(+), 10 deletions(-)
