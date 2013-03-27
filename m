From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Mar 2013 18:05:48 +0000
Subject: [PATCH 0/2] Add R-Car Display Unit support for the Marzen board
Message-Id: <1364407550-30652-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Per Simon's request, here are r8a7779 and marzen patches that add support for
the display unit, based on the pinctrl API.

The patches are not meant to be merged yet, they will be submitted with the
next version of the DU driver.

Sergei, is this more in line with how you want SoC devices to be declared ?

Laurent Pinchart (2):
  ARM: mach-shmobile: r8a7779: Add DU support
  ARM: shmobile: marzen: Add Display Unit support

 arch/arm/configs/marzen_defconfig     |  2 ++
 arch/arm/mach-shmobile/board-marzen.c | 51 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

-- 
Regards,

Laurent Pinchart

