From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 02 Oct 2009 02:21:58 +0000
Subject: [PATCH 00/07] sh: SuperH Mobile SDHI changes
Message-Id: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, g.liakhovetski@gmx.de, ian@mnementh.co.uk, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, akpm@linux-foundation.org

sh: SuperH Mobile SDHI changes

[PATCH 01/07] mfd: Add SuperH Mobile SDHI platform driver 
[PATCH 02/07] mmc: Add SuperH to the tmio-mmc Kconfig
[PATCH 03/07] mmc: Remove const from tmio-mmc platform data
[PATCH 04/07] sh: SDHI platform data to the Migo-R board
[PATCH 05/07] sh: SDHI platform data to the AP325RXA board
[PATCH 06/07] sh: SDHI platform data to the SE7724 board
[PATCH 07/07] sh: SDHI platform data to the kfr2r09 board

These patches contain the SuperH specific changes needed for
the tmio-mmc driver to work with SuperH Mobile SDHI hardware.

The tmio-mmc patch 0001-MMC-hardware-abstraction-for-CNF-area.patch
by Ian Molton is needed for correct run time behaviour. Without
this patch the tmio-mmc probe() fails gracefully.

I suggest merging the series in the SuperH tree. Not sure about
the best way to merge the patch by Ian.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/board-ap325rxa.c     |   52 ++++++------
 arch/sh/boards/mach-kfr2r09/setup.c |   33 +++++++
 arch/sh/boards/mach-migor/setup.c   |   52 ++++++------
 arch/sh/boards/mach-se/7724/setup.c |   33 +++++++
 drivers/mfd/Kconfig                 |    8 +
 drivers/mfd/Makefile                |    1 
 drivers/mfd/sh_mobile_sdhi.c        |  149 ++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/Kconfig            |    2 
 include/linux/mfd/tmio.h            |    2 
 9 files changed, 279 insertions(+), 53 deletions(-)
