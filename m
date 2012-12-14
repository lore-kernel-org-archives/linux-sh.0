From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 14 Dec 2012 05:53:23 +0000
Subject: [PATCH 00/08] clocksource: sh_cmt: CMT driver update
Message-Id: <20121214055323.10081.12056.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, johnstul@us.ibm.com, horms@verge.net.au, shinya.kuribayashi.px@renesas.com, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

clocksource: sh_cmt: CMT driver update

[PATCH 01/08] clocksource: sh_cmt: Take care of clk_put() when setup_irq() fails
[PATCH 02/08] clocksource: sh_cmt: Initialize 'max_match_value' and 'lock' in sh_cmt_setup()
[PATCH 03/08] clocksource: sh_cmt: Consolidate platform_set_drvdata() call
[PATCH 04/08] clocksource: sh_cmt: Introduce per-register functions
[PATCH 05/08] clocksource: sh_cmt: CMSTR and CMCSR register access update
[PATCH 06/08] clocksource: sh_cmt: CMCNT and CMCOR register access update
[PATCH 07/08] clocksource: sh_cmt: Add control register callbacks
[PATCH 08/08] clocksource: sh_cmt: Add CMT register layout comment

This patch series contains a couple of driver updates from Kuribayashi-san
together with some register access changes from me. The register access
changes work towards adding support for 32-bit only CMT hardware, but
the final bits are not yet included in this series due to lack of hardware.

Patches 1-3:
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>

Patches 4-8:
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/clocksource/sh_cmt.c |  257 ++++++++++++++++++++++++------------------
 1 file changed, 152 insertions(+), 105 deletions(-)


