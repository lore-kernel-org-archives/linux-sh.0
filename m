From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 30 Oct 2014 01:50:49 +0000
Subject: [GIT PULL] Renesas ARM Based SoC DT Clocksource Updates for v3.19
Message-Id: <cover.1414629281.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT clocksource updates for v3.19.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-clocksource-for-v3.19

for you to fetch changes up to d5153cd734dd6c1243bb3dc98065be99b10d049f:

  clocksource: sh_mtu2: Drop incorrect SoC family name (2014-10-27 10:00:36 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Clocksource Updates for v3.19

* sh_mtu2: Drop incorrect SoC family name
* sh_tmu: Document r8a7778 and r8a7740 bindings

----------------------------------------------------------------
Geert Uytterhoeven (3):
      clocksource: sh_tmu: Document R-Mobile r8a7740 binding
      clocksource: sh_tmu: Document r8a7778 binding
      clocksource: sh_mtu2: Drop incorrect SoC family name

 Documentation/devicetree/bindings/timer/renesas,mtu2.txt | 2 +-
 Documentation/devicetree/bindings/timer/renesas,tmu.txt  | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)
