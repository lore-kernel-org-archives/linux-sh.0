From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 27 Aug 2009 01:53:24 +0000
Subject: Re: current kernel say "Unaligned kernel access on behalf"
Message-Id: <20090827015324.GB18826@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uocq2ghqd.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uocq2ghqd.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2009 at 10:36:58AM +0900, Kuninori Morimoto wrote:
> -------------------------------------------------
> Fixing up unaligned kernel access in "swapper" pid=0 pc=0x882dcf54 ins=0x6362   
> Fixing up unaligned kernel access in "swapper" pid=0 pc=0x882dcf9e ins=0x6176   
> Fixing up unaligned kernel access in "swapper" pid=0 pc=0x882dcfa0 ins=0x6276   
> -------------------------------------------------
> 
> If I use c3144fc46f987413df10e83659f0bf1aad76f79e
> It works well for me
> 
> what's happen ??

What happened is that I added a change that starts to report these fixups
for the kernel as well. Previously these were being just silently fixed
up. There is no change in functionality, they've just been added as a
debugging aid. Though in retrospect, KERN_NOTICE is probably the wrong
thing for kernel fixups, so I'll switch them over to KERN_DEBUG.
