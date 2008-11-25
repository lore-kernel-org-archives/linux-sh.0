From: Matt Fleming <mjf@gentoo.org>
Date: Tue, 25 Nov 2008 20:11:06 +0000
Subject: Re: HP Jornada 600-series bisected
Message-Id: <20081125201106.GB11884@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
In-Reply-To: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 25, 2008 at 08:48:21PM +0100, Kristoffer Ericson wrote:
> 
> unsigned int hd64461_irq_demask(u16 mask)
> {
>     unsigned int i;
> 
> 	for (i = 1; i < 16; i++)
> 		if ((1 << i) & mask)
> 		break;
> 

Is there a reason that this starts from i = 1 and not i = 0?

> 
> void hd64461_irq_request(u16 mask, void (*fn)(int, void *), u16 trigger_mask)
> {
>     hd64461_irq_set_hand(mask, fn);
>     hd64461_irq_trigger(mask, trigger_mask);
>     hd64461_irq_enable(mask);
> }

I can't find any code in the kernel that registers with the current demux
code. Is this interface still necessary?

