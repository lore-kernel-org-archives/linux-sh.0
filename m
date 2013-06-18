From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 18 Jun 2013 10:29:47 +0000
Subject: [PATCH v2 0/2] R-Car GPIO fixes
Message-Id: <1371551389-5493-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

Here are two small fixes for the gpio-rcar driver. I would push them through
the GPIO tree if it wasn't for the fact that they're based on gpio-rcar DT
support, scheduled for merge through the ARM SoC tree.

Simon, as these patches are fixes, would it be possible to get them in v3.11
through your tree ?

Changes since v1:

- Fixed 2/2 commit message to mention IS_ENABLED, not IS_CONFIG

Laurent Pinchart (2):
  gpio-rcar: Reference core gpio documentation in the DT bindings
  gpio-rcar: Remove #ifdef CONFIG_OF around OF-specific sections

 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt     | 18 ++++++------------
 drivers/gpio/gpio-rcar.c                               |  8 ++------
 2 files changed, 8 insertions(+), 18 deletions(-)

-- 
Regards,

Laurent Pinchart

