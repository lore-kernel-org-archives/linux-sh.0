From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 02 Feb 2011 23:42:29 +0000
Subject: Re: [PATCH] sh: Provide in/out{b,w,l}
Message-Id: <20110202234229.GB11610@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1296630315-21264-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1296630315-21264-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 02, 2011 at 04:05:15PM +0900, Nobuhiro Iwamatsu wrote:
> By commit 37b7a97884ba64bf7d403351ac2a9476ab4f1bba,
> delete machvec IO routines.
> Because the definition of in/out_{b,w,l} was deleted,
> driver needing these cannot build.
> This defines it again.
> 
Wrong. Please actually study the change and try to figure out what it is
doing before re-introducing stuff it intentionally removed.

The only time we have PIO is when PCI is available, anything else is just
broken wrapping in to MMIO due to drivers using legacy PIO accessors.
These are now few enough that it's trivial to simply fix up the drivers
accordingly.

If IOPORT support is enabled (by way of CONFIG_PCI) then all of the PIO
routines likewise become available -- these are constructed by the
BUILDIO_IOPORT macro. The PIO offsets in question are then relative to
the PCI channel's I/O base.

It took us years to get rid of all of the crap SuperIO fake PIO nonsense,
any attempt to re-add bogus PIO routines in an IOMEM only configuration
are fundamentally broken.
