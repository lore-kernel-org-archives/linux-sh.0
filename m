From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 11 Sep 2015 02:03:11 +0000
Subject: [PATCH/RFC v2 0/5] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
Message-Id: <1441936996-18437-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Changes:

v1 -> v2
* Address extensive review from Sergei Shtylyov and  Geert Uytterhoeven
* Split integration and driver changes into separate patch-sets

Base:

This is based on:

* "[PATCH v9 00/07][RFC] Renesas R-Car H3 (r8a7795) integration patches V9"
  - topic/r8a7795-gpio-v1.rebase branch of my renesas tree

Runtime Dependencies:

* The base (above)

* "[PATCH/RFC v2 net-next 0/4] ravb: Add support for r8a7795 SoC"
  - me/r8a7795-ravb-driver-v2 branch of my renesas tree

* "[PATCH] gpio: rcar: GPIO_RCAR doesn't relate to ARM"

* "[PATCH 0/3] Basic GPIO support for r8a7795"
  - topic/r8a7795-gpio-v1.rebase branch of my renesas tree

* "[PATCH 9/9 v2] sh-pfc: r8a7795: add SCIFx support"
  - topic/r8a7795-pfc-v2 branch of Geert Uytterhoeven's renesas-drivers tree

* "[PATCH v6 05/05] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support"
  - topic/gen3-cpg-v6 branch of Geert Uytterhoeven's renesas-drivers tree

Availability:

* To aid review I will push the following to the renesas tree:
  - integration (this series): me/r8a7795-ravb-integration-v2
  - driver: me/r8a7795-ravb-driver-v2
  - both with runtime dependencies: me/r8a7795-ravb-driver-and-integration-v2.runtime
  
Kazuya Mizuguchi (3):
  ravb: Provide dev parameter to DMA API
  ravb: Document binding for r8a7795 SoC
  ravb: Add support for r8a7795 SoC


Kazuya Mizuguchi (3):
  arm64: dts: r8a7795: add clock for EthernetAVB
  arm64: dts: r8a7795: add EthernetAVB device node
  arm64: dts: r8a7795: enable EthernetAVB on Salvator-X

Simon Horman (2):
  arm64: dts: r8a7795: enable nfs root on Salvator-X board
  arm64: defconfig: enable EthernetAVB

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 35 +++++++++++++-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 53 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  2 +
 include/dt-bindings/clock/r8a7795-clock.h          |  1 +
 4 files changed, 90 insertions(+), 1 deletion(-)

-- 
2.1.4

