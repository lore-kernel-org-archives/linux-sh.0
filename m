From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 01 Aug 2012 08:15:32 +0000
Subject: Re: [PATCH 1/2] sh: sh7724: fixup renesas_usbhs clock settings
Message-Id: <20120801081532.GA9596@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <873947dp3o.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <873947dp3o.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 01, 2012 at 12:54:22AM -0700, Kuninori Morimoto wrote:
> 8cc88a55b03bd4940390125c2521c99368513be5
> (sh: sh7724: use runtime PM implementation) broke sh7724 clocks.
> 
> renesas_usbhs needs HWBLK_USB0/1 clock on sh7724
> 

On Wed, Aug 01, 2012 at 12:54:58AM -0700, Kuninori Morimoto wrote:
> renesas_usbhs driver can control both USB Host/Gadget,
> but it needs VBUS output if Host mode.

Both applied, thanks.
