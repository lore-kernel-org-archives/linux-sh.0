From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 08 Aug 2013 12:03:26 +0000
Subject: [PATCH v3 0/8] Enable DU support for Marzen and Lager boards
Message-Id: <1375963414-31096-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This is the third version of a patch set that registers DU devices for the
Marzen and Lager boards. Only platform data registration is supported as DU DT
bindings are work in progress.

Compared to v2, this version annotates const platform data and resources as
__initconst, splits the r8a7779 DU clock rename to a patch of its own,
and moves DU device registration from setup-*.c files to board files.

The patches depend on both the DU r8a7790 DRM and PFC series available from

        git://linuxtv.org/pinchartl/fbdev.git drm/next/du
        git://linuxtv.org/pinchartl/fbdev.git pinmux/next/r8a7790

They are based respectively on the latest drm-next branch from
git://people.freedesktop.org/~airlied/linux and the latest for-next branch from
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git. Both
series are scheduled for upstream merge in v3.12.

The dependency on pinmux/next/r8a7790 is runtime only, compilation will not
break and the boards won't fail to boot. The only regression will be a pinmux
error message at boot time. The drm/next/du series, however, is a compile-time
dependency. I've asked Dave Airlie to provide a stable branch with those
patches.

As a side note, patches 1/8 to 3/8 and 6/8 can be merged first independently of
this series if desired.

Laurent Pinchart (8):
  ARM: shmobile: r8a7779: Rename DU device in clock lookups list
  ARM: shmobile: r8a7790: Constify platform data and resources
  ARM: shmobile: r8a7790: Add DU and LVDS clocks
  ARM: shmobile: marzen: Add Display Unit support
  ARM: shmobile: marzen: Select DRM_RCAR_DU in defconfig
  ARM: shmobile: lager: Constify platform data and resources
  ARM: shmobile: lager: Add Display Unit support
  ARM: shmobile: lager: Select DRM_RCAR_DU in defconfig

 arch/arm/configs/lager_defconfig       |  2 +
 arch/arm/configs/marzen_defconfig      |  2 +
 arch/arm/mach-shmobile/board-lager.c   | 81 +++++++++++++++++++++++++++++++---
 arch/arm/mach-shmobile/board-marzen.c  | 72 ++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7779.c |  2 +-
 arch/arm/mach-shmobile/clock-r8a7790.c | 12 ++++-
 arch/arm/mach-shmobile/setup-r8a7790.c | 21 ++++-----
 7 files changed, 173 insertions(+), 19 deletions(-)

-- 
Regards,

Laurent Pinchart

