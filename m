From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Mar 2014 10:11:18 +0000
Subject: [PATCH 2/4] serial: sh-sci: Remove useless casts
Message-Id: <1394532680-4264-2-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1394532680-4264-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394532680-4264-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/tty/serial/sh-sci.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 24ec6ef67984..4529dbca2287 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2423,25 +2423,25 @@ struct sci_port_info {
 static const struct of_device_id of_sci_match[] = {
 	{
 		.compatible = "renesas,scif",
-		.data = (void *)&(const struct sci_port_info) {
+		.data = &(const struct sci_port_info) {
 			.type = PORT_SCIF,
 			.regtype = SCIx_SH4_SCIF_REGTYPE,
 		},
 	}, {
 		.compatible = "renesas,scifa",
-		.data = (void *)&(const struct sci_port_info) {
+		.data = &(const struct sci_port_info) {
 			.type = PORT_SCIFA,
 			.regtype = SCIx_SCIFA_REGTYPE,
 		},
 	}, {
 		.compatible = "renesas,scifb",
-		.data = (void *)&(const struct sci_port_info) {
+		.data = &(const struct sci_port_info) {
 			.type = PORT_SCIFB,
 			.regtype = SCIx_SCIFB_REGTYPE,
 		},
 	}, {
 		.compatible = "renesas,hscif",
-		.data = (void *)&(const struct sci_port_info) {
+		.data = &(const struct sci_port_info) {
 			.type = PORT_HSCIF,
 			.regtype = SCIx_HSCIF_REGTYPE,
 		},
-- 
1.7.9.5

