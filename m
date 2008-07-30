From: "Nobuhiro Iwamatsu" <iwamatsu@nigauri.org>
Date: Wed, 30 Jul 2008 02:44:22 +0000
Subject: Re: SH7760: early_printk build broken
Message-Id: <29ab51dc0807291944r20232d1apd7d67ad3d71916de@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080729142743.GA7017@roarinelk.homelinux.net>
In-Reply-To: <20080729142743.GA7017@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Manuel and Paul.

2008/7/30 Manuel Lauss <mano@roarinelk.homelinux.net>:
>
>> > > > Commit c63847a3621d2bac054f5709783860ecabd0ee7e ("sh: Add SCIF2 support for SH7763.")
>> > > > broke build with CONFIG_EARLY_PRINTK enabled for me (SH7760):
>> > > >
>> > > >   CC      arch/sh/kernel/early_printk.o
>> > > > /mnt/work/sh7760/kernel/linux-2.6.git/arch/sh/kernel/early_printk.c: In function 'scif_sercon_putc':
>> > > > /mnt/work/sh7760/kernel/linux-2.6.git/arch/sh/kernel/early_printk.c:84: error: implicit declaration of function 'sci_SCFDR_in'
>> > > >
>> > > > I don't know immediately how to fix it though, could you please take a look?
>> > > >
>> > > I see what happened. Proof that this file is such a ridiculous
>> > > clusterfuck it's hard to know where to even begin.
>> > >
Sorry, This is a problem of my patch.
I forgot a movement check of early_printk.
Because there is not SCFDR in SH7760 etc.
Of cource this problem has SH7760, SH7780 and SH7785.

I confirmed that I worked without a problem with the patch which
Paul wrote.

Thank you.

Nobuhiro
