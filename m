From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 27 Feb 2009 06:53:50 +0000
Subject: [GIT PULL] sh updates for 2.6.29-rc7
Message-Id: <20090227065350.GB28802@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.29

Which contains:

Kuninori Morimoto (1):
      serial: sh-sci: fix overrun error handling for SH7785 SCIF.

Paul Mundt (1):
      sh: ap325rxa: Revert ov772x support.

Tobias Klauser (1):
      sh: Storage class should be before const qualifier

 arch/sh/boards/board-ap325rxa.c        |   53 ++------------------------------
 arch/sh/kernel/cpu/sh2a/clock-sh7201.c |    4 +-
 drivers/serial/sh-sci.h                |    2 +-
 3 files changed, 6 insertions(+), 53 deletions(-)
