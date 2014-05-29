From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 May 2014 13:17:21 +0000
Subject: [PATCH v2 03/05] staging: emxx_udc: Add TODO file
Message-Id: <20140529131721.2329.87388.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140529131650.2329.3197.sendpatchset@w520>
In-Reply-To: <20140529131650.2329.3197.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devel@driverdev.osuosl.org, linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, olof@lixom.net, Magnus Damm <magnus.damm@gmail.com>, dan.carpenter@oracle.com

From: Magnus Damm <damm+renesas@opensource.se>

Add a TODO file for emxx_udc to show what is left to do.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - New patch

 drivers/staging/emxx_udc/TODO |    4 ++++
 1 file changed, 4 insertions(+)

--- /dev/null
+++ work/drivers/staging/emxx_udc/TODO	2014-05-29 18:08:58.000000000 +0900
@@ -0,0 +1,4 @@
+* add clock framework support (platform device with CCF needs special care)
+* break out board-specific VBUS GPIO to work with multiplatform
+* DT bindings
+* move driver into drivers/usb/gadget/
