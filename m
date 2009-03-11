From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 11 Mar 2009 08:14:26 +0000
Subject: [PATCH] sh: improve sh7785lcr power off code
Message-Id: <20090311081426.2031.70713.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Improve the sh7785lcr power off implementation to
never return. It takes some time before the board
is actually powered off, just hang after asking
the harware to power down.

This removes the serial port garbage printout.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/board-sh7785lcr.c |    3 +++
 1 file changed, 3 insertions(+)

--- 0001/arch/sh/boards/board-sh7785lcr.c
+++ work/arch/sh/boards/board-sh7785lcr.c	2009-03-11 15:15:52.000000000 +0900
@@ -284,6 +284,9 @@ static void sh7785lcr_power_off(void)
 	}
 	*p = 0x01;
 	iounmap(p);
+	set_bl_bit();
+	while (1)
+		cpu_relax();
 }
 
 /* Initialize the board */
