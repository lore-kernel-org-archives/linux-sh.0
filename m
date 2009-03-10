From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 10 Mar 2009 06:52:59 +0000
Subject: [GIT PULL] sh updates for 2.6.29-rc8
Message-Id: <20090310065259.GE10393@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.29

Which contains:

Magnus Damm (1):
      video: deferred io cleanup fix for sh_mobile_lcdcfb

Nobuhiro Iwamatsu (1):
      sh: Add media/soc_camera.h to board setup of Renesas AP325RXA

 arch/sh/boards/board-ap325rxa.c  |    1 +
 drivers/video/sh_mobile_lcdcfb.c |    6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)
