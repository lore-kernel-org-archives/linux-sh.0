From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 13 Dec 2011 16:00:27 +0000
Subject: [PATCH 00/05] sh: pfc: Variable bitfield width and unlock reg patches
Message-Id: <20111213160027.4021.88173.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: pfc: Variable bitfield width and unlock reg patches

[PATCH 01/05] sh: pfc: Add gpio_read_bit() for data register access
[PATCH 02/05] sh: pfc: Convert index to field and value pair
[PATCH 03/05] sh: pfc: Add config_reg_helper() function
[PATCH 04/05] sh: pfc: Variable bitfield width config register support
[PATCH 05/05] sh: pfc: Unlock register support

Update the common PFC code to support r8a7779 by adding:
- Variable bitfield width config register support (Patch 4)
- Unlock register support (Patch 5)

Patch 1-3 contain incremental changes needed for 4.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on "[PATCH] sh: pfc: ioremap() support"

 drivers/sh/pfc.c       |  202 +++++++++++++++++++++++++-----------------------
 include/linux/sh_pfc.h |   11 ++
 2 files changed, 117 insertions(+), 96 deletions(-)
