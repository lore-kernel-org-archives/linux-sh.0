From: Rob Landley <rob@landley.net>
Date: Thu, 26 May 2016 21:44:02 +0000
Subject: Re: [PATCH v3 02/12] of: add J-Core cpu bindings
Message-Id: <57476E22.6010000@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <39ad5c69533ef537e6ab0426efc057f9064ee581.1464148904.git.dalias@libc.org>
 <20160525102214.GF1337@leverpostej>
 <20160525230407.GT21636@brightrain.aerifal.cx>
In-Reply-To: <20160525230407.GT21636@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>



On 05/25/2016 06:04 PM, Rich Felker wrote:
> On Wed, May 25, 2016 at 11:22:15AM +0100, Mark Rutland wrote:
>> * What state should the CPU be in when it branches to the provided
>>   address?
>>   - Must the MMU be off?
> 
> Current models are nommu.

As far as I know, we're the first nommu SMP implementation in Linux.

>> At some point, you are likely to want CPU hotplug and/or cpuidle.

There are hundreds of todo items. At the moment we're just trying to get
basic board support in for more or less the design we demoed a year ago
at https://lwn.net/Articles/647636/

The roadmap page we've posted is a summary of a summary, it doesn't even
mention the DSP designs (plural) we've talked about at some length
internally. There's a DMA engine we're not using yet. We've got various
other things like ethernet support that the cheap $50 introductory board
we're targeting as an entry point hasn't got connectors for. And we
didn't do anything for the vga or sound connectors on that board because
"boot to a shell prompt on serial prompt" was our first target. (It runs
out of initramfs, but since you need the sdcard to load linux from, and
thus the bootloader had to have an sdcard driver, it seemed a shame NOT
to have an sdcard driver in linux too.)

Other than that? Intentionally minimalist first pass.

>> We
>> didn't provision the arm64 spin-table for either of these and never
>> extended it, but you may want to put in place some discoverability now
>> to allow future OSs to use that new support while allowing current OSs
>> to retain functional (e.g. not requiring a new enable-method string).
>>
>>> +---------------------
>>> +Cache controller node
>>> +---------------------
>>> +
>>> +Required properties:
>>> +
>>> +- compatible: Must be "jcore,cache".
>>> +
>>> +- reg: A memory range for the cache controller registers.
>>
>> There is a well-defined memory map for the cache controller?

The icache and dcache are 8k each, have 32 byte cache lines, and they
cache (addr>>5)&255 so reading from + or - 8192 bytes will evict that
cache line due to aliasing.

The icache and dcache each have an enable and flush bit in the
processor's control register. (So 4 bits total controlling the cache, I
think? I'd have to dig up Niishi-san's slides to check.)

Each processor has its own set of control registers. Back when SMP was
first implemented there was a lot of talk among the engineers about
separating the register stuff out, because right now processor stuff and
SOC I/O devices are kinda mashed together. But "release early, release
often" won out over endlessly polishing the same stuff in-house before
showing it to anybody else. We WANT other people to suggest fixes, but
we also want basic support for what's already been working for a year
and a half to go into the vanilla kernel at some point.

>> If so, please refer to documentation for it here (either in this
>> section, or the top of this document if common with other elements
>> described herein).

During my most recent trip to Japan I sat down with the engineer who
wrote the dcache and dram controller and passed on his explanation of
them to somebody on the j-core mailing list, about halfway through this
message:

  http://lists.j-core.org/pipermail/j-core/2016-April/000038.html

I've been meaning to cut that out and put it on a web page on
j-core.org, but have been busy with other things. That post also points
at comments in the VHDL source that implement the features.

That is, alas, the level of documentation we're talking about at the
moment. Better is on the todo list. In the meantime you can RTFS if you
understand vhdl, or ask the engineers on the j-core list or #j-core
freenode channel. The instruction set is based on an existing
architecture and the other SOC features in the initial release are as
minimal as we could get them and still be useful. (We've got a lot more
peripherals implemented than this release includes.)

We thought getting working code into the kernel should be a high
priority, but apparently everything has to be done before anything can
be done?

> The current version "jcore,cache" has a single 32-bit control register
> per cpu that can be used to enable/disable/flush icache and/or dcache.
> There is no finer-grained control. If/when we do larger caches in the
> future where it makes sense, there will be a new binding for it. (For
> example it may make sense to do one that matches the original SH
> memory-mapped cache interface.)

The first dache-only Linux support I did last year worked by reading an
aliased cache line from sram to evict individual cache lines, and it
turned out to have no detectable speed advantage over just blanking the
whole thing. Then doing the same "flush by aliasing" trick with icache
would have required an 8k jump table and we just went "no" and
implemented the flush bits instead, so almost all that code went away.

When we implement L2 cache for j-core, we can start caring about
granularity again, but http://j-core.org/roadmap.html has scaling _down_
into arduino country scheduled before scheduling up into MMU and 64-bit
territory so... not this year. :)

>>> +- reg: A memory range containing a single 32-bit mmio register which produces
>>> +  the current cpu id (matching the "reg" property of the cpu performing the
>>> +  read) when read.
>>
>> Likewise.
> 
> One general question I have about all of your comments -- is the DT
> binding file really supposed to amount to a hardware programming
> manual, fully specifying all of the programming interfaces? I don't
> see that in other binding files, and it feels like what you're asking
> for is beyond the scope of just specifying the bindings. 

In general if they haven't needed it yet, they haven't done it yet.
Doesn't mean we haven't thought about it, or even sketched out multiple
possible paths forward and decided on our favorite and our preferred
fallback approach. (I have more photographs of whiteboards on my phone
than anyone really needs. Some of them I could even tell you what the
subject was.)

But for the initial "here's how people other than us can try this out on
a $50 FPGA board from india" board support, going down the rathole of
every possible direction of future expansion as a prerequisite for "one
release of one processor on one brand of board" introductory support
seems counterproductive. Or is it just me?

If you want to critique the hardware design on the j-core mailing list,
I'll happily point the appropriate in-house engineers at the thread. In
the meantime, Rich submitted a patch to support the SOC we've had for a
year now.

Rob
