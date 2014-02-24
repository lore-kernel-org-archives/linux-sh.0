From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 24 Feb 2014 12:42:37 +0000
Subject: [GIT PULL FOR v3.14] Renesas CCF fixes
Message-Id: <2712488.FLBcnFKsoQ@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Mike,

The following changes since commit cfbf8d4857c26a8a307fb7cd258074c9dcd8c691:

  Linux 3.14-rc4 (2014-02-23 17:40:03 -0800)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git clocks/fixes/drivers

for you to fetch changes up to 60480994c70981d0336aadb3f46b052977d3d19f:

  clk: shmobile: Fix typo in MSTP clock DT bindings (2014-02-24 13:09:34 
+0100)

----------------------------------------------------------------
Laurent Pinchart (3):
      clk: shmobile: rcar-gen2: Fix clock parent for all non-PLL clocks
      clk: shmobile: rcar-gen2: Fix qspi divisor
      clk: shmobile: Fix typo in MSTP clock DT bindings

 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt |  4 ++--
 drivers/clk/shmobile/clk-rcar-gen2.c                                | 12 +++-
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
Regards,

Laurent Pinchart

