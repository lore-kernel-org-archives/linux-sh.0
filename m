From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 03 Jun 2016 10:00:11 +0000
Subject: [PATCH v3 11/11] serial: sh-sci: Add DT support for dedicated RTS/CTS
Message-Id: <1464948011-377-12-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add support for indicating the availability of dedicated lines for
RTS/CTS hardware flow control, using the standard "uart-has-rtscts" DT
property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 02b240a02dc6a593..d9cb0d70fceef07d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2999,6 +2999,9 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 	p->regtype = SCI_OF_REGTYPE(match->data);
 	p->scscr = SCSCR_RE | SCSCR_TE;
 
+	if (of_find_property(np, "uart-has-rtscts", NULL))
+		p->capabilities |= SCIx_HAVE_RTSCTS;
+
 	return p;
 }
 
-- 
1.9.1

