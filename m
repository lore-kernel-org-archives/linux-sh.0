From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 11 Jan 2008 04:22:54 +0000
Subject: [GIT PULL] sh updates for 2.6.24-rc7
Message-Id: <20080111042254.GA30136@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.24.git

Which contains:

Carmelo Amoroso (1):
      sh: Fix argument page dcache flushing regression.

Paul Mundt (1):
      sh: Force __access_ok() to obey address space limit.

 include/asm-sh/cacheflush.h |    6 ++++++
 include/asm-sh/uaccess.h    |   42 +++++++++++++++---------------------------
 2 files changed, 21 insertions(+), 27 deletions(-)
