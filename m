From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Wed, 06 Feb 2008 23:59:56 +0000
Subject: [PATCH] - SH/Dreamcast - additional patch to maple.h
Message-Id: <1202342396.6162.26.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1202337981.6162.8.camel@localhost.localdomain>
	 <1202338431.6162.15.camel@localhost.localdomain>
	 <20080206230127.GA9614@kroah.com>
	 <1202339114.6162.17.camel@localhost.localdomain>
	 <20080206232349.GA15654@kroah.com>
In-Reply-To: <20080206232349.GA15654@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Paul Mundt <lethal@users.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

This patch removes the now unneeded registration check variable from
struct maple_device. (This patch assumes the include/linux/maple.h file
has already been patched for whitespace errors by
http://lkml.org/lkml/2008/2/6/327)

Signed-off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>


diff --git a/include/linux/maple.h b/include/linux/maple.h
index 1334062..3f01e2b 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -56,7 +56,6 @@ struct maple_device {
 	unsigned char port, unit;
 	char product_name[32];
 	char product_licence[64];
-	int registered;
 	struct device dev;
 };

