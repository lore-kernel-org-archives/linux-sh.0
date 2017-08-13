From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 13 Aug 2017 19:11:24 +0000
Subject: [PATCH repost] serial: sh-sci: use of_property_read_bool()
Message-Id: <20170813191134.674818373@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Use more compact of_property_read_bool() call for a boolean property
instead  of of_find_property() call in sci_parse_dt().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'tty-next' branch of GregKH's 'tty.git' repo.

Reposting as the previous posting dropped Greg's and Jiri's emails...

 drivers/tty/serial/sh-sci.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: tty/drivers/tty/serial/sh-sci.c
=================================--- tty.orig/drivers/tty/serial/sh-sci.c
+++ tty/drivers/tty/serial/sh-sci.c
@@ -3073,8 +3073,7 @@ static struct plat_sci_port *sci_parse_d
 	p->type = SCI_OF_TYPE(match->data);
 	p->regtype = SCI_OF_REGTYPE(match->data);
 
-	if (of_find_property(np, "uart-has-rtscts", NULL))
-		sp->has_rtscts = true;
+	sp->has_rtscts = of_property_read_bool(np, "uart-has-rtscts");
 
 	return p;
 }

