From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 03 Nov 2009 19:41:39 +0000
Subject: Re: illegal instructions / panic on sh7722
Message-Id: <20091103194139.GA4459@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0911031826460.5059@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0911031826460.5059@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 03, 2009 at 06:31:06PM +0100, Guennadi Liakhovetski wrote:
> Hi
> 
> After hours of semi-automatic bisect it turns out that this patch
> 
> From eb3118f652ea7751ecf6a7e467bb637895e3be3b Mon Sep 17 00:00:00 2001
> From: Matt Fleming <matt@console-pimps.org>
> Date: Thu, 29 Oct 2009 21:53:30 +0000
> Subject: [PATCH] sh: Do not apply virt_to_phys() to a physical address
> 
> The variable 'phys' already contains the physical address to flush. It
> is not a virtual address and should not be passed to virt_to_phys().
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> 
> panics on 7722 (migor) in linux-next, or produces illegal instructions 
> when it manages to boot.
>

Damn, sorry about that. Could you give us a log of the panic?
