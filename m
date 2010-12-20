From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Dec 2010 16:14:24 +0000
Subject: [GIT PULL] rmobile updates for 2.6.37-rc7
Message-Id: <20101220161424.GA30652@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101108011327.GA10728@linux-sh.org>
In-Reply-To: <20101108011327.GA10728@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git rmobile-fixes-for-linus

Which contains:

Magnus Damm (2):
      ARM: mach-shmobile: fix compile warning in mm/init.c
      ARM: mach-shmobile: INTC interrupt priority level demux fix

 arch/arm/mach-shmobile/include/mach/entry-macro.S |   30 ++++++++++++++++++---
 arch/arm/mach-shmobile/include/mach/vmalloc.h     |    2 +-
 2 files changed, 27 insertions(+), 5 deletions(-)
