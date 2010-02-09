From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Feb 2010 06:49:40 +0000
Subject: [PATCH 00/03] sh: SDHI vector merge
Message-Id: <20100209064940.31154.52216.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: SDHI vector merge

[PATCH 01/03] sh: sh7722/Migo-R SDHI vector merge
[PATCH 02/03] sh: sh7723/AP325 SDHI vector merge
[PATCH 03/03] sh: sh7724/Ecovec24/KFR2R09/MS7724SE SDHI vector merge

These patches merge the SDHI interrupt vectors in the INTC tables
for sh7722, sh7723 and sh7724 processors. The interrupt number in
Linux is also changed to the first of the vectors, so the board
specific platform data is also updated for a bunch of boards.

With these patches in place we are one step closer to SDHI hotplug.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the INTC patches for intc_hw_desc and force_enable.

 arch/sh/boards/mach-ap325rxa/setup.c   |    4 ++--
 arch/sh/boards/mach-ecovec24/setup.c   |    4 ++--
 arch/sh/boards/mach-kfr2r09/setup.c    |    2 +-
 arch/sh/boards/mach-migor/setup.c      |    2 +-
 arch/sh/boards/mach-se/7724/setup.c    |    4 ++--
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   18 ++++++++++--------
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   32 +++++++++++++++++---------------
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   32 ++++++++++++++++----------------
 8 files changed, 51 insertions(+), 47 deletions(-)
