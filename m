From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Feb 2010 07:37:35 +0000
Subject: [PATCH 00/05] tmio_mmc: SDHI hotplug and random fixes
Message-Id: <20100217073735.32726.12020.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: sameo@linux.intel.com, linux-sh@vger.kernel.org, linus.ml.walleij@gmail.com, g.liakhovetski@gmx.de, goda.yusuke@renesas.com, ian@mnementh.co.uk, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, akpm@linux-foundation.org

tmio_mmc: SDHI hotplug and random fixes

[PATCH 01/05] tmio_mmc: Keep card-detect interrupts enabled
[PATCH 02/05] tmio_mmc: Add MMC_CAP_MMC_HIGHSPEED support V2
[PATCH 03/05] tmio_mmc: Use 100ms mmc_detect_change() delay
[PATCH 04/05] tmio_mmc: Remove const from platform data V3
[PATCH 05/05] tmio_mmc: Balance cell enable()/disable() calls

These patches are a collection of fixes for SDHI hotplug and
other minor improvements for the tmio_mmc driver.

The first and the third patch contain tmio-mmc specific fixes
for SDHI hotplug. Hot insertion and eject have been tested using
the sh-2.6 tree with the two SDHI blocks provided by the sh7724
processor using Ecovec24 and ms7724se boards. The single SDHI
block included in sh7722 has been tested on Migo-R.

The second patch is the ground work to allow the SDHI mfd driver
to enable MMC_CAP_MMC_HIGHSPEED.

The last two patches are just random improvements and fixes for
the tmio_mmc driver.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mmc/host/tmio_mmc.c |   13 ++++++++++---
 drivers/mmc/host/tmio_mmc.h |    6 ++----
 include/linux/mfd/tmio.h    |    3 ++-
 3 files changed, 14 insertions(+), 8 deletions(-)
