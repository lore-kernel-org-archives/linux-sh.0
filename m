From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 20 Dec 2011 08:24:15 +0000
Subject: [GIT PULL] sh fixes for 3.2-rc7
Message-Id: <20111220082415.GA25648@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

        git://github.com/pmundt/linux-sh.git sh-fixes-for-linus

Which contains:

Yoshihiro Shimoda (1):
      sh: fix build warning in board-sh7757lcr

 arch/sh/boards/board-sh7757lcr.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)
