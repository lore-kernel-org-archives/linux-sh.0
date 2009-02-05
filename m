From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Thu, 05 Feb 2009 12:04:52 +0000
Subject: INTC issue
Message-Id: <498AD5E4.8050809@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I found INTC issue. For example, an interrupt is prohibited when I handle it as follows.

 1) Driver A call request_irq of DMAC ch0
 2) Driver B call request_irq of DMAC ch1.
 3) Driver A call free_irq of DMAC ch0.
 4) Driver B use DMAC ch1, but DMAC ch1 interrupt disabled.

The interrupt mask register of SH7785 is INT2MSKR.
The bit 11 of INT2MSKR is DMAC channels 0 to 5 interrupts mask bit.

I think that it is necessary to count the number of times admitted
an interrupt to solve this problem. I think that intc have a counter
every interrupt bit for a simple implementation method, but there
is much waste.

Any ideas?

Thanks,
Yoshihiro Shimoda
