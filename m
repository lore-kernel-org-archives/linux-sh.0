From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 16 Apr 2014 10:47:35 +0000
Subject: [GIT PULL FOR v3.16] Renesas CMT, MTU2 and TMU cleanups
Message-Id: <1445533.Y5IyOam9aF@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Daniel,

Please pull the latest version of the CMT, MTU2 and TMU clocksource drivers 
cleanups. All patches have previously been posted in the two separate "[PATCH 
v3 00/52] Renesas CMT and TMU cleanups" and "[PATCH 00/22] SH MTU2 DT support" 
series.

I've only included the driver patches, the arch/ changes will go through 
Simon's tree. Could you please provide a stable branch that Simon can pull in 
his repository to base the arch/ changes on ?

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git timers/for-v3.16

for you to fetch changes up to 346f5e76b3822a2530a03f33b00ee89dfc463326:

  clocksource: sh_mtu2: Sort headers alphabetically (2014-04-16 12:03:34 
+0200)

----------------------------------------------------------------
Laurent Pinchart (52):
      clocksource: sh_cmt: Use request_irq() instead of setup_irq()
      clocksource: sh_cmt: Split channel fields from sh_cmt_priv
      clocksource: sh_cmt: Rename struct sh_cmt_priv to sh_cmt_device
      clocksource: sh_cmt: Split channel setup to separate function
      clocksource: sh_cmt: Constify name argument to sh_cmt_register()
      clocksource: sh_cmt: Rename mapbase/mapbase_str to mapbase_ch/mapbase
      clocksource: sh_cmt: Add memory base to sh_cmt_channel structure
      clocksource: sh_cmt: Add index to struct sh_cmt_channel
      clocksource: sh_cmt: Replace kmalloc + memset with kzalloc
      clocksource: sh_cmt: Allocate channels dynamically
      clocksource: sh_cmt: Split static information from sh_cmt_device
      clocksource: sh_cmt: Replace hardcoded register values with macros
      clocksource: sh_cmt: Set cpumask to cpu_possible_mask
      clocksource: sh_cmt: Hardcode CMT clock event rating to 125
      clocksource: sh_cmt: Hardcode CMT clock source rating to 125
      clocksource: sh_cmt: Add support for multiple channels per device
      clocksource: sh_cmt: Rename clock to "fck" in the non-legacy case
      clocksource: sh_cmt: Remove FSF mail address from GPL notice
      clocksource: sh_cmt: Sort headers alphabetically
      clocksource: sh_cmt: Request IRQ for clock event device only
      clocksource: sh_tmu: Use request_irq() instead of setup_irq()
      clocksource: sh_tmu: Split channel fields from sh_tmu_priv
      clocksource: sh_tmu: Rename struct sh_tmu_priv to sh_tmu_device
      clocksource: sh_tmu: Split channel setup to separate function
      clocksource: sh_tmu: Constify name argument to sh_tmu_register()
      clocksource: sh_tmu: Add memory base to sh_tmu_channel structure
      clocksource: sh_tmu: Add index to struct sh_tmu_channel
      clocksource: sh_tmu: Replace kmalloc + memset with kzalloc
      clocksource: sh_tmu: Allocate channels dynamically
      clocksource: sh_tmu: Replace hardcoded register values with macros
      clocksource: sh_tmu: Hardcode TMU clock event and source ratings to 200
      clocksource: sh_tmu: Add support for multiple channels per device
      clocksource: sh_tmu: Rename clock to "fck" in the non-legacy case
      clocksource: sh_tmu: Remove FSF mail address from GPL notice
      clocksource: sh_tmu: Sort headers alphabetically
      clocksource: sh_mtu2: Use request_irq() instead of setup_irq()
      clocksource: sh_mtu2: Turn sh_mtu2_priv fields into local variables
      clocksource: sh_mtu2: Split channel fields from sh_mtu2_priv
      clocksource: sh_mtu2: Rename struct sh_mtu2_priv to sh_mtu2_device
      clocksource: sh_mtu2: Split channel setup to separate function
      clocksource: sh_mtu2: Constify name argument to sh_mtu2_register()
      clocksource: sh_mtu2: Add memory base to sh_mtu2_channel structure
      clocksource: sh_mtu2: Add index to struct sh_mtu2_channel
      clocksource: sh_mtu2: Replace kmalloc + memset with kzalloc
      clocksource: sh_mtu2: Allocate channels dynamically
      clocksource: sh_mtu2: Replace hardcoded register values with macros
      clocksource: sh_mtu2: Set cpumask to cpu_possible_mask
      clocksource: sh_mtu2: Hardcode MTU2 clock event rating to 200
      clocksource: sh_mtu2: Add support for multiple channels per device
      clocksource: sh_mtu2: Rename clock to "fck" in the non-legacy case
      clocksource: sh_mtu2: Remove FSF mail address from GPL notice
      clocksource: sh_mtu2: Sort headers alphabetically

 drivers/clocksource/sh_cmt.c  | 956 +++++++++++++++++++++++++++--------------
 drivers/clocksource/sh_mtu2.c | 488 ++++++++++++++++++--------
 drivers/clocksource/sh_tmu.c  | 541 +++++++++++++++++-----------
 include/linux/sh_timer.h      |   1 +
 4 files changed, 1306 insertions(+), 680 deletions(-)

-- 
Regards,

Laurent Pinchart

