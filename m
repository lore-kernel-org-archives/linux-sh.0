From: Rob Herring <robh@kernel.org>
Date: Wed, 25 May 2016 13:13:08 +0000
Subject: Re: [PATCH v2 02/12] of: add J-Core cpu bindings
Message-Id: <CAL_JsqLMoA6Ab3xK53Ru=ZXu-++cwtg1UEw9+NFpaJ6p2tMSuA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org> <f3c89e4834665790ff13478c571cc9aaa9de5559.1463708766.git.dalias@libc.org>
 <20160523204846.GA16081@rob-hp-laptop> <20160523210328.GE21636@brightrain.aerifal.cx>
 <CAL_JsqK0O2RY5PO9vHuOPjimRb34n8RwXMa7c8xmbY7Oh7D2Xg@mail.gmail.com>
 <5744C80E.6070501@landley.net> <CAL_JsqJXzBLX4LwPezfm0UE9d8E0zzy8FJ=CUYuruMNbo=d4eA@mail.gmail.com>
 <20160525023330.GP21636@brightrain.aerifal.cx>
In-Reply-To: <20160525023330.GP21636@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Rob Landley <rob@landley.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>

On Tue, May 24, 2016 at 9:33 PM, Rich Felker <dalias@libc.org> wrote:
> On Tue, May 24, 2016 at 08:13:14PM -0500, Rob Herring wrote:
>> On Tue, May 24, 2016 at 4:30 PM, Rob Landley <rob@landley.net> wrote:
>> >
>> >
>> > On 05/23/2016 06:29 PM, Rob Herring wrote:
>> >> On Mon, May 23, 2016 at 4:03 PM, Rich Felker <dalias@libc.org> wrote:
>> >>> On Mon, May 23, 2016 at 03:48:46PM -0500, Rob Herring wrote:
>> >>>> On Fri, May 20, 2016 at 02:53:03AM +0000, Rich Felker wrote:
>> >>>>> Signed-off-by: Rich Felker <dalias@libc.org>
>> >>>>> ---
>> >>>>>  Documentation/devicetree/bindings/jcore/cpus.txt | 91 ++++++++++++++++++++++++
>> >>>>>  1 file changed, 91 insertions(+)
>> >>>>>  create mode 100644 Documentation/devicetree/bindings/jcore/cpus.txt
>> >>>>>
>> >>>>> diff --git a/Documentation/devicetree/bindings/jcore/cpus.txt b/Documentation/devicetree/bindings/jcore/cpus.txt
>> >>>>> new file mode 100644
>> >>>>> index 0000000..00ef112
>> >>>>> --- /dev/null
>> >>>>> +++ b/Documentation/devicetree/bindings/jcore/cpus.txt
>> >>>>> @@ -0,0 +1,91 @@
>> >>>>> +=========>> >>>>> +J-Core cpu bindings
>> >>>>> +=========>> >>>>> +
>> >>>>> +The J-Core processors are open source CPU cores that can be built as FPGA
>> >>>>> +soft cores or ASICs. The device tree is also responsible for describing the
>> >>>>> +cache controls and, for SMP configurations, all details of the SMP method,
>> >>>>> +as documented below.
>> >>>>> +
>> >>>>> +
>> >>>>> +---------------------
>> >>>>> +Top-level "cpus" node
>> >>>>> +---------------------
>> >>>>> +
>> >>>>> +Required properties:
>> >>>>> +
>> >>>>> +- #address-cells: Must be 1.
>> >>>>> +
>> >>>>> +- #size-cells: Must be 0.
>> >>>>> +
>> >>>>> +Optional properties:
>> >>>>> +
>> >>>>> +- enable-method: Required only for SMP systems. If present, must be
>> >>>>> +  "jcore,spin-table".
>> >>>>> +
>> >>>>> +
>> >>>>> +--------------------
>> >>>>> +Individual cpu nodes
>> >>>>> +--------------------
>> >>>>> +
>> >>>>> +Required properties:
>> >>>>> +
>> >>>>> +- device_type: Must be "cpu".
>> >>>>> +
>> >>>>> +- compatible: Must be "jcore,j2".
>> >>>>
>> >>>> Okay to have this, but you should have compatible strings for specific
>> >>>> core implementations. AIUI, J2 is just the ISA.
>> >>>
>> >>> There was some past discussion you probably missed on the linux-sh
>> >>> list, starting here:
>> >>>
>> >>> http://www.spinics.net/lists/linux-sh/msg50028.html
>> >>>
>> >>> Basically it's really hard to identify what "the specific core
>> >>> implementation" even means with a soft core. If you have some ideas
>> >>> I'd be happy to hear them, but I think there should always be a
>> >>> "jcore,j2" fallback compatible tag in any case.
>> >>
>> >> Presumably you do some sort of versioning on the VHDL source that you
>> >> can correlate to.
>> >>
>> >> If you have sufficient s/w accessible version registers that are
>> >> always going to be updated on IP changes then, you don't really need
>> >> more specific compatible strings.
>> >
>> > There are no version registers: the boot ROM can be output as part of
>> > the build, and the dtb can be provided by the boot ROM. So you don't
>> > need boot registers, you literally put any version info you need in the
>> > dtb in the boot rom.
>>
>> You can, but you are not doing that from the looks of it. Maybe you're
>> not to that point to need versioning and that's fine, but it doesn't
>> sound like you all have thought about it.
>
> It's been thought about and discussed both on the linux-sh list and
> internally in the J-Core development process, but it's certainly a
> topic that could use more discussion. I don't think it should be a
> blocking issue for registering current bindings, though.

It's not, I just want to understand the direction and that the need
here is understood.

>> >> Better yet, since you can change "the hardware", make it more
>> >> discoverable with registers for version numbering and feature bits.
>> >> The failure here is having a process where that can be forgotten...
>> >
>> > Why would you add hardware version registers when the hardware's
>> > attached boot rom is providing a dtb?
>> >
>> > What's the point?
>>
>> You are missing who is reading and caring about what the version is.
>> It's all the software that cares what's in either version registers or
>> dtb to know what are the specific features of the h/w. At some point
>> you will have a single driver that needs to support multiple versions
>> and/or configurations of hardware/IP.
>
> This is why we have both "jcore,aic1" and "jcore,aic2" now, and why
> we'll soon have a "jcore,spi3" binding for the new SPI master with DMA
> support. The intent is that stable hardware interfaces are maintained
> at the hardware source level, and the binding names correspond to
> component names in the hardware source.
>
> If there are good reasons for more fine-grained version information,
> we can add binding specifications for such, but the only reason I've
> seen so far is bug workarounds, and it really doesn't make sense to be
> putting bug workarounds in the kernel rather than just fixing the
> source and flashing the FPGA configuration. Once we get to ASICs of
> course it might make sense.
>
> Do you have other compelling reasons for fine-grained versioning?

Differences in features implied by compatible strings is the other
main reason. These would be features that are not configurable as
those you will probably want separate properties for. But if your
going to respin the VHDL to fix any issues, then what you have is
sufficient.

ASIC implementations should have compatible strings tied to the particular ASIC.

Rob
