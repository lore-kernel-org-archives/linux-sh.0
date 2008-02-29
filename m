From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Fri, 29 Feb 2008 20:35:14 +0000
Subject: Re: Questions about the interrupt controller
Message-Id: <47C86C82.3060908@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <38b2ab8a0802290508t5e20a0cmfd04e35f0fc533a3@mail.gmail.com>
In-Reply-To: <38b2ab8a0802290508t5e20a0cmfd04e35f0fc533a3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

  > The possible case where it couldn't be used is when the irqs are edge
> triggered.
> 
> Another drawback is that we can't mask one single IRL irq but we have
> to mask all IRQs whose priority are less than the IRL irq's priority,

According to the SH7760 datasheet, the INTC compares the priority of 
_every_ interrupt (IRL, On-chip peripheral) to the IMASK register. If 
IRQ priority is HIGHER than the level set in IMASK then the interrupt is
accepted and the exception handler is invoked.

So no, I don't believen you can have a "sane" IRL irq handling scheme
only with IMASK irq chip.

>>  >>  > The documentation says: "Other compatible interrupt controllers can be
>>  >>  > cascaded with INTC.". Where can I find some details about that ?
>>  >>
>>  >>  have a look at set_irq_chained_handler() function, for example:
>>  >>
>>  >
>>  > [snip]
>>  >
>>  > Actually I'm wondering what does 'compatible' mean.... ?
>>
>>  4 lines which are pulled low to signal IRQ condition and the ~bitmask of
>>  those 4 lines indicates the number of the irq to trigger?
>>  Thats my understanding of how it works...
>>
> 
> Do you know any datasheets out there describing this ?

Take the SH7751/SH7760/SH7780 datasheets for example, it's described in 
the INTC chapter (Page 217 of the 7760 manual).

> In the same vein, could you point out some good documents about the SH
> architecture ? The ones available from Renesas web site aren't very good
> IMHO

Maybe ST has some manuals for their ST40 based parts (also SH4 variants)
on their site.

-- 
  ml.
