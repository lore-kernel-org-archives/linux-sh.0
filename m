From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Sep 2015 08:28:27 +0000
Subject: Re: [PATCH v8 04/07] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
Message-Id: <CANqRtoRKwm5NxVxE2+rx_YJOD8B8ce3jfuUqm0uR+nPi82=EXw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831062952.24004.17072.sendpatchset@little-apple>
In-Reply-To: <20150831062952.24004.17072.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Thu, Sep 3, 2015 at 5:23 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Thu, Sep 3, 2015 at 10:06 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> Practically, I need a simple way to identify the clock used by the GIC.
>>> Using the "intc-sys"/"intc-ap" name looked like a good idea.
>>> While it's always MSTP408, MSTP408 is used for other purposes on some SoCs.
>>>
>>> Let's give DT scanning a try...
>>
>> Uhm, sounds a bit overly complicated to me. This has probably been
>> discussed wildly before, but please remind me:
>>
>> What is wrong again with being standard and adding "clocks" and
>> "clock-names" to the GIC node?
>
> That needs to be done anyway (still have to dive into GIC architecture
> and come up with bindings the ARM people like).
>
> But it's not sufficient as:
>   - The GIC driver is not PM Runtime aware. It doesn't even use a platform
>     device,
>   - The GIC is instantiated from IRQCHIP_DECLARE(), which is way before
>     clocks are ready.

Ouch! Hopefully our CPG hardware does not have interrupts hooked up to
the GIC. That would make turn this mess into a full circle. =)

/ magnus
