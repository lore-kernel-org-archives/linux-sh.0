From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Thu, 09 Apr 2009 02:51:26 +0000
Subject: Re: Question about sh-sci on SH7723
Message-Id: <49DD62AE.2090700@renesas.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040903000409030809090001"
List-Id: <linux-sh.vger.kernel.org>
References: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------040903000409030809090001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

morimoto.kuninori@renesas.com wrote:
> Dear yoshii
> 
> Thank you for comment
> 
>>> I have question about sh-sci on SH7723.
>> ...
>>> seems return SCIF0_TXD value.
>> At least, old chips like 7709/7750 have SCPTR bit multiplexed.
>> It returns RXD when read, sets TxD when write.
> 
> Hmm.
> At least 7786/7785/7763 have SCSPTR register.
> It indicates RXD/TXD for me.
> 
> May be it is same as  7709/7750's SCPTR.
> (I don't have these manual)

You can get these from renesas website.

> 
>> What are SCPTR bits on SH7723 like?
> 
> But SH7723 doesn't have SCPTR/SCSPTR register.
> Therefore, I thought that it used IO port.
> 
> So, I thought that it should read RXD pin if it use IO port.
> 
>> # I think you would better asking your boss to put the HW manual on WWW.
> 
> Oops !
> Is SH7723's manual un-public one ?
> 

I think that this is coding miss.
If you check implemenation of other SH CPU's(e.g. SH7722),
you can understand that other CPU checked RXD bit.

I attached patch to fix this.

Best regards,
  Nobuhiro


--------------040903000409030809090001
Content-Type: text/plain;
 name="0001-sh-Fix-rxd-check-bit-of-sci_rxd_in-for-sh7723.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-sh-Fix-rxd-check-bit-of-sci_rxd_in-for-sh7723.patch"

From 9dcbe0f455229250daa353d6b199d6f41b457e05 Mon Sep 17 00:00:00 2001
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Wed, 8 Apr 2009 16:10:19 +0900
Subject: [PATCH] sh: Fix rxd check bit of sci_rxd_in for sh7723

Reported-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/serial/sh-sci.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index d0aa82d..cc51500 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -591,15 +591,15 @@ static inline int sci_rxd_in(struct uart_port *port)
 static inline int sci_rxd_in(struct uart_port *port)
 {
         if (port->mapbase == 0xffe00000)
-                return ctrl_inb(SCSPTR0) & 0x0008 ? 1 : 0; /* SCIF0 */
+                return ctrl_inb(SCSPTR0) & 0x0010 ? 1 : 0; /* SCIF0 */
         if (port->mapbase == 0xffe10000)
-                return ctrl_inb(SCSPTR1) & 0x0020 ? 1 : 0; /* SCIF1 */
+                return ctrl_inb(SCSPTR1) & 0x0040 ? 1 : 0; /* SCIF1 */
         if (port->mapbase == 0xffe20000)
-                return ctrl_inb(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF2 */
+                return ctrl_inb(SCSPTR2) & 0x0002 ? 1 : 0; /* SCIF2 */
         if (port->mapbase == 0xa4e30000)
-                return ctrl_inb(SCSPTR3) & 0x0001 ? 1 : 0; /* SCIF3 */
+                return ctrl_inb(SCSPTR3) & 0x0002 ? 1 : 0; /* SCIF3 */
         if (port->mapbase == 0xa4e40000)
-                return ctrl_inb(SCSPTR4) & 0x0001 ? 1 : 0; /* SCIF4 */
+                return ctrl_inb(SCSPTR4) & 0x0002 ? 1 : 0; /* SCIF4 */
         if (port->mapbase == 0xa4e50000)
                 return ctrl_inb(SCSPTR5) & 0x0008 ? 1 : 0; /* SCIF5 */
         return 1;
-- 
1.6.2.2


--------------040903000409030809090001--
