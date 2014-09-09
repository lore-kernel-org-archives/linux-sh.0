From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Tue, 09 Sep 2014 18:07:27 +0000
Subject: [PATCH 2/3] sh/uapi: Add definition of TIOC[SG]RS485
Message-Id: <1410286047-24900-1-git-send-email-ricardo.ribalda@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Commit: e676253b19b2d269cccf67fdb1592120a0cd0676 (serial/8250: Add
support for RS485 IOCTLs), adds support for RS485 ioctls for 825_core on
all the archs. Unfortunaltely the definition of TIOCSRS485 and
TIOCGRS485 was missing on the ioctls.h file

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 arch/sh/include/uapi/asm/ioctls.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/include/uapi/asm/ioctls.h b/arch/sh/include/uapi/asm/ioctls.h
index 3422410..2ce75622 100644
--- a/arch/sh/include/uapi/asm/ioctls.h
+++ b/arch/sh/include/uapi/asm/ioctls.h
@@ -83,6 +83,8 @@
 #define TCSETS2		_IOW('T', 43, struct termios2)
 #define TCSETSW2	_IOW('T', 44, struct termios2)
 #define TCSETSF2	_IOW('T', 45, struct termios2)
+#define TIOCGRS485	0x542E
+#define TIOCSRS485	0x542F
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 #define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
-- 
2.1.0

