From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 07 May 2014 23:17:48 +0000
Subject: [PATCH 00/03] pinctrl: sh-pfc: Extend Multiplatform Support
Message-Id: <20140507231748.29661.46207.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

pinctrl: sh-pfc: Extend Multiplatform Support

[PATCH 01/03] pinctrl: sh-pfc: r8a7740: Allow Multiplatform Build
[PATCH 02/03] pinctrl: sh-pfc: sh73a0: Allow Multiplatform Build
[PATCH 03/03] pinctrl: sh-pfc: r8a73a4: Allow Multiplatform Build

These patches enable Multiplatform support for r8a7740, sh73a0 and r8a73a4.

The legacy case is still kept around, so the mach-header is still needed
to allow static GPIO-IRQ assignment. In case of DT the GPIO IRQs are already
provided via DT properties, so we can simply #ifdef out the static IRQ tables
in case of Multiplatform build. Not pretty but it works.

sh7372 is intentionally excluded from this series since it will not be
moved over to Multiplatform. Instead software support for sh7372 will be
phased out in the a few kernel releases.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against renesas-devel-v3.15-rc3-20140502

 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |    7 +++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |    7 ++++++-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |    6 ++++++
 3 files changed, 19 insertions(+), 1 deletion(-)
