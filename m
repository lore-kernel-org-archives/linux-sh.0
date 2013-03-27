From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Mar 2013 19:07:30 +0000
Subject: [PATCH 0/3] sh-pfc: r8a7779: Improve readability with a new macro
Message-Id: <1364411253-12170-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Pins are numbered in the r8a7779 documentation using a bank number and a
pin number in the bank. As the pinctrl pin number space is linear, this
is flattened by multiplying the bank number by 32 and adding the pin
number. The resulting pin number has no direct relationship with the
documentation, making it error-prone.

These patches introduce and use a GP_PIN macro that converts from the
documentation pin number space to the linear pinctrl space.

Laurent Pinchart (3):
  sh-pfc: r8a7779: Replace hardcoded pin numbers with GP_PIN macro
  ARM: shmobile: r8a7779: Add GP_PIN macro
  ARM: shmobile: marzen: Use GP_PIN macro

 arch/arm/mach-shmobile/board-marzen.c         |   6 +-
 arch/arm/mach-shmobile/include/mach/r8a7779.h |   2 +
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c          | 270 ++++++++++++++------------
 3 files changed, 147 insertions(+), 131 deletions(-)

-- 
Regards,

Laurent Pinchart

