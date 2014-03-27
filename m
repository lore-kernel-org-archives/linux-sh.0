From: Rob Herring <robherring2@gmail.com>
Date: Thu, 27 Mar 2014 13:54:09 +0000
Subject: Re: [RFC] Serial port aliases in DT
Message-Id: <CAL_Jsq+SWZUz4D+3pdDs5yfi_XbTODC0ytt1S5KpmR_C5vVL=A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5448979.WQPtOb56tW@avalon>
	<2488692.p5nEA6pWSY@wuerfel>
	<1454965.NzCSO7fLpj@avalon>
	<9498012.PtNMJ9hipe@avalon>
In-Reply-To: <9498012.PtNMJ9hipe@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Mar 27, 2014 at 7:50 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hello DT maintainers,
>
> Ping ? This issue is blocking the merge of serial port DT support on Renesas
> platforms, as we need to decide on how to name the ports.

This seems like a topic for devicetree-spec.

> On Tuesday 11 March 2014 12:57:59 Laurent Pinchart wrote:
>> On Monday 10 March 2014 13:57:23 Arnd Bergmann wrote:
>> > On Monday 10 March 2014 12:59:03 Laurent Pinchart wrote:
>> > > The SoC includes 8 serial ports. They are all disabled in the SoC .dtsi,
>> > > and enabled selectively by board DT files. As not all serial ports are
>> > > available on all boards, the question was whether to add aliases for all
>> > > ports (in the .dtsi in this case) like
>> > >
>> > >          serial0 = &scif0;
>> > >          serial1 = &scif1;
>> > >          serial2 = &scif2;
>> > >          serial3 = &scif3;
>> > >          serial4 = &scif4;
>> > >          serial5 = &scif5;
>> > >          serial6 = &scif6;
>> > >          serial7 = &scif7;
>> > >
>> > > or to just add aliases for the enabled ports (in the board DT file) like
>> > >
>> > >          serial0 = &scif2;
>> > >          serial1 = &scif3;
>> > >
>> > > Note the numbering in the latter case: as the board doesn't use serial
>> > > ports 0 and 1, hardware ports 2 and 3 become logical ports 0 and 1.
>> > >
>> > > I considered that having Linux create ttySC0 and ttySC1 devices for the
>> > > first two ports of the board, regardless of which hardware ports are
>> > > used, is simpler from a user point of view (it allows sharing the same
>> > > inittab settings for the console serial port across several boards for
>> > > instance). I'd appreciate feedback on that.
>> >
>> > I think the traditional interpretation is that we want to use the aliases
>> > to reflect the device names in the OS.
>>
>> If I interpret this correctly it means that the question boils down to
>> whether we want the system to expose ttySC0 and ttySC1 or ttySC2 and
>> ttySC3, in case only ports 2 and 3 are enabled.
>>
>> Let's note that, despite the above example showing 8 instances of identical
>> serial IP cores, the reality is a bit more complex and Renesas SoCs usually
>> include different serial IP cores with several instances of each of them.
>> Ports of the same time are numbered in the datasheet, but there's no
>> standard or natural ordering global to all serial ports.
>>
>> This starts to remind me about the whole stable network device name changes
>> we went through recently.
>>
>> > This however comes back to the more general issue of serial port device
>> > naming: Linux traditionally uses separate names per driver (e.g. ttySC0
>> > instead of ttyS0).
>> >
>> > There has been discussion in the past about changing this to let all
>> > drivers use the same namespace, but it's not yet clear to me how we'd do
>> > this in a 100% backwards compatible way. Maybe it's best left to udev to
>> > figure out the driver independent name, but then we definitely should use
>> > the alias for that name.

This discussion has come up in just the last month or so.

My opinion is device name numbering should start at 0 with 0 being the
preferred console device. My main reasoning is giving consistent
naming across boards and it is more inline with how other devices are
named. The aliases are just to give you consistency in the numbering
within the 0 to N. Hopefully this is inline with what other platforms
have done as above all I think we should be consistent.

Rob
