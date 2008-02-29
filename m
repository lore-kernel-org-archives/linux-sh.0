From: "Francis Moreau" <francis.moro@gmail.com>
Date: Fri, 29 Feb 2008 20:02:15 +0000
Subject: Re: Questions about the interrupt controller
Message-Id: <38b2ab8a0802291202x3988d576h5c7c4c5978866e0a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <38b2ab8a0802290508t5e20a0cmfd04e35f0fc533a3@mail.gmail.com>
In-Reply-To: <38b2ab8a0802290508t5e20a0cmfd04e35f0fc533a3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 29, 2008 at 6:20 PM, Manuel Lauss
<mano@roarinelk.homelinux.net> wrote:
> Francis Moreau wrote:
>  > But couldn't you use make_imask_irq() instead ?
>
>  Yes, that works too; at least for the IRL irqs if the source does not
>  have to be acked (CF cards).
>

What do you mean by "the source doesn't have to be acked" ?

The possible case where it couldn't be used is when the irqs are edge
triggered.

Another drawback is that we can't mask one single IRL irq but we have
to mask all IRQs whose priority are less than the IRL irq's priority,

>
>
>  >>  > The documentation says: "Other compatible interrupt controllers can be
>  >>  > cascaded with INTC.". Where can I find some details about that ?
>  >>
>  >>  have a look at set_irq_chained_handler() function, for example:
>  >>
>  >
>  > [snip]
>  >
>  > Actually I'm wondering what does 'compatible' mean.... ?
>
>  4 lines which are pulled low to signal IRQ condition and the ~bitmask of
>  those 4 lines indicates the number of the irq to trigger?
>  Thats my understanding of how it works...
>

Do you know any datasheets out there describing this ?

In the same vein, could you point out some good documents about the SH
architecture ? The ones available from Renesas web site aren't very good
IMHO

Thanks Manuel
-- 
Francis
