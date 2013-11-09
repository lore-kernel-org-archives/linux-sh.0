From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 09 Nov 2013 12:33:47 +0000
Subject: [PATCH 0/2] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
Message-Id: <1384000429-3590-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org

Hello,

This patch series enables compilation of SH-Mobile drivers on both the
non-multiplatform (ARCH_SHMOBILE) and the multiplatform (ARCH_SHMOBILE_MULTI)
SH-Mobile architectures. To do so it renames ARCH_SHMOBILE to
ARCH_SHMOBILE_LEGACY and creates a new ARCH_SHMOBILE symbol selected by both
ARCH_SHMOBILE_MULTI and ARCH_SHMOBILE_LEGACY.

The second patch adds a dependency on ARCH_SHMOBILE_LEGACY to the ASoC R-Car
driver. It can be squashed with the first patch or applied separately to
minimize the risk of conflicts if desired.

Laurent Pinchart (2):
  ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
  ASoC: sh: rcar: Depend on ARCH_SHMOBILE_LEGACY

 arch/arm/Kconfig                  | 14 ++++++++------
 arch/arm/Makefile                 |  1 -
 arch/arm/boot/compressed/Makefile |  2 +-
 arch/arm/boot/dts/Makefile        |  2 +-
 arch/arm/mach-shmobile/Kconfig    |  8 ++++++--
 drivers/Makefile                  |  2 +-
 sound/soc/sh/Kconfig              |  1 +
 7 files changed, 18 insertions(+), 12 deletions(-)

-- 
Regards,

Laurent Pinchart

