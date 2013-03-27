From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Mar 2013 19:21:11 +0000
Subject: [PATCH v2 0/2]  Add R-Car Display Unit support for the Marzen board
Message-Id: <1364412073-12322-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here's the second version of the r8a7779 and marzen patches that add support
for the display unit, based on the pinctrl API.

Compared to v1, the second patch was fixed not to revert the first patch
(which was totally unintentional).

The patches are not meant to be merged yet, they will be submitted with the
next version of the DU driver.

Laurent Pinchart (2):
  ARM: mach-shmobile: r8a7779: Add DU support
  ARM: shmobile: marzen: Add Display Unit support

 arch/arm/configs/marzen_defconfig            |  2 ++
 arch/arm/mach-shmobile/board-marzen.c        | 51 ++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |  1 +
 arch/arm/mach-shmobile/setup-r8a7779.c       | 30 ++++++++++++++++
 4 files changed, 84 insertions(+)

-- 
Regards,

Laurent Pinchart

