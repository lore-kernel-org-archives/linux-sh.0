From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Mar 2009 17:28:54 +0000
Subject: Re: read/write[bwl] endian conversion for big-endian PCI ?
Message-Id: <20090309172854.GA3546@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49B4E27C.4050108@renesas.com>
In-Reply-To: <49B4E27C.4050108@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 09, 2009 at 06:33:48PM +0900, Takashi Yoshii wrote:
> Reading the source code drivers/nic/r8169.c, 
> what I can guess about the system it has been written for, are
> 
> 1. Data structures transfered by PCI DMA are little endian.
>  It users explicit conversion when accessing descriptors.
> 
> 2. Data read/written by PCI target transfer are big(=cpu) endian.
>  MMIO registers are accessed read/write[bwl] without conversion.
>  Or perhaps read/write[bwl]() do the conversion.
>  I'v found some of powerPC platforms have such code for PCI space.
> 
> Because PCI is defined only for little-endian, endian conversion which
> PCI bridge on big-endian hardware provides can vary.
> I know I can not help conversion tasks depend on each platforms.
> 
This is a pretty common problem, we just haven't run in to it much in the
past since almost no one uses any PCI-capable SH part in big-endian mode.

Take a look at the CONFIG_SWAP_IO_SPACE on mips, we should be able to do
something pretty similar without much hassle.
