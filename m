From: Alexandre Courbot <gnurou@gmail.com>
Date: Thu, 10 Feb 2011 15:22:44 +0000
Subject: [PATCH 0/2] backlight support for sh_mobile_lcdcfb
Message-Id: <1297351366-7374-1-git-send-email-gnurou@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These patches add initial support for per-channel GPIO-controlled backlights to the sh_mobile_lcdcfb driver. A backlight device for the ecovec24 board is also provided.

Backlight support is directly integrated into the lcdcfb driver, because external usage seems unlikely and this facilitates integration with the fb backlight support. However, it should be be easy to split it into another driver if needed.

This series should be considered a first draft, since some points could probably be improved. In particular, the gpio is not acquired by the driver since board support code (at least for ecovec24) request it during early setup and do not seem to release it.

Alexandre Courbot (2):
  fbdev: sh_mobile_lcdcfb: add backlight support
  sh: mach-ecovec24: support for main lcd backlight

 arch/sh/boards/mach-ecovec24/setup.c |    6 +++
 drivers/video/Kconfig                |    1 +
 drivers/video/sh_mobile_lcdcfb.c     |   73 ++++++++++++++++++++++++++++++++++
 drivers/video/sh_mobile_lcdcfb.h     |    2 +
 include/video/sh_mobile_lcdc.h       |    7 +++
 5 files changed, 89 insertions(+), 0 deletions(-)

-- 
1.7.4

