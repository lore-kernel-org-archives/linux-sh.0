From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 04 Jun 2013 05:45:06 +0000
Subject: Re: [PATCH v8 2/3] ARM: shmobile: r8a7778: add USB support
Message-Id: <87zjv64eg1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201306020206.47199.sergei.shtylyov@cogentembedded.com>
 <201306020210.37520.sergei.shtylyov@cogentembedded.com>
 <87bo7ooxc9.wl%kuninori.morimoto.gx@renesas.com>
 <51AC6C78.7020900@cogentembedded.com>
In-Reply-To: <51AC6C78.7020900@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi

> > The ohci/ehci resource will be  used vainly if platform doesn't have USB
> 
>     The platform device resources are never used vainly. And remember 
> that if PHY doesn't get registered, OHCI/EHCI won't get probed 
> successfully either -- mind the usb_power_on() platform method.

?
Could you please teach me who/how/when free resource memory
which was kmemdup'ed by platform_device_add_xxx()
(and kmalloc'ed dma_mask) on platform_device_register_full() ??

>> ohci/ehci and phy should be registered in same time/function.
>
>    I just copied your approach from the R8A7779 code.

Ahh, yes, indeed


Best regards
---
Kuninori Morimoto
