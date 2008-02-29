From: "Francis Moreau" <francis.moro@gmail.com>
Date: Fri, 29 Feb 2008 16:19:56 +0000
Subject: Re: Questions about the interrupt controller
Message-Id: <38b2ab8a0802290819v49980370q680f5aa9c04be5f2@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <38b2ab8a0802290508t5e20a0cmfd04e35f0fc533a3@mail.gmail.com>
In-Reply-To: <38b2ab8a0802290508t5e20a0cmfd04e35f0fc533a3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Manuel,

On Fri, Feb 29, 2008 at 4:32 PM, Manuel Lauss
<mano@roarinelk.homelinux.net> wrote:
>  Again, I can only tell for my SH7760 platform. You need to register your
>  own irq_chip with mask/unmask/mask_ack callbacks. On the SH7760, the
>  IRLs trigger as vectors 0-15, and one has to provide external logic to
>  do the irq masking/acking. SH7780 and newer IIRC provide an INTC
>  register for that.
>
>  This is code I use:
>

[snip]

But couldn't you use make_imask_irq() instead ?

>  > The documentation says: "Other compatible interrupt controllers can be
>  > cascaded with INTC.". Where can I find some details about that ?
>
>  have a look at set_irq_chained_handler() function, for example:
>

[snip]

Actually I'm wondering what does 'compatible' mean.... ?

Thanks
-- 
Francis
