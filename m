From: Rob Herring <robh@kernel.org>
Date: Mon, 23 May 2016 20:48:46 +0000
Subject: Re: [PATCH v2 02/12] of: add J-Core cpu bindings
Message-Id: <20160523204846.GA16081@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
 <f3c89e4834665790ff13478c571cc9aaa9de5559.1463708766.git.dalias@libc.org>
In-Reply-To: <f3c89e4834665790ff13478c571cc9aaa9de5559.1463708766.git.dalias-8zAoT0mYgF4@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>

On Fri, May 20, 2016 at 02:53:03AM +0000, Rich Felker wrote:
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>  Documentation/devicetree/bindings/jcore/cpus.txt | 91 ++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/jcore/cpus.txt
> 
> diff --git a/Documentation/devicetree/bindings/jcore/cpus.txt b/Documentation/devicetree/bindings/jcore/cpus.txt
> new file mode 100644
> index 0000000..00ef112
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/jcore/cpus.txt
> @@ -0,0 +1,91 @@
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

Okay to have this, but you should have compatible strings for specific 
core implementations. AIUI, J2 is just the ISA.

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
> +
> +
> +---------------------
> +Cache controller node
> +---------------------
> +
> +Required properties:
> +
> +- compatible: Must be "jcore,cache".

That's pretty generic...

> +
> +- reg: A memory range for the cache controller registers.

And standard cache properties? Are size, sets, ways, line size, etc. 
discoverable?

> +
> +
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

Again, seems pretty generic.

> +
> +- reg: A memory range used to IPI generation.
> +
> +- interrupts: An irq on which IPI will be received.
> +
> +
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
> +  the current cpu id when read.

This id matches the reg value in cpu node, right? If not, it should.

Rob
