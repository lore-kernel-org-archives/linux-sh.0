From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 07 Aug 2013 16:19:52 +0000
Subject: [PATCH 0/5] Enable DU support to Marzen and Lager boards
Message-Id: <1375892397-5822-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set adds DU support to the r8a7779 and r8a7790 SoCs and registers
DU devices for the Marzen and Lager boards. Only platform data registration is
supported as DU DT bindings are work under progress.

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

Laurent Pinchart (5):
  ARM: shmobile: r8a7779: Add DU support
  ARM: shmobile: r8a7790: Add DU and LVDS clocks
  ARM: shmobile: r8a7790: Add DU and LVDS support
  ARM: shmobile: marzen: Add Display Unit support
  ARM: shmobile: lager: Add Display Unit support

 arch/arm/configs/lager_defconfig              |  2 ++
 arch/arm/configs/marzen_defconfig             |  2 ++
 arch/arm/mach-shmobile/board-lager.c          | 42 ++++++++++++++++++++++
 arch/arm/mach-shmobile/board-marzen.c         | 51 +++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7779.c        |  2 +-
 arch/arm/mach-shmobile/clock-r8a7790.c        | 12 ++++++-
 arch/arm/mach-shmobile/include/mach/r8a7779.h |  2 ++
 arch/arm/mach-shmobile/include/mach/r8a7790.h |  3 ++
 arch/arm/mach-shmobile/setup-r8a7779.c        | 22 ++++++++++++
 arch/arm/mach-shmobile/setup-r8a7790.c        | 27 ++++++++++++++
 10 files changed, 163 insertions(+), 2 deletions(-)

-- 
Regards,

Laurent Pinchart

