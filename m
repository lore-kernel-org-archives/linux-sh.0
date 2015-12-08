From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Dec 2015 05:26:20 +0000
Subject: [PATCH 0/8 v4] enable to use thermal-zone on r8a7790/1
Message-Id: <87vb895x9d.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


Hi

These are v4 of thermal-zone support for r8a7790/r8a7791.
Mainly, it cares return value of get_temp()

I think 8) is needed on of-thermal (?)

Kuninori Morimoto (8):
      1) thermal: rcar: move rcar_thermal_dt_ids to upside
      2) thermal: rcar: check every rcar_thermal_update_temp() return value
      3) thermal: rcar: check irq possibility in rcar_thermal_irq_xxx()
      4) thermal: rcar: retern error rcar_thermal_get_temp() if no ctemp update
      5) thermal: rcar: enable to use thermal-zone on DT
      6) ARM: shmobile: r8a7790: enable to use thermal-zone
      7) ARM: shmobile: r8a7791: enable to use thermal-zone
      8) thermal: of-thermal: of_thermal_set_trip_temp() call thermal_zone_device_update()

 Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 37 +++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/r8a7790.dtsi                             | 26 ++++++++++++++++++++++++--
 arch/arm/boot/dts/r8a7791.dtsi                             | 26 ++++++++++++++++++++++++--
 drivers/thermal/of-thermal.c                               |  2 ++
 drivers/thermal/rcar_thermal.c                             | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 5 files changed, 160 insertions(+), 27 deletions(-)

Best regards
---
Kuninori Morimoto
