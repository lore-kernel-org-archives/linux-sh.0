From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Tue, 29 Jul 2008 14:27:43 +0000
Subject: SH7760: early_printk build broken
Message-Id: <20080729142743.GA7017@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Iwamatsu-san,

Commit c63847a3621d2bac054f5709783860ecabd0ee7e ("sh: Add SCIF2 support for SH7763.")
broke build with CONFIG_EARLY_PRINTK enabled for me (SH7760):

  CC      arch/sh/kernel/early_printk.o
/mnt/work/sh7760/kernel/linux-2.6.git/arch/sh/kernel/early_printk.c: In function 'scif_sercon_putc':
/mnt/work/sh7760/kernel/linux-2.6.git/arch/sh/kernel/early_printk.c:84: error: implicit declaration of function 'sci_SCFDR_in'

I don't know immediately how to fix it though, could you please take a look?

Thank you,
	Manuel Lauss
