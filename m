From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 30 Sep 2015 06:16:22 +0000
Subject: [PATCH 0/5] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
Message-Id: <1443593787-21224-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


This patchset enables the EthernetAVB on the Salvator-X board.
With it and its dependencies in place I have have successfully
booted to an nfsroot user-space (arm64 Debian Jessie).

In order to achieve that I used the following command line set from u-boot.

root=/dev/nfs ip=dhcp nfsroot.3.3.135:/srv/nfs/salvator-x-arm64

Changes:

* See changelog of individual patches

Base:

This is based on:

* "[PATCH v9 00/07][RFC] Renesas R-Car H3 (r8a7795) integration patches V9"
  - topic/r8a7795-gpio-v1.rebase branch of my renesas tree

Runtime Dependencies:

* The base (above)

* "[PATCH/RFC v3 net-next 0/4] ravb: Add support for r8a7795 SoC"
  and its dependencies
  - me/r8a7795-ravb-driver-v4 branch of my renesas tree

* v4.3-rc2 for "[PATCH] gpio: rcar: GPIO_RCAR doesn't relate to ARM"

* "[PATCH 0/3] Basic GPIO support for r8a7795"
  - topic/r8a7795-gpio-v1.rebase branch of my renesas tree

* "[PATCH/RFC v2] sh-pfc: r8a7795: add EtherAVB support"
  and its dependencies
  - me/r8a7795-ravb-pfc-v2 branch of my renesas tree

* "[PATCH v7 05/05] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support"
  - topic/gen3-cpg-v7 branch of Geert Uytterhoeven's renesas-drivers tree

Availability:

To aid review of this and other EtherAVB patches the following branches are
available in my renesas tree on kernel.org.

* me/r8a7795-ravb-pfc-v2: PFC update for EthernetAVB on r8a7795
* me/r8a7795-ravb-driver-v4: phylib and EthernetAVB driver update for r8a7795
* me/r8a7795-ravb-integration-v4: this patchset
* me/r8a7795-ravb-driver-and-integration-v3.runtime:
      the above three branches with their runtime dependencies


Kazuya Mizuguchi (3):
  arm64: dts: r8a7795: add clock for EthernetAVB
  arm64: dts: r8a7795: add EthernetAVB device node
  arm64: dts: r8a7795: enable EthernetAVB on Salvator-X

Simon Horman (2):
  arm64: dts: r8a7795: enable nfs root on Salvator-X board
  arm64: defconfig: enable EthernetAVB

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 33 ++++++++++++-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 54 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  2 +
 include/dt-bindings/clock/r8a7795-clock.h          |  1 +
 4 files changed, 89 insertions(+), 1 deletion(-)

-- 
2.1.4

