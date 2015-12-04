From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 04 Dec 2015 03:16:29 +0000
Subject: [PATCH 0/4] enable to use thermal-zone on r8a7790/1
Message-Id: <871tb2hpn2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


Hi

These are enable to use thermal-zone on r8a7790/r8a7791.
The rcar thermal driver can use of-thermal style zone by this patch,
but it still keeping current style too.

You can select trip temp by DT if you use of-thermal style (this patch).
If not, it will use fixed trip temp.

Kuninori Morimoto (4):
      thermal: rcar: move rcar_thermal_dt_ids to upside
      thermal: rcar: enable to use thermal-zone on DT
      ARM: shmobile: r8a7790: enable to use thermal-zone
      ARM: shmobile: r8a7791: enable to use thermal-zone

 Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 37 +++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/r8a7790.dtsi                             | 26 ++++++++++++++++++++++++--
 arch/arm/boot/dts/r8a7791.dtsi                             | 26 ++++++++++++++++++++++++--
 drivers/thermal/rcar_thermal.c                             | 57 +++++++++++++++++++++++++++++++++++++++++++++------------
 4 files changed, 128 insertions(+), 18 deletions(-)



Best regards
---
Kuninori Morimoto
