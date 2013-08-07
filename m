From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 07 Aug 2013 22:56:23 +0000
Subject: [PATCH v2 0/9] Enable DU support to Marzen and Lager boards
Message-Id: <1375916192-22647-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hello,

This is the second version of a patch set that adds DU support to the r8a7779
and r8a7790 SoCs and registers DU devices for the Marzen and Lager boards. Only
platform data registration is supported as DU DT bindings are work under
progress.

Compared to v1 (thanks to Sergei for his quick review), this version annotates
platform data and resources as __initdata, splits defconfig changes from board
code changes, and constifies existing r8a7790 and Lager platform data and
resources. This last change is required to avoid a section type conflict at
link time, similar to

arch/arm/mach-shmobile/board-marzen.c: In function ‘marzen_init’:
arch/arm/mach-shmobile/board-marzen.c:202:43: error: du_pdata causes a section
	type conflict with marzen_devices
arch/arm/mach-shmobile/board-marzen.c:237:32: note: ‘marzen_devices’ was
	declared here
make[1]: *** [arch/arm/mach-shmobile/board-marzen.o] Error 1

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
dependency. Simon, how would you like to handle that ?

As a side note, patches 2/9 and 7/9 can be merged first independently of this
series if desired.

Laurent Pinchart (9):
  ARM: shmobile: r8a7779: Add DU support
  ARM: shmobile: r8a7790: Constify platform data and resources
  ARM: shmobile: r8a7790: Add DU and LVDS clocks
  ARM: shmobile: r8a7790: Add DU and LVDS support
  ARM: shmobile: marzen: Add Display Unit support
  ARM: shmobile: marzen: Select DRM_RCAR_DU in defconfig
  ARM: shmobile: lager: Constify platform data and resources
  ARM: shmobile: lager: Add Display Unit support
  ARM: shmobile: lager: Select DRM_RCAR_DU in defconfig

 arch/arm/configs/lager_defconfig              |  2 +
 arch/arm/configs/marzen_defconfig             |  2 +
 arch/arm/mach-shmobile/board-lager.c          | 56 +++++++++++++++++++++++----
 arch/arm/mach-shmobile/board-marzen.c         | 51 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7779.c        |  2 +-
 arch/arm/mach-shmobile/clock-r8a7790.c        | 12 +++++-
 arch/arm/mach-shmobile/include/mach/r8a7779.h |  2 +
 arch/arm/mach-shmobile/include/mach/r8a7790.h |  3 ++
 arch/arm/mach-shmobile/setup-r8a7779.c        | 22 +++++++++++
 arch/arm/mach-shmobile/setup-r8a7790.c        | 48 ++++++++++++++++++-----
 10 files changed, 181 insertions(+), 19 deletions(-)

-- 
Regards,

Laurent Pinchart

