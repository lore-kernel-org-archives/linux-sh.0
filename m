From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 04:07:52 +0000
Subject: [PATCH 0/4 v3] ARM: shmobile: r8a779x: add SDHI DMA support
Message-Id: <87ppa7lanl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are v3 of SDHI DMA support for r8a7790/r8a7791.
These are based on Ulf's
git.linaro.org/people/ulf.hansson/mmc.git tmio

Kuninori Morimoto (2):
      ARM: shmobile: r8a7790: tidyup SDHI register size on DTSI
      ARM: shmobile: r8a7791: tidyup SDHI register size on DTSI

Laurent Pinchart (2):
      ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
      ARM: shmobile: r8a7791: Reference DMA channels in SDHI DT nodes

 arch/arm/boot/dts/r8a7790.dtsi |   12 ++++++++++--
 arch/arm/boot/dts/r8a7791.dtsi |    8 +++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

Best regards
---
Kuninori Morimoto
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
