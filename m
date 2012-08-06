From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Aug 2012 08:19:12 +0000
Subject: Re: [PATCH] ARM: shmobile: mackerel: fixup usb module order
Message-Id: <20120806081911.GP18095@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87obmoefn2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87obmoefn2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Aug 05, 2012 at 10:47:00PM -0700, Kuninori Morimoto wrote:
> renesas_usbhs driver can play role as both Host and Gadget.
> In case of Gadget, it requires not only renesas_usbhs
> but also usb gadget module (like g_ether).
> So, renesas_usbhs driver calls usb_add_gadget_udc() on probe time.
> 
> Because of this behavior,
> Host port plays also Gadget role if kernel has both Host/Gadget support.
> 
> In mackerel case, from 0ada2da51800a4914887a9bcf22d563be80e50be
> (ARM: mach-shmobile: mackerel: use renesas_usbhs instead of r8a66597_hcd)
> usb0 plays Gadget role, and usb1 plays Host role,
> and current mackerel board probes as usb1 -> usb0.
> Thus, 1st installed usb gadget module (like g_ether) will be
> assigned to usb1 (= usb Host port), and 2nd module to usb0 (= usb Gadget port).
> It is very confusable for user.
> This patch fixup usb modes probing order as usb0 -> usb1.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Simon Horman <horms@verge.net.au>
