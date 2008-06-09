From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Jun 2008 09:58:51 +0000
Subject: [GIT PULL] sh updates for 2.6.26-rc6
Message-Id: <20080609095851.GA12763@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.26.git

Which contains:

Nobuhiro Iwamatsu (1):
      sh: Fix compile error SH7763 setup code

Paul Mundt (1):
      sh: Add -mno-fdpic to default flags.

Yoshihiro Shimoda (2):
      usb: r8a66597-hcd: Add support for SH7723 USB host
      sh: add resource of USB host for SH7723

Yusuke.Goda (1):
      sh: Add SH7723 SCIF support

 arch/sh/Makefile                       |    2 +
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   41 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |    9 ++++---
 drivers/usb/host/Kconfig               |    8 +++---
 4 files changed, 52 insertions(+), 8 deletions(-)
