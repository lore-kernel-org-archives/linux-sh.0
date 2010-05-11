From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 13:29:09 +0000
Subject: [PATCH 00/03] Share clock framework between SH and SH-Mobile ARM V2
Message-Id: <20100511132909.9131.3709.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Share clock framework between SH and SH-Mobile ARM V2

[PATCH 01/03] sh: move sh asm/clock.h contents to linux/sh_clk.h V2
[PATCH 02/03] sh: move sh clock.c contents to drivers/sh/clk.
[PATCH 03/03] sh: move sh clock-cpg.c contents to drivers/sh/clk-cpg.c

These patches are V2 of the SH and SH-Mobile ARM clock framework
sharing attempt. Nothing out of the ordinary here.

Builds on top of all the other SH clock framework patches. Perhaps
it's good to merge with in the SH tree and let a few SH-Mobile
patches build on top of this. Those will be posted tomorrow.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/clock.h    |  150 ----------
 arch/sh/kernel/cpu/Makefile    |    2 
 arch/sh/kernel/cpu/clock-cpg.c |  295 ---------------------
 arch/sh/kernel/cpu/clock.c     |  543 ---------------------------------------
 drivers/sh/Makefile            |    2 
 drivers/sh/clk-cpg.c           |  298 +++++++++++++++++++++
 drivers/sh/clk.c               |  548 ++++++++++++++++++++++++++++++++++++++++
 include/linux/sh_clk.h         |  153 +++++++++++
 8 files changed, 1013 insertions(+), 978 deletions(-)
