From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 25 May 2016 10:22:15 +0000
Subject: Re: [PATCH v3 02/12] of: add J-Core cpu bindings
Message-Id: <20160525102214.GF1337@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <39ad5c69533ef537e6ab0426efc057f9064ee581.1464148904.git.dalias@libc.org>
In-Reply-To: <39ad5c69533ef537e6ab0426efc057f9064ee581.1464148904.git.dalias-8zAoT0mYgF4@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

On Wed, May 25, 2016 at 05:43:03AM +0000, Rich Felker wrote:
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>  Documentation/devicetree/bindings/jcore/cpus.txt | 92 ++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/jcore/cpus.txt
> 
> diff --git a/Documentation/devicetree/bindings/jcore/cpus.txt b/Documentation/devicetree/bindings/jcore/cpus.txt
> new file mode 100644
> index 0000000..9d77ec1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/jcore/cpus.txt
> @@ -0,0 +1,92 @@
> +=========> +J-Core cpu bindings
> +=========> +
> +The J-Core processors are open source CPU cores that can be built as FPGA
> +soft cores or ASICs. The device tree is also responsible for describing the
> +cache controls and, for SMP configurations, all details of the SMP method,
> +as documented below.
> +
> +
> +---------------------
> +Top-level "cpus" node
> +---------------------
> +
> +Required properties:
> +
> +- #address-cells: Must be 1.
> +
> +- #size-cells: Must be 0.
> +
> +Optional properties:
> +
> +- enable-method: Required only for SMP systems. If present, must be
> +  "jcore,spin-table".
> +
> +
> +--------------------
> +Individual cpu nodes
> +--------------------
> +
> +Required properties:
> +
> +- device_type: Must be "cpu".
> +
> +- compatible: Must be "jcore,j2".
> +
> +- reg: Must be 0 on uniprocessor systems, or the sequential, zero-based
> +  hardware cpu id on SMP systems.
> +
> +Optional properties:
> +
> +- clock-frequency: Clock frequency of the cpu in Hz.
> +
> +- cpu-release-addr: Necessary only for secondary processors on SMP systems
> +  using the "jcore,spin-table" enable method. If present, must consist of
> +  two cells containing physical addresses. The first cell contains an
> +  address which, when written, unblocks the secondary cpu. The second cell
> +  contains an address from which the cpu will read its initial program
> +  counter when unblocked.

I take it this follows the example of the arm64 spin-table rather than
the ePAPR spin-table, given the lack of an ePAPR reference or struct
definition.

From my experience with the arm64 spin-table, I would *strongly*
recommend that you tighten this up, and define things more thoroughly,
before a variety of FW/bootloader implementations appear. e.g.

* What initial/invalid value should the location contain? Is zero a
  valid address that you might want to jump a secondary CPU to?

* How must the value be written?
  - Which endianness?
  - With a single store? Or is there a more involved sequence to prevent
    the secondary CPU from seeing a torn value?

* Must CPUs have a unique cpu-release-addr? I would *strongly* recommend
  that they do.
  - Is any minimal padding required around cpu-release-addrs? e.g. can
    FW or bootlaoder put data in the same cacheline-aligned region and
    exepct the OS not to corrupt this?

* How should the OS map the region (i.e. which MMU/cache attributes)?
  - Is the address permitted to be a device register?

* Where can this memory live?
  - Should it be abesnt from any memory node? To which padding?
  - Should the memory be described with a memreserve? If so, what are
    your architecture-specific memreserve semantics (i.e. which
    MMU/cache attributes are permitted for a memreserve'd region)?

* What state should the CPU be in when it branches to the provided
  address?
  - Must the MMU be off?
  - What state must any cache be in?
    Should FW perform any implementation defined coherency and cache
    management prior to branching?
  - Must the CPU be in a particular endianness?
  - Which exceptions must be masked?
  - Are interrupts permitted to be pending?
  - Should debug logic (e.g. breakpoint and watchpoints) be placed into
    a quiescent state?
  - Should any registers be programmed with specific values?

At some point, you are likely to want CPU hotplug and/or cpuidle. We
didn't provision the arm64 spin-table for either of these and never
extended it, but you may want to put in place some discoverability now
to allow future OSs to use that new support while allowing current OSs
to retain functional (e.g. not requiring a new enable-method string).

> +---------------------
> +Cache controller node
> +---------------------
> +
> +Required properties:
> +
> +- compatible: Must be "jcore,cache".
> +
> +- reg: A memory range for the cache controller registers.

There is a well-defined memory map for the cache controller?

If so, please refer to documentation for it here (either in this
section, or the top of this document if common with other elements
described herein).

> +--------
> +IPI node
> +--------
> +
> +Device trees for SMP systems must have an IPI node representing the mechanism
> +used for inter-processor interrupt generation.
> +
> +Required properties:
> +
> +- compatible: Must be "jcore,ipi-controller".
> +
> +- reg: A memory range used to IPI generation.
> +
> +- interrupts: An irq on which IPI will be received.

Likewise.

> +----------
> +CPUID node
> +----------
> +
> +Device trees for SMP systems must have a CPUID node representing the mechanism
> +used to identify the current processor on which execution is taking place.
> +
> +Required properties:
> +
> +- compatible: Must be "jcore,cpuid-mmio".
> +
> +- reg: A memory range containing a single 32-bit mmio register which produces
> +  the current cpu id (matching the "reg" property of the cpu performing the
> +  read) when read.

Likewise.

Thanks,
Mark.
