From: Alexandre Courbot <gnurou@gmail.com>
Date: Wed, 16 Feb 2011 03:49:00 +0000
Subject: [PATCH v2 0/3] backlight support for sh_mobile_lcdcfb
Message-Id: <1297828143-11798-1-git-send-email-gnurou@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Refined patch that uses board-specific callbacks instead of
fixed GPIO controls. Support for ecovec24 is included, and the
backlight control code of ap325rxa have also been moved to the
new callbacks.

Alexandre Courbot (3):
  fbdev: sh_mobile_lcdcfb: add backlight support
  sh: mach-ecovec24: support for main lcd backlight
  sh: mach-ap325rxa: move backlight control code

 arch/sh/boards/mach-ap325rxa/setup.c |   32 ++++++++++---
 arch/sh/boards/mach-ecovec24/setup.c |   18 ++++++++
 drivers/video/Kconfig                |    1 +
 drivers/video/sh_mobile_lcdcfb.c     |   81 ++++++++++++++++++++++++++++++++++
 drivers/video/sh_mobile_lcdcfb.h     |    2 +
 include/video/sh_mobile_lcdc.h       |    9 ++++
 6 files changed, 135 insertions(+), 8 deletions(-)

-- 
1.7.4.1

