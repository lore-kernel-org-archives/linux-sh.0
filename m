From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Sun, 21 Sep 2008 13:24:21 +0000
Subject: Re: Kernel configurations for R2D PLUS with Compact Flush support
Message-Id: <48D64B05.3050202@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <48D60BEA.2040806@juno.dti.ne.jp>
In-Reply-To: <48D60BEA.2040806@juno.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thanks for your quick answers!
I've started to investigate pata_platform.c and libata-sff.c.
It will takes some time for me to understand them.

> Note that you can optionally just hand in 0 for the IRQ in order to
> disable IRQ mode and simply default to polling (which the following patch
> does).

Do you mean that polling by kernel will let us skip the implementation of
IRQ part of the CF support?  It sounds good to make progress step by step.

>> Any help or comments will be welcome.  Thanks.
>>
> I had the same idea on the flight back from kernel summit :-)
> 
> So, how about something like this for a start?

Good!  It will be the first part of the patches for CF support.

> +
> +    isa_ide_init(ide_iobase[0], ide_iobase[1], 0, hd[0], NULL);
> +

This part seems to cause a segmentation fault, perhaps you know.
I guess that the reason is that isa_ide_init() handles the iobase
as I/O port number, not a memory mapped I/O address.

hw/ide.c:pmac_init_ide() handles the memory mapped I/O.
So, instead of invoking isa_ide_init(), following (dirty) lines
will work to avoid the fault.

{
    int ide_memory = pmac_ide_init(&hd[0], 0 /* no irq */);
    cpu_register_physical_memory(ide_iobase[0], 0x1000, ide_memory);
}

Thanks again!

Regards,
Shin-ichiro KAWASAKI

