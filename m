From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 18 May 2011 11:10:05 +0000
Subject: [PATCH 0/6 v2] MERAM support for LCDC
Message-Id: <1305717011-20742-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series adds support for read-ahead cache-access from the 
LCDC to the main memory.  These patches enabled the LCDC to access
the MERAM memory via ICB.  The specific ICBs to use are chip dependent
and defined in the platform data.

The MERAM clock will enable when the LCDC clocks do, and are allowed to 
be disbled when the LCDC clocks are.

Changes from V1
---------------
* Specified meram info data (struct sh_mobile_meram_info *meram_dev) as
  part of the LCDC device data, not the LCDC channel data, since the info
  data corresponds to the whole device, not just one configuration.

* Added dynamic clock enable/disable via runtime_pm.

* Changed .id from -1 to 0 in platform data

Damian Hobson-Garcia (6):
  sh_mobile: Add MSTP clock for MERAM
  sh_mobile_meram: MERAM framework for LCDC
  sh_mobile_meram: Add support for NV24 framebuffers
  sh_mobile_meram: MERAM platform data for LCDC
  fbdev: sh_mobile_meram: Add clock enable/disble via runtime PM
  fbdev: sh_mobile_meram: Enable/disable MERAM clocks along with LCDC
    clocks

 arch/arm/mach-shmobile/board-ap4evb.c   |   73 ++++
 arch/arm/mach-shmobile/board-mackerel.c |   74 ++++
 arch/arm/mach-shmobile/clock-sh7372.c   |    4 +-
 drivers/video/Kconfig                   |   12 +
 drivers/video/Makefile                  |    1 +
 drivers/video/sh_mobile_lcdcfb.c        |  117 ++++++-
 drivers/video/sh_mobile_lcdcfb.h        |    1 +
 drivers/video/sh_mobile_meram.c         |  594 +++++++++++++++++++++++++++++++
 drivers/video/sh_mobile_meram.h         |   41 +++
 include/video/sh_mobile_lcdc.h          |    3 +
 include/video/sh_mobile_meram.h         |   74 ++++
 11 files changed, 984 insertions(+), 10 deletions(-)
 create mode 100644 drivers/video/sh_mobile_meram.c
 create mode 100644 drivers/video/sh_mobile_meram.h
 create mode 100644 include/video/sh_mobile_meram.h

