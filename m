From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 14 Jan 2010 23:45:04 +0000
Subject: [GIT PULL] sh updates for 2.6.33-rc5
Message-Id: <20100114234504.GC25018@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.33

Which contains:

Markus Pietrek (1):
      serial: sh-sci: using correct fifo size for SCIF and SCIFA ports.

NISHIMOTO Hiroki (1):
      sh: mach-ecovec24: Add motion sensor driver support.

 arch/sh/boards/mach-ecovec24/setup.c |    8 ++++++++
 drivers/serial/sh-sci.c              |   13 ++++++++++++-
 2 files changed, 20 insertions(+), 1 deletions(-)
