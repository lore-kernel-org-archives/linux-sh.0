From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 09 Oct 2013 06:48:32 +0000
Subject: [GIT PULL] Renesas ARM based SoC clock updates for v3.13
Message-Id: <1381301313-5938-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Mike,

please consider these Renesas ARM based SoC clock updates for v3.13.


The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock-for-v3.13

for you to fetch changes up to f00578d0f860ba63bf28e0261ef489cc9e01ab47:

  clk: emev2: Add support for emev2 SMU clocks with DT (2013-10-09 15:39:08 +0900)

----------------------------------------------------------------
Renesas ARM based SoC clock updates for v3.13

* Add support for emev2 SMU clocks with DT

----------------------------------------------------------------
Takashi Yoshii (1):
      clk: emev2: Add support for emev2 SMU clocks with DT

 .../devicetree/bindings/clock/emev2-clock.txt      |  98 +++++++++++++++++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/shmobile/Makefile                      |   3 +
 drivers/clk/shmobile/clk-emev2.c                   | 104 +++++++++++++++++++++
 4 files changed, 206 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/emev2-clock.txt
 create mode 100644 drivers/clk/shmobile/Makefile
 create mode 100644 drivers/clk/shmobile/clk-emev2.c
