From: Rich Felker <dalias@libc.org>
Date: Mon, 23 May 2016 21:03:29 +0000
Subject: Re: [PATCH v2 02/12] of: add J-Core cpu bindings
Message-Id: <20160523210328.GE21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
 <f3c89e4834665790ff13478c571cc9aaa9de5559.1463708766.git.dalias@libc.org>
 <20160523204846.GA16081@rob-hp-laptop>
In-Reply-To: <20160523204846.GA16081@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>

On Mon, May 23, 2016 at 03:48:46PM -0500, Rob Herring wrote:
> On Fri, May 20, 2016 at 02:53:03AM +0000, Rich Felker wrote:
> > Signed-off-by: Rich Felker <dalias@libc.org>
> > ---
> >  Documentation/devicetree/bindings/jcore/cpus.txt | 91 ++++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/jcore/cpus.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/jcore/cpus.txt b/Documentation/devicetree/bindings/jcore/cpus.txt
> > new file mode 100644
> > index 0000000..00ef112
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/jcore/cpus.txt
> > @@ -0,0 +1,91 @@
> > +=========> > +J-Core cpu bindings
> > +=========> > +
> > +The J-Core processors are open source CPU cores that can be built as FPGA
> > +soft cores or ASICs. The device tree is also responsible for describing the
> > +cache controls and, for SMP configurations, all details of the SMP method,
> > +as documented below.
> > +
> > +
> > +---------------------
> > +Top-level "cpus" node
> > +---------------------
> > +
> > +Required properties:
> > +
> > +- #address-cells: Must be 1.
> > +
> > +- #size-cells: Must be 0.
> > +
> > +Optional properties:
> > +
> > +- enable-method: Required only for SMP systems. If present, must be
> > +  "jcore,spin-table".
> > +
> > +
> > +--------------------
> > +Individual cpu nodes
> > +--------------------
> > +
> > +Required properties:
> > +
> > +- device_type: Must be "cpu".
> > +
> > +- compatible: Must be "jcore,j2".
> 
> Okay to have this, but you should have compatible strings for specific 
> core implementations. AIUI, J2 is just the ISA.

There was some past discussion you probably missed on the linux-sh
list, starting here:

http://www.spinics.net/lists/linux-sh/msg50028.html

Basically it's really hard to identify what "the specific core
implementation" even means with a soft core. If you have some ideas
I'd be happy to hear them, but I think there should always be a
"jcore,j2" fallback compatible tag in any case.

FYI the way we're trying to use DT is to avoid hard-coding any
properties about the SoC (like mmio register addresses, cache
properties, etc.) in the cpu compatible tag, and instead breaking
things down into as many device nodes as possible, to allow variations
to be represented without having to encode them in the kernel/driver
sources.

> > +- reg: Must be 0 on uniprocessor systems, or the sequential, zero-based
> > +  hardware cpu id on SMP systems.
> > +
> > +Optional properties:
> > +
> > +- clock-frequency: Clock frequency of the cpu in Hz.
> > +
> > +- cpu-release-addr: Necessary only for secondary processors on SMP systems
> > +  using the "jcore,spin-table" enable method. If present, must consist of
> > +  two cells containing physical addresses. The first cell contains an
> > +  address which, when written, unblocks the secondary cpu. The second cell
> > +  contains an address from which the cpu will read its initial program
> > +  counter when unblocked.
> > +
> > +
> > +---------------------
> > +Cache controller node
> > +---------------------
> > +
> > +Required properties:
> > +
> > +- compatible: Must be "jcore,cache".
> 
> That's pretty generic...

Most of the DT compatible tags were derived from the component
directory/source-file names in the J-Core source. In the case of
cache, it's actually called "icache" in the source for historical
reasons despite also including dcache, so I just used "cache" in the
DT.

> > +
> > +- reg: A memory range for the cache controller registers.
> 
> And standard cache properties? Are size, sets, ways, line size, etc. 
> discoverable?

I want to do the cache properties in a way that's generic for all of
arch/sh rather than specific to J2, but that's going to be part of the
DT conversion project. That's why I just have properties hard-coded
for now in the kernel source. They're not really used anyway except
for presenting them in /proc/cpuinfo.

> > +--------
> > +IPI node
> > +--------
> > +
> > +Device trees for SMP systems must have an IPI node representing the mechanism
> > +used for inter-processor interrupt generation.
> > +
> > +Required properties:
> > +
> > +- compatible: Must be "jcore,ipi-controller".
> 
> Again, seems pretty generic.

I'm open to different ideas for naming schemes, but in the big scheme
of things it doesn't really matter. When there's a new incompatible
one, it can have a new compatible tag.

> > +----------
> > +CPUID node
> > +----------
> > +
> > +Device trees for SMP systems must have a CPUID node representing the mechanism
> > +used to identify the current processor on which execution is taking place.
> > +
> > +Required properties:
> > +
> > +- compatible: Must be "jcore,cpuid-mmio".
> > +
> > +- reg: A memory range containing a single 32-bit mmio register which produces
> > +  the current cpu id when read.
> 
> This id matches the reg value in cpu node, right? If not, it should.

Yes. Should I document that here?

Rich
