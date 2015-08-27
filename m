From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 27 Aug 2015 09:24:00 +0000
Subject: [PATCH/RFC 00/10] Basic GPIO and EthernetAVB support for r8a7775
Message-Id: <1440667450-3513-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

This series provides basic GPIO and EthernetAVB.

Ulrich, I understand that you are working on enabling GPIO.
I do not intend to usurp that work. But merely to have an early version
to enable EthernetAVB which depends on GPIO.


As a work-around I provided the following to uboot as I do not
seem to get a stable mac address.

setenv bootargs ignore_loglevel rw root=/dev/nfs ip=dhcp nfsroot=$SERVERIP:/srv/nfs/salvator-x-arm64


This series is based on:

* A merge of

  - net-next
    head commit:
    8c5bbe77d4cd ("Merge branch 'act_bpf_lockless'")
  - net
    head commit:
    f50791ac1aca ("usbnet: Get EVENT_NO_RUNTIME_PM bit before it is cleared")

  - next/arm64 branch of the arm-soc tree
    head commit:
    bcfff4d961fb ("arm64: Enable Marvell Berlin SoC family in def config")
  - next/soc branch of the arm-soc tree
    head commit
    c02e0e86d304 ("arm64: dts: mt8173: Add afe device node").

* With the following applied

  - [PATCH 00/25 v7][RFC] arm64: Renesas Gen3 initial patch
  - [PATCH] gpio: rcar: GPIO_RCAR doesn't relate to ARM


To aid review and testing I have pushed this patchset applied on top of its
dependences to the topic/gen3-gpio-eth branch of my renesas tree.

*** This does not imply that I have queued up any of the patches ***



Kazuya Mizuguchi (6):
  ravb: Provide dev parameter to DMA API
  ravb: Add support for r8a7795 SoC
  arm64: dts: r8a7795: add clock for EthernetAVB
  arm64: dts: r8a7795: add EthernetAVB device node
  arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
  Local: Hack: arm64: dts: r8a7795: add ravb phy max-speed 100 for
    Salvator-X board

Simon Horman (2):
  arm64: dts: r8a7795: enable nfs root on Salvator-X board
  arm64: defconfig: enable EthernetAVB

Takeshi Kihara (2):
  arm64: dts: r8a7795: add GPIO nodes
  arm64: defconfig: Enable GPIO of Renesas R-Car Gen3 SoC

 .../devicetree/bindings/net/renesas,ravb.txt       |   6 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  37 +++++-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 125 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   4 +
 drivers/net/ethernet/renesas/ravb.h                |   1 +
 drivers/net/ethernet/renesas/ravb_main.c           |  85 +++++++++-----
 include/dt-bindings/clock/r8a7795-clock.h          |   1 +
 7 files changed, 232 insertions(+), 27 deletions(-)

-- 
2.1.4

