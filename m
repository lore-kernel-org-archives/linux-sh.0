From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 22 May 2009 05:26:34 +0000
Subject: [GIT PULL] sh updates for 2.6.30-rc7
Message-Id: <20090522052634.GA14059@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.30

Which contains:

Magnus Damm (2):
      sh: ap325 camera without i2c driver fix
      video: stop sh_mobile_lcdcfb only if started

 arch/sh/boards/board-ap325rxa.c  |    3 +++
 drivers/video/sh_mobile_lcdcfb.c |    7 ++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)
