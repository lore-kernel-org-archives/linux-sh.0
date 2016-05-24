From: Rich Felker <dalias@libc.org>
Date: Tue, 24 May 2016 02:39:39 +0000
Subject: Re: [PATCH v2 02/12] of: add J-Core cpu bindings
Message-Id: <20160524023939.GJ21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
 <f3c89e4834665790ff13478c571cc9aaa9de5559.1463708766.git.dalias@libc.org>
 <20160523204846.GA16081@rob-hp-laptop>
 <20160523210328.GE21636@brightrain.aerifal.cx>
 <CAL_JsqK0O2RY5PO9vHuOPjimRb34n8RwXMa7c8xmbY7Oh7D2Xg@mail.gmail.com>
In-Reply-To: <CAL_JsqK0O2RY5PO9vHuOPjimRb34n8RwXMa7c8xmbY7Oh7D2Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>

On Mon, May 23, 2016 at 06:29:48PM -0500, Rob Herring wrote:
> >> > +- compatible: Must be "jcore,j2".
> >>
> >> Okay to have this, but you should have compatible strings for specific
> >> core implementations. AIUI, J2 is just the ISA.
> >
> > There was some past discussion you probably missed on the linux-sh
> > list, starting here:
> >
> > http://www.spinics.net/lists/linux-sh/msg50028.html
> >
> > Basically it's really hard to identify what "the specific core
> > implementation" even means with a soft core. If you have some ideas
> > I'd be happy to hear them, but I think there should always be a
> > "jcore,j2" fallback compatible tag in any case.
> 
> Presumably you do some sort of versioning on the VHDL source that you
> can correlate to.

Yes, but I'm not convinced that helps with anything. Presumably the
point of having a fine-grained version in the compatible tag would be
to work around bugs. But if those bugs could come from build options,
specific version of the FPGA tools used, specific board targets, etc.
then a version really isn't sufficient to help you work around bugs.
On the other hand, as long as it's soft core, if there is a bug you
just fix the bitstream rather than putting workaround hacks in the
kernel or other software.

It does make sense to have some identifier for particular builds and
production runs once we have ASICs, of course, but that's a topic to
discuss when we get there.

I think most of this was already discussed in the thread I linked
above.

> >> > +- reg: A memory range for the cache controller registers.
> >>
> >> And standard cache properties? Are size, sets, ways, line size, etc.
> >> discoverable?
> >
> > I want to do the cache properties in a way that's generic for all of
> > arch/sh rather than specific to J2, but that's going to be part of the
> > DT conversion project. That's why I just have properties hard-coded
> > for now in the kernel source. They're not really used anyway except
> > for presenting them in /proc/cpuinfo.
> 
> The DT spec (devicetree.org, formerly ePAPR) already defines arch
> independent cache properties.

Indeed, but they don't seem to be comprehensive. In particular they
don't seem to represent the properties needed to compute aliasing for
VIPT cache architectures, or to represent whether the cache is
virtually or physically indexed or tagged.

> >> > +--------
> >> > +IPI node
> >> > +--------
> >> > +
> >> > +Device trees for SMP systems must have an IPI node representing the mechanism
> >> > +used for inter-processor interrupt generation.
> >> > +
> >> > +Required properties:
> >> > +
> >> > +- compatible: Must be "jcore,ipi-controller".
> >>
> >> Again, seems pretty generic.
> >
> > I'm open to different ideas for naming schemes, but in the big scheme
> > of things it doesn't really matter. When there's a new incompatible
> > one, it can have a new compatible tag.
> 
> It should make sense according to how you version the VHDL sources.
> The Xilinx folks have X.Y version numbers for example. We generally
> don't accept those, but for soft IP that is an exception.
> 
> Better yet, since you can change "the hardware", make it more
> discoverable with registers for version numbering and feature bits.
> The failure here is having a process where that can be forgotten...

I suspect that takes more space on the FPGA/ASIC than adding a few
bytes to the DTB in the boot rom would, so it's probably a worse
solution.

We could potentially allow compatible tags of the form "foo-v*" for
each "foo" documented now, where the version is from the jcore source
repo, and recommend (for example):

compatible = "jcore,foo-v1.23", "jcore,foo";

This would be separate from the numbers that are already present in
things like "spi2" and "spi3" (functionally distinct spi master
devices) or "aic1" and "aic2" (functionally distinct interrupt
controllers).

How would you want this to be documented, if we go that route?
Certainly all possible values cannot be specified in the binding docs
then.

> >> > +----------
> >> > +CPUID node
> >> > +----------
> >> > +
> >> > +Device trees for SMP systems must have a CPUID node representing the mechanism
> >> > +used to identify the current processor on which execution is taking place.
> >> > +
> >> > +Required properties:
> >> > +
> >> > +- compatible: Must be "jcore,cpuid-mmio".
> >> > +
> >> > +- reg: A memory range containing a single 32-bit mmio register which produces
> >> > +  the current cpu id when read.
> >>
> >> This id matches the reg value in cpu node, right? If not, it should.
> >
> > Yes. Should I document that here?
> 
> Yes.

OK, adding it to read:

- reg: A memory range containing a single 32-bit mmio register which produces
  the current cpu id (matching the "reg" property of the cpu performing the
  read) when read.

Rich
