From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 31 Jan 2013 06:23:53 +0000
Subject: [GIT PULL] Renesas ARM-based SoC for v3.9 #2
Message-Id: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1352277298-23312-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1352277298-23312-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit 42dd581bc4dba82e8756bb881fa974742250b4c6:

  ARM: shmobile: Include sh73a0 DTSI in kzm9g (2013-01-25 09:26:33 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards2-for-v3.9

for you to fetch changes up to 2f27c40656fecba44e839c77910f75ee1024df62:

  ARM: shmobile: armadillo800eva: set clock rates before timer init (2013-01-30 13:24:07 +0900)

----------------------------------------------------------------
Second round of Renesas ARM-based SoC board changes for v3.9

* Fix to correct timer initialisation on the armadillo 800 eva board
  from Hideki EIRAKU

* The remaining of the changes relate to updating boards to
  make use of gpio_request_one(). These changes are from  Laurent Pinchart.

----------------------------------------------------------------
Hideki EIRAKU (1):
      ARM: shmobile: armadillo800eva: set clock rates before timer init

Laurent Pinchart (8):
      ARM: shmobile: ag5evm: Use gpio_request_one()
      ARM: shmobile: ap4evb: Use gpio_request_one()
      ARM: shmobile: armadillo800eva: Use gpio_request_one()
      ARM: shmobile: armadillo800eva: Use gpio_set_value() to set GPIO value
      ARM: shmobile: kota2: Use gpio_request_one()
      ARM: shmobile: bonito: Use gpio_request_one()
      ARM: shmobile: kzm9g: Use gpio_request_one()
      ARM: shmobile: mackerel: Use gpio_request_one()

 arch/arm/mach-shmobile/board-ag5evm.c          |   22 ++++-----
 arch/arm/mach-shmobile/board-ap4evb.c          |   33 ++++----------
 arch/arm/mach-shmobile/board-armadillo800eva.c |   57 +++++++++---------------
 arch/arm/mach-shmobile/board-bonito.c          |    7 ++-
 arch/arm/mach-shmobile/board-kota2.c           |    9 ++--
 arch/arm/mach-shmobile/board-kzm9g.c           |   18 +++-----
 arch/arm/mach-shmobile/board-mackerel.c        |   16 +++----
 7 files changed, 57 insertions(+), 105 deletions(-)
