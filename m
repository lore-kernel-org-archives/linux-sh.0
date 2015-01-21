From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jan 2015 04:26:03 +0000
Subject: [PATCH 0/4 v2] ARM: shmobile: r8a779x: add SDHI DMA support
Message-Id: <873874oj1q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are v2 of SDHI DMA support for r8a7790/r8a7791.
These are based on Ulf's
git.linaro.org/people/ulf.hansson/mmc.git tmio

Kuninori Morimoto (4):
      ARM: shmobile: r8a7790: tidyup SDHI register size on DTSI
      ARM: shmobile: r8a7791: tidyup SDHI register size on DTSI
      ARM: shmobile: r8a7790: add SDHI DMA channels on DTSI
      ARM: shmobile: r8a7791: add SDHI DMA channels on DTSI

 arch/arm/boot/dts/r8a7790.dtsi |   12 ++++++++++--
 arch/arm/boot/dts/r8a7791.dtsi |    8 +++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)


Best regards
---
Kuninori Morimoto
