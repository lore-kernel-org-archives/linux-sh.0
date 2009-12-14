From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Dec 2009 12:29:40 +0000
Subject: [PATCH 00/07] sh: break out scif platform data per port
Message-Id: <20091214122940.10707.63683.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: break out scif platform data per port

[PATCH 01/07] sh: sh2 scif pdata (sh7616)
[PATCH 02/07] sh: sh2a scif pdata (sh7201/sh7203/sh7206/mxg)
[PATCH 03/07] sh: sh3 scif pdata (sh7705/sh770x/sh7710/sh7720)
[PATCH 04/07] sh: sh4 scif pdata (sh7750/sh7760/sh4-202)
[PATCH 05/07] sh: sh4a scif pdata (sh7343/sh7366/sh7722/sh7723/sh7724)
[PATCH 06/07] sh: sh4a scif pdata (sh7757/sh7763/sh7770/sh7780/sh7785/sh7786/x3)
[PATCH 07/07] sh: sh5 scif pdata (sh5-101/sh5-103)

These patches break out the scif serial port platform data into
one platform device per port.

With these patches and the early serial support in place it is
possible to select the early serial console port with the kernel
command line. For example, to enable early serial console on KFR2R09,
simply add the following to the kernel command line:

"earlyprintk=sh-sci.1,115200".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/configs/rts7751r2d1_defconfig    |    2 
 arch/sh/configs/rts7751r2dplus_defconfig |    2 
 arch/sh/kernel/cpu/sh2/setup-sh7619.c    |   67 +++++----
 arch/sh/kernel/cpu/sh2a/setup-mxg.c      |   23 +--
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c   |  177 +++++++++++++++++-------
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c   |   89 ++++++++----
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c   |   89 ++++++++----
 arch/sh/kernel/cpu/sh3/setup-sh7705.c    |   45 +++---
 arch/sh/kernel/cpu/sh3/setup-sh770x.c    |   80 +++++++---
 arch/sh/kernel/cpu/sh3/setup-sh7710.c    |   44 +++--
 arch/sh/kernel/cpu/sh3/setup-sh7720.c    |   44 +++--
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c   |   23 +--
 arch/sh/kernel/cpu/sh4/setup-sh7750.c    |   47 +++---
 arch/sh/kernel/cpu/sh4/setup-sh7760.c    |   89 ++++++++----
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c   |  112 +++++++++------
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c   |   39 ++---
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c   |   91 +++++++-----
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c   |  160 ++++++++++++++-------
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c   |  145 +++++++++++++------
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c   |   92 ++++++++----
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c   |   81 ++++++----
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c   |  221 ++++++++++++++++++++++--------
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c   |   60 ++++----
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c   |  159 ++++++++++++++-------
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c   |  132 ++++++++++++-----
 arch/sh/kernel/cpu/sh4a/setup-shx3.c     |   76 +++++-----
 arch/sh/kernel/cpu/sh5/setup-sh5.c       |   22 +-
 27 files changed, 1455 insertions(+), 756 deletions(-)
