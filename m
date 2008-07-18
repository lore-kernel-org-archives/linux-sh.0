From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 18 Jul 2008 07:40:02 +0000
Subject: [PATCH 00/05] resource: type, size and IORESOURCE_CLK patches V2
Message-Id: <20080718074002.32713.73442.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, gregkh@suse.de, lethal@linux-sh.org, i2c@lm-sensors.org, Magnus Damm <magnus.damm@gmail.com>, akpm@linux-foundation.org

This is V2 of the resource type, size and IORESOURCE_CLK patches.

[PATCH 01/05] resource: add resource_size()
[PATCH 02/05] resource: add resource_type() and IORESOURCE_TYPE_BITS
[PATCH 03/05] resource: add new IORESOURCE_CLK type V2
[PATCH 04/05] i2c-sh_mobile: IORESOURCE_CLK support
[PATCH 05/05] sh: add IORESOURCE_CLK to SuperH Mobile I2C platform data

Changes since V1
 - Just add a single bit for IORESOURCE_CLK
 - Dropped "[PATCH 03/04] resource: use new resource type changes" for now
 - Added IORESOURCE_CLK driver patch for i2c-sh_mobile
 - Added IORESOURCE_CLK platform data patch

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   14 ++++++++++----
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |    7 +++++--
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    7 +++++--
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |    7 +++++--
 drivers/base/platform.c                |   31 +++++++++++++++++--------------
 drivers/i2c/busses/i2c-sh_mobile.c     |    8 +++++++-
 include/linux/ioport.h                 |   28 +++++++++++++++++++---------
 kernel/resource.c                      |    2 +-
 8 files changed, 69 insertions(+), 35 deletions(-)
