From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 06 Dec 2013 09:59:14 +0000
Subject: [PATCH 07/47] serial: sh-sci: Set the UPF_FIXED_PORT flag
Message-Id: <1386323994-12850-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>

The base address, IRQ and baud rate generator parent clock rate can't be
changed by userspace. Mark the port as fixed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3e5f62a..b5dd0ad 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2247,7 +2247,7 @@ static int sci_init_single(struct platform_device *dev,
 
 	port->mapbase		= p->mapbase;
 	port->type		= p->type;
-	port->flags		= p->flags;
+	port->flags		= UPF_FIXED_PORT | p->flags;
 	port->regshift		= p->regshift;
 
 	/*
-- 
1.8.3.2

