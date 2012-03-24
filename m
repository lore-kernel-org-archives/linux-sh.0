From: Adrian McMenamin <lkmladrian@gmail.com>
Date: Sat, 24 Mar 2012 16:55:53 +0000
Subject: [PATCH] Add VMUFAT file system support (v2)
Message-Id: <CAN628AH-h=G3e7U8-Tmcok0dtAQd1+GBfvTP72ecB5J17vuXcg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@zeniv.linux.org.uk, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linux-sh <linux-sh@vger.kernel.org>

Sega Dreamcasts come with a "visual memory unit" (VMU) with 128KB of
flash memory in a FAT type filesystem. This patch adds support for
this filesystem to the Linux kernel.

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>
---

 Documentation/filesystems/vmufat.txt |   83 ++++
 fs/Kconfig                           |    1 +
 fs/Makefile                          |    1 +
 fs/vmufat/Kconfig                    |   14 +
 fs/vmufat/Makefile                   |    7 +
 fs/vmufat/inode.c                    |  903 ++++++++++++++++++++++++++++++++++
 fs/vmufat/super.c                    |  522 ++++++++++++++++++++
 fs/vmufat/vmufat.h                   |  115 +++++
 include/linux/magic.h                |    1 +
 9 files changed, 1647 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/filesystems/vmufat.txt
 create mode 100644 fs/vmufat/Kconfig
 create mode 100644 fs/vmufat/Makefile
 create mode 100644 fs/vmufat/inode.c
 create mode 100644 fs/vmufat/super.c
 create mode 100644 fs/vmufat/vmufat.h


Patch may be pulled/reviewed at:

https://github.com/mcmenaminadrian/vmufat/commit/47305b24487ce6d6d9264bddf2ccf75e5123c1b1
