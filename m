From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 21 May 2013 11:40:04 +0000
Subject: [RFC/PATCH v2 0/2] R-Car GPIO DT bindings
Message-Id: <1369136406-23800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

Here's the second version of the gpio-rcar driver DT bindings. I've tested the
patches on the Marzen board (r8a7779).

Once again I'd appreciate feedback on the DT bindings. I'm particularly
wondering whether getting the number of lines through the gpio-ranges property
instead of using a dedicated #gpio-lines property as in v1 is a good idea.

Changes since v1:

- Initialize the gpiochip dev field at probe time.
- Add the gpio-ranges property.
- Remove the #gpio-lines property. The number of lines is now passed through
  the gpio-ranges property.

Laurent Pinchart (2):
  gpio-rcar: Make the platform data gpio_base field signed
  gpio-rcar: Add DT support

 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt | 52 +++++++++++++++++
 drivers/gpio/gpio-rcar.c                           | 66 ++++++++++++++++++----
 include/linux/platform_data/gpio-rcar.h            |  2 +-
 3 files changed, 109 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt

-- 
Regards,

Laurent Pinchart

