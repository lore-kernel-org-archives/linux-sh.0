From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 08 Oct 2013 04:24:27 +0000
Subject: [PATCH] serial8250-em: convert to clk_prepare/unprepare
Message-Id: <1381206268-3914-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Greg,

please consider this enhancement from Kuribayashi-san for serial8250-em.

Also, please let me know if you would like us to handle serial patches
a different way.

Shinya Kuribayashi (1):
  serial8250-em: convert to clk_prepare/unprepare

 drivers/tty/serial/8250/8250_em.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.4

