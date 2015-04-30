From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Thu, 30 Apr 2015 12:29:55 +0000
Subject: [RFC PATCH 0/7] UHS-I support for sh_mobile_sdhi
Message-Id: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@lists.codethink.co.uk

This series adds support for UHS-I in sh_mobile_sdhi, partly implemented
in tmio_mmc.  This does not yet include tuning for SDR-104, but SDR-50
works.

The pfc block needs to be configured for 1.8V or 3.3V signalling on the
SDHI, separately from the external voltage regulator.  I've treated this
as an additional regulator that sh_mobile_sdhi has to adjust, but I'm
not entirely happy with this or the way it's represented in the DT.  I
would appreciate advice on how to improve that.

Ben.

Ben Dooks (1):
  ARM: shmobile: r8a7790-lager.dts: Set sdhi and mmcif clock rates

Ben Hutchings (4):
  mmc: tmio: Add UHS-I mode support
  pinctrl: sh-pfc: r8a7790: Add regulators for SD voltage switch
  ARM: shmobile: r8a7790: Add nodes for pfc SD voltage regulators
  mmc: sh_mobile_sdhi: Add UHS-I mode support

Shinobu Uehara (1):
  mmc: sh_mobile_sdhi: Add actual clock rate support

William Towle (1):
  ARM: shmobile: r8a7790-lager.dts: Assert UHS-I SDR-50 capability

 arch/arm/boot/dts/r8a7790-lager.dts  |   21 ++++
 arch/arm/boot/dts/r8a7790.dtsi       |   21 ++++
 drivers/mmc/host/sh_mobile_sdhi.c    |   62 +++++++++++
 drivers/mmc/host/tmio_mmc.h          |    3 +
 drivers/mmc/host/tmio_mmc_pio.c      |   31 ++++++
 drivers/pinctrl/sh-pfc/Kconfig       |    1 +
 drivers/pinctrl/sh-pfc/core.c        |    2 +-
 drivers/pinctrl/sh-pfc/core.h        |    1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |  189 ++++++++++++++++++++++++++++++++++
 9 files changed, 330 insertions(+), 1 deletion(-)

-- 
1.7.10.4



