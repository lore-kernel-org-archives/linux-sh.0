From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 15 Jul 2008 09:50:45 +0000
Subject: Re: booting 2.6 on edosk7760
Message-Id: <20080715095045.GA23910@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

(Adding the mailing list to Cc, don't send me these things off-list..)

On Tue, Jul 15, 2008 at 11:43:31AM +0200, Luca Santini wrote:
> i'm trying to boot the sh branch of 2.6.26 kernel on an edosk7760.
> keeping it unchanged and configuring for sh7760 the only thing i have is 
> a whitespace (' '<cursor>) .
> 
> So i tried to port the board specific configuration, following your 
> new_machine.txt and copying things from arch/sh/edosk7760 i found on my 
> original 2.4.21 kernel....
> ..but the result is the same.....
> 
> where can i start the debugging?
> what's the early stages execution flow of the 2.6 kernel? (is 
> arch/sh/compressed/boot/head_32.S the first one executed?)
> when <at what point of execution> can i see the first output on the console?
> 
> thanks a lot for all the answers...
> 
> Luca Santini

It's fairly uncommon to have any problems in the decompression code, so
your best bet is probably to start looking at arch/sh/kernel/head_32.S,
arch/sh/kernel/cpu/init.c, and arch/sh/kernel/setup.c. If your board is
using sh-ipl+g you can trivially use the early printk with that,
otherwise you will need to see about getting the early SCIF console
working on your particular platform. You can grep for earlyprintk in
arch/sh/configs to get an idea of usage.
