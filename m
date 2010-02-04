From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Thu, 04 Feb 2010 09:22:52 +0000
Subject: Re: [PATCH] usb: r8a66597-hdc: Flush the D-cache for the pipe-in
Message-Id: <4B6A91EC.5030201@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100204065758.GA5574@linux-sh.org>
In-Reply-To: <20100204065758.GA5574@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> This implements the same D-cache flushing logic for r8a66597-hcd as
> Catalin's isp1760 (http://patchwork.kernel.org/patch/76391/) change,
> with the same note applying here as well:
> 
>     When the HDC driver writes the data to the transfer buffers it
>     pollutes the D-cache (unlike DMA drivers where the device writes
>     the data). If the corresponding pages get mapped into user space,
>     there are no additional cache flushing operations performed and
>     this causes random user space faults on architectures with
>     separate I and D caches (Harvard) or those with aliasing D-cache.
> 
> This fixes up crashes during USB boot on SH7724 and others:
> 
> 	http://marc.info/?l=linux-sh&m6439837308912&w=2
> 
> Reported-by: Goda Yusuke <goda.yusuke@renesas.com>
> Tested-by: Goda Yusuke <goda.yusuke@renesas.com>
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> 
> ---
> 
> Shimoda-san, once you Ack these I plan to send them off to Linus for 2.6.33.

Thank you very much for your help.
Acked-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

Thanks,
Yoshihiro Shimoda

