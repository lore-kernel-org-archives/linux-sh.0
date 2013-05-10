From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 10 May 2013 14:48:35 +0000
Subject: [RFC/PATCH 0/2] R-Car GPIO DT bindings
Message-Id: <1368197317-13169-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <damm@opensource.se>

Hello,

Here's an RFC that adds DT bindings to the gpio-rcar driver. The patches have
been compile-tested only as I don't have access to the hardware right now, but
I'd like to already receive feedback on the bindings.

Laurent Pinchart (2):
  gpio-rcar: Make the platform data gpio_base field signed
  gpio-rcar: Add DT support

 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt | 48 +++++++++++++++++
 drivers/gpio/gpio-rcar.c                           | 63 ++++++++++++++++++----
 include/linux/platform_data/gpio-rcar.h            |  2 +-
 3 files changed, 102 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt

-- 
Regards,

Laurent Pinchart

