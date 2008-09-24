From: Michael Trimarchi <trimarchimichael@yahoo.it>
Date: Wed, 24 Sep 2008 14:52:05 +0000
Subject: SH7722 serial scif
Message-Id: <878566.91579.qm@web26201.mail.ukl.yahoo.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I find a problem releated to the scif serial device. Using scif2 on the MigoR, the kernel block on the second open of the device
when it try to register irq line. So in the shutdown sequence I add:

 sci_out(port, SCSCR, 0x00);

and in the startup squence:

 sci_out(port, SCSCR, SCSCR_INIT(port));

The version is 2.6.24.2 but I think is present in the latest release too.

My idea is to post a patch to register and enable and disable for the scif port on the SH7722. Can be a problem
for other micro?

Regards Michael

__________________________________________________
Do You Yahoo!?
Poco spazio e tanto spam? Yahoo! Mail ti protegge dallo spam e ti da tanto spazio gratuito per i tuoi file e i messaggi 
http://mail.yahoo.it 
