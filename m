From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Nov 2015 02:11:15 +0000
Subject: [PATCH 0/2] thermal: rcar_thermal: tidyup rebind issue
Message-Id: <87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, cm-hiep@jinso.co.jp, nv-dung@jinso.co.jp


Hi Zhang, Eduardo
Cc: Dung, Hiep

rcar_thermal doesn't work after unbind/re-bind today.
These patches are cosmetic, and tidyup it

Kuninori Morimoto (2):
      thermal: rcar_thermal: remove redundant operation
      thermal: rcar_thermal: use pm_runtime_put_sync()

 drivers/thermal/rcar_thermal.c | 49 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)


Best regards
---
Kuninori Morimoto
