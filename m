From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 17 Dec 2014 06:11:23 +0000
Subject: [PATCH 0/2] ARM: shmobile: tidyup #sound-dai-cells settings
Message-Id: <87a92m3ivz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches tidyup #sound-dai-cells settings in r8a7790/r8a7791.
Because current setting style is very confusable for our customer

Kuninori Morimoto (2):
      ARM: shmobile: r8a7790: tidyup #sound-dai-cells settings
      ARM: shmobile: r8a7791: tidyup #sound-dai-cells settings

 arch/arm/boot/dts/r8a7790-lager.dts   |    1 +
 arch/arm/boot/dts/r8a7790.dtsi        |    7 ++++++-
 arch/arm/boot/dts/r8a7791-koelsch.dts |    1 +
 arch/arm/boot/dts/r8a7791.dtsi        |    7 ++++++-
 4 files changed, 14 insertions(+), 2 deletions(-)



Best regards
---
Kuninori Morimoto
