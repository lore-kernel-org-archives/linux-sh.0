From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 06 Aug 2014 01:47:35 +0000
Subject: [PATCH 0/5 v2] mmc: shmobile: adds generatoin level DT compatible
Message-Id: <87oavy8k3v.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mwbso8sp.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87mwbso8sp.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>
Cc: Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "goda (Renesas)" <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


Hi Chris, Simon

These are v2 patches of Renesas SDHI driver.
These patches add R-Car generatoin level
DT compatible on driver/platform.

Kuninori Morimoto (5):
      mmc: shmobile: add renesas,sdhi-rcar-gen1/gen2 in DT compatible
      ARM: shmobile: r8a7778: add generation level compatible for SDHI
      ARM: shmobile: r8a7779: add generation level compatible for SDHI
      ARM: shmobile: r8a7790: add generation level compatible for SDHI
      ARM: shmobile: r8a7791: add generation level compatible for SDHI

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |    2 ++
 arch/arm/boot/dts/r8a7778.dtsi                     |    6 +++---
 arch/arm/boot/dts/r8a7779.dtsi                     |    8 ++++----
 arch/arm/boot/dts/r8a7790.dtsi                     |    8 ++++----
 arch/arm/boot/dts/r8a7791.dtsi                     |    6 +++---
 drivers/mmc/host/sh_mobile_sdhi.c                  |    2 ++
 6 files changed, 18 insertions(+), 14 deletions(-)


Best regards
---
Kuninori Morimoto
