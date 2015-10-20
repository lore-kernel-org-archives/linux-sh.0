From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 20 Oct 2015 19:01:52 +0000
Subject: [git pull] pinctrl: sh-pfc: Updates for v4.4 (take two)
Message-Id: <1445367712-12253-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1443774347-383-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1443774347-383-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Linus,

The following changes since commit 819fd4bfcc84805c48291de511c917596e911ffa:

  pinctrl: sh-pfc: r8a7795: add EtherAVB support (2015-10-02 09:54:41 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git sh-pfc-for-v4.4

for you to fetch changes up to 660c40bd9837854b3d3cc75e6ddb41cc8ac32a1d:

  pinctrl: sh-pfc: Remove obsolete r8a7778 platform_device_id entry (2015-10-20 16:11:27 +0200)

Summary:
  - r8a7794 VIN support,
  - r8a7778 bias (pull-up) support,
  - Obsolete platform_device_id removal,
  - Various cleanups and refactorings.

Most commits have been acked by Laurent and/or by you.
The USB commit has been acked by the relevant maintainers.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (5):
      pinctrl: sh-pfc: Rename .gpio_data[] to .pinmux_data[]
      usb: renesas_usbhs: Remove unneeded #include <linux/platform_data/gpio-rcar.h>
      pinctrl: sh-pfc: Stop including <linux/platform_data/gpio-rcar.h>
      pinctrl: sh-pfc: Remove obsolete r8a7779 platform_device_id entry
      pinctrl: sh-pfc: Remove obsolete r8a7778 platform_device_id entry

Koji Matsuoka (1):
      pinctrl: sh-pfc: r8a7794: Add VIN pin groups

Sergei Shtylyov (1):
      pinctrl: sh-pfc: r8a779[01]: Move 'union vin_data' to shared header file

Ulrich Hecht (2):
      pinctrl: sh-pfc: Add macros defining GP ports with config flags
      pinctrl: sh-pfc: r8a7778: Add bias (pull-up) pinconf support

 drivers/pinctrl/sh-pfc/core.c        |  10 +-
 drivers/pinctrl/sh-pfc/pfc-emev2.c   |   4 +-
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |   8 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |   4 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 266 ++++++++++++++++++++++++++++++++---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |   5 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |  24 +---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  27 +---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 189 ++++++++++++++++++++++++-
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c |   5 +-
 drivers/pinctrl/sh-pfc/pfc-sh7203.c  |   4 +-
 drivers/pinctrl/sh-pfc/pfc-sh7264.c  |   4 +-
 drivers/pinctrl/sh-pfc/pfc-sh7269.c  |   4 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |   4 +-
 drivers/pinctrl/sh-pfc/pfc-sh7720.c  |   4 +-
 drivers/pinctrl/sh-pfc/pfc-sh7722.c  |   4 +-
 drivers/pinctrl/sh-pfc/pfc-sh7723.c  |   4 +-
 drivers/pinctrl/sh-pfc/pfc-sh7724.c  |   4 +-
 drivers/pinctrl/sh-pfc/pfc-sh7734.c  |   4 +-
 drivers/pinctrl/sh-pfc/pfc-sh7757.c  |   4 +-
 drivers/pinctrl/sh-pfc/pfc-sh7785.c  |   4 +-
 drivers/pinctrl/sh-pfc/pfc-sh7786.c  |   4 +-
 drivers/pinctrl/sh-pfc/pfc-shx3.c    |   4 +-
 drivers/pinctrl/sh-pfc/sh_pfc.h      |  81 +++++++----
 drivers/usb/renesas_usbhs/rcar2.c    |   1 -
 25 files changed, 531 insertions(+), 145 deletions(-)
