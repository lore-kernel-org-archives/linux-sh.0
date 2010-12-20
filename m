From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Dec 2010 16:14:22 +0000
Subject: [GIT PULL] sh updates for 2.6.37-rc7
Message-Id: <20101220161422.GA30628@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh-fixes-for-linus

Which contains:

Takashi YOSHII (1):
      clocksource: sh_cmt: Remove nested spinlock fix

 drivers/clocksource/sh_cmt.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)
