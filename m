From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 21 Mar 2008 09:43:10 +0000
Subject: [PATCH 00/06] sh: Improved support for MigoR and sh7722
Message-Id: <20080321094310.10532.9209.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These patches improve support for MigoR and for the sh7722 processor.

[PATCH 01/06] sh: Add MigoR header file
[PATCH 02/06] sh: Use physical addresses for sh7722 USBF resources
[PATCH 03/06] sh: Move KEYSC platform data to sh7722
[PATCH 04/06] sh: Use phyical addresses for MigoR smc91x resources
[PATCH 05/06] sh: MigoR NOR flash support using physmap-flash
[PATCH 06/06] sh: MigoR NAND flash support using gen_flash

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/migor/setup.c   |  158 +++++++++++++++++++++++++-------
 arch/sh/boards/se/7722/setup.c         |   24 ----
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   33 +++++-
 include/asm-sh/migor.h                 |   58 +++++++++++
 4 files changed, 212 insertions(+), 61 deletions(-)
