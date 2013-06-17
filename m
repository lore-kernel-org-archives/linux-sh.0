From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 17 Jun 2013 18:50:00 +0000
Subject: [PATCH v7 0/3] SH pinctrl DT support
Message-Id: <1371495003-11185-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>

Hello,

Here's the seventh (and hopefully final) version of the SuperH and SH Mobile
pin controllers (PFC) DT support patch set.

The patches have been rebased on the for-next branch of the pinctrl
repository. All ARM-specific patches have been dropped and will be pushed
through to ARM SoC tree in v3.12. This series thus only contains DT support
for the sh-pfc driver.

I've tried merging Simon's latest tag (renesas-next-20130617v3) with these
patches and no conflict occurred. Linus, would it finally be possible to get
this applied for v3.11 ?

Changes since v6:

- Added generic pinconf support back
- Dropped all ARM-specific patches

Changes since v5:

- Dropped generic pinconf support
- Dropped kzm9g-reference patches, as those require pinconf support

Changes since v4:

- Added generic pinconf bindings
- Use symbolic names for GPIO flags

Changes since v3:

- Fixed the GPIO flags description in the DT bindings documentation
- Mention the gpio-rcar driver in the DT bindings documentation for platforms
  that use it
- Removed unneeded #ifdef CONFIG_OF...#endif
- Removed unused support for platform data
- Simplified error path in sh_pfc_dt_node_to_map()
- Added gpio-ranges for r8a7778, r8a7779 and r8a7790

Changes since v2:

- Added pin configuration properties
- Rewrote all arch changes

Changes since v1:

- Fixed gpio cell number 2 documentation
- Added missing gpio-controller and #gpio-cells properties to r8a7740 DT
- Split kzm9g DT patch into SoC and board patches
- Dropped pinctrl mappings move to DT

Laurent Pinchart (3):
  sh-pfc: Remove support for platform data
  sh-pfc: Add DT support
  sh-pfc: Add pinconf support to DT bindings

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       | 153 ++++++++++++++++
 drivers/pinctrl/sh-pfc/core.c                      |  65 ++++++-
 drivers/pinctrl/sh-pfc/pinctrl.c                   | 201 +++++++++++++++++++++
 3 files changed, 417 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt

-- 
Regards,

Laurent Pinchart

