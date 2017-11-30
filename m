From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 30 Nov 2017 13:12:00 +0000
Subject: [PATCH 3/5] tty: serial: sh-sci: Hide earlycon config question
Message-Id: <1512047522-16312-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Renesas H8/300 and ARM platforms use DT and support earlycon, so most
users want earlycon support to be enabled.

On SuperH platforms, earlycon is not yet supported.

Hence follow the above rationale to configure the default, unless
CONFIG_EXPERT is enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 0c75562d620feb82..952a2c6a9da08fdd 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -774,10 +774,11 @@ config SERIAL_SH_SCI_CONSOLE
 	default y
 
 config SERIAL_SH_SCI_EARLYCON
-	bool "Support for early console on SuperH SCI(F)"
+	bool "Support for early console on SuperH SCI(F)" if EXPERT
 	depends on SERIAL_SH_SCI=y
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
+	default ARCH_RENESAS || H8300
 
 config SERIAL_SH_SCI_DMA
 	bool "DMA support"
-- 
2.7.4

