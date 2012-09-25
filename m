From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Sep 2012 14:42:07 +0000
Subject: [GIT PULL] sh fixes for 3.6-final
Message-Id: <20120925144207.GK13568@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

One last minute regression fix..

The following changes since commit 56d27adcb536b7430d5f8a6240df8ad261eb00bd:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile (2012-09-24 16:17:17 -0700)

are available in the git repository at:


  git://github.com/pmundt/linux-sh tags/sh-for-linus

for you to fetch changes up to 16d74ebeb1b056dfc80e69b44cc3a26515db1925:

  sh: pfc: Fix up GPIO mux type reconfig case. (2012-09-25 11:51:05 +0900)

----------------------------------------------------------------
SuperH fixes for 3.6-final

----------------------------------------------------------------
Paul Mundt (1):
      sh: pfc: Fix up GPIO mux type reconfig case.

 drivers/sh/pfc/pinctrl.c | 2 ++
 1 file changed, 2 insertions(+)
