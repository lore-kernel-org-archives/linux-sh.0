From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 08 Dec 2011 13:58:44 +0000
Subject: [PATCH 00/04] sh: clock / CPG ioremap() update
Message-Id: <20111208135844.18394.44204.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: clock / CPG ioremap() update

[PATCH 01/04] sh: extend clock struct with mapped_reg member
[PATCH 02/04] sh: use ioread32/iowrite32 and mapped_reg for mstp32
[PATCH 03/04] sh: use ioread32/iowrite32 and mapped_reg for div4
[PATCH 04/04] sh: use ioread32/iowrite32 and mapped_reg for div6

These patches extend the drivers/sh/clk/ code to use ioremap().
Needed for the soc / board support code for r8a7779. Other SoCs
should just keep on working as before.

Signed-off-by: Magnus Damm <damm@opensource.se>
---
 drivers/sh/clk/core.c  |    9 +++++++--
 drivers/sh/clk/cpg.c   |   42 +++++++++++++++++++++---------------------
 include/linux/sh_clk.h |    1 +
 3 files changed, 29 insertions(+), 23 deletions(-)
