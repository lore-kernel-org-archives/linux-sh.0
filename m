From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 08 Feb 2010 02:24:37 +0000
Subject: [GIT PULL] sh updates for 2.6.33-rc8
Message-Id: <20100208022437.GC6839@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This fixes up a number of crashes both with the unwinder and with booting
from USB mass storage on certain CPUs. While the unwinder fixups aren't
technically regression fixes, they address a fairly long-standing set of
bugs. The HCD changes fix a fairly long-standing regression that was only
recently reported.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.33

Which contains:

Matt Fleming (4):
      sh: Correct the offset of the return address in ret_from_exception
      sh: Setup frame pointer in handle_exception path
      sh: Don't continue unwinding across interrupts
      sh: Remove superfluous setup_frame_reg call

Paul Mundt (2):
      usb: r8a66597-hcd: Flush the D-cache for the pipe-in transfer buffers.
      usb: r8a66597-hcd: Fix up spinlock recursion in root hub polling.

 arch/sh/kernel/cpu/sh3/entry.S  |    3 +-
 arch/sh/kernel/dwarf.c          |   20 +++++++++++++++++++
 arch/sh/kernel/entry-common.S   |    8 ++++++-
 drivers/usb/host/r8a66597-hcd.c |   41 +++++++++++++++++++++++++++-----------
 4 files changed, 58 insertions(+), 14 deletions(-)
