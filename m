From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 10 Jan 2013 19:47:51 +0000
Subject: [PATCH 0/8] Use gpio_request_one() in SH Mobile board code
Message-Id: <1357847279-7765-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here's a small patch set that converts gpio_request() + gpio_direction_*()
calls into gpio_request_one() in all SH Mobile board files.

The patches are based on top of "[PATCH v2 00/29] SH pinctrl and pinmux
implementation". I will rebase my next version of the pinctrl DT patches on
top of them.

Laurent Pinchart (8):
  ARM: shmobile: ag5evm: Use gpio_request_one()
  ARM: shmobile: ap4evb: Use gpio_request_one()
  ARM: shmobile: armadillo800eva: Use gpio_request_one()
  ARM: shmobile: armadillo800eva: Use gpio_set_value() to set GPIO
    value
  ARM: shmobile: bonito: Use gpio_request_one()
  ARM: shmobile: kota2: Use gpio_request_one()
  ARM: shmobile: kzm9g: Use gpio_request_one()
  ARM: shmobile: mackerel: Use gpio_request_one()

 arch/arm/mach-shmobile/board-ag5evm.c          |   22 ++++------
 arch/arm/mach-shmobile/board-ap4evb.c          |   33 ++++-----------
 arch/arm/mach-shmobile/board-armadillo800eva.c |   52 +++++++++---------------
 arch/arm/mach-shmobile/board-bonito.c          |    7 +--
 arch/arm/mach-shmobile/board-kota2.c           |    9 +---
 arch/arm/mach-shmobile/board-kzm9g.c           |   18 +++-----
 arch/arm/mach-shmobile/board-mackerel.c        |   16 +++-----
 7 files changed, 54 insertions(+), 103 deletions(-)

-- 
Regards,

Laurent Pinchart

