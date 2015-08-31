From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 31 Aug 2015 15:36:38 +0000
Subject: [PATCH 0/3] Basic GPIO support for r8a7795
Message-Id: <1441035401-5843-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This has been broken out of horms's GPIO and EthernetAVB RFC (thanks again)
and has its minor issues fixed, hopefully.  Specifically, it fixes the GPIO
6 and 7 clock references, dumps the MSTP's "clock-output-names" property,
and omits the extraneous options in defconfig.

CU
Uli


Changes since RFC:
- fix GPIO6 and GPIO7 clock assignments
- remove "clock-output-names" property from MSTP
- do not enable GPIO_SYSFS, LEDS_GPIO in defconfig


Takeshi Kihara (3):
  arm64: dts: r8a7795: add GPIO clocks
  arm64: dts: r8a7795: add GPIO nodes
  arm64: defconfig: Enable GPIO of Renesas R-Car Gen3 SoC

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 128 ++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig              |   1 +
 include/dt-bindings/clock/r8a7795-clock.h |   8 ++
 3 files changed, 137 insertions(+)

-- 
2.4.6

