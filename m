From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 08 May 2009 14:33:12 +0000
Subject: Re: [PATCH 000/013] sh-sci: platform device, clock and console changes
Message-Id: <20090508143312.GB12373@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 22, 2009 at 12:13:34AM +0900, Magnus Damm wrote:
> sh-sci: platform device, clock and console changes
> 
> [PATCH 001/013] sh-sci: add platform device private data
> [PATCH 002/013] sh-sci: allow single port platform devices
> [PATCH 003/013] sh-sci: remove early_sci_setup()
> [PATCH 004/013] sh-sci: rework serial console support
> [PATCH 005/013] sh-sci: replace sci_init_ports()
> [PATCH 006/013] sh-sci: ioremap() in a single place 
> [PATCH 007/013] sh-sci: improve clock framework support
> [PATCH 008/013] sh-sci: use to_sci_port() if possible
> [PATCH 009/013] sh-sci: convert sh2 cpu to single port devices
> [PATCH 010/013] sh-sci: convert sh2a cpus to single port devices
> [PATCH 011/013] sh-sci: convert sh3 cpus to single port devices
> [PATCH 012/013] sh-sci: convert sh4 cpus to single port devices
> [PATCH 013/013] sh-sci: sh4a single port devices and clock support
> 
> These patches modify the sh-sci driver / SuperH arch as follows:
> - make one platform device per port
> - rework console code
> - improve clock framework support for SuperH Mobile processors
> - various cleanups
> 
> I have a few more patches on top of this that implements early
> printk support using early platform devices.
> 
This series took a bit of wiggling to get in to shape, but the bulk of it
is there now, with the exception of all of the single port platform
device patches, as that's not something I have any intention of merging.
