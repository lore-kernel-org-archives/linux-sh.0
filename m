From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 27 May 2013 08:59:48 +0000
Subject: [GIT PULL] Renesas ARM based r8a7790 SoC updates for v3.11
Message-Id: <1369645224-3728-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365668101-21723-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1365668101-21723-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-r8a7790-for-v3.11

for you to fetch changes up to 3318ce6ff5a5dbebe472103966a2c6d7d9542ec3:

  ARM: shmobile: clock-r8a7790: add TPU PWM support (2013-05-27 17:50:51 +0900)

----------------------------------------------------------------
Renesas ARM based r8a7790 SoC updates for v3.11

* Increased clock coverage by Kuninori Morimoto.
* TOU PWM clock support by Laurent Pinchart.
* Clean-up from Maxime Ripard to remove unnecessary init_irq declaration in
  machine description.
* Clean-up from Magnus Damm to remove unused GIC CPU interface portions
  of r8a7790.dtsi
* Clean-up from Laurent Pinchart to make clock arrays static

----------------------------------------------------------------
Kuninori Morimoto (3):
      ARM: shmobile: r8a7790: add main clock
      ARM: shmobile: r8a7790: add div4 clocks
      ARM: shmobile: r8a7790: add div6 clocks

Laurent Pinchart (2):
      ARM: shmobile: r8a7790: Make private clock arrays static
      ARM: shmobile: clock-r8a7790: add TPU PWM support

Magnus Damm (1):
      ARM: shmobile: Remove unused r8a7790 GIC CPU interface DT bits

Maxime Ripard (1):
      ARM: shmobile: r8a7790: Remove init_irq declaration in machine description

 arch/arm/boot/dts/r8a7790.dtsi         |    6 -
 arch/arm/mach-shmobile/clock-r8a7790.c |  238 +++++++++++++++++++++++++++++++-
 arch/arm/mach-shmobile/setup-r8a7790.c |    2 -
 3 files changed, 231 insertions(+), 15 deletions(-)
