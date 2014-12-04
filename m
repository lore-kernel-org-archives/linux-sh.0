From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2014 09:24:32 +0000
Subject: Re: [PATCH 02/02] ARM: shmobile: marzen-reference: Remove IRLM workaround
Message-Id: <CANqRtoQM8jrggMT7QFTQ1_1fKJgankkrUnF-wO8mJx3NqjxMTQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141203121753.5936.36253.sendpatchset@w520>
	<20141203121813.5936.17433.sendpatchset@w520>
	<20141204072153.GE25806@verge.net.au>
	<CANqRtoRq5j6q=XGd1eJUH5TzSAGmZjyxnnSs+p_jum50zZn0Wg@mail.gmail.com>
	<CAMuHMdW=-yXKUKQPc2rU0P2PQgjqnYzSZxZCPXLVYJjai+L04w@mail.gmail.com>
In-Reply-To: <CAMuHMdW=-yXKUKQPc2rU0P2PQgjqnYzSZxZCPXLVYJjai+L04w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, SH-Linux <linux-sh@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>

Hi Geert,

On Thu, Dec 4, 2014 at 6:19 PM, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> Hi Magnus,
>
> On Thu, Dec 4, 2014 at 8:33 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>>> --- 0002/arch/arm/boot/dts/r8a7779.dtsi
>>>> +++ work/arch/arm/boot/dts/r8a7779.dtsi       2014-12-03 20:27:49.0000=
00000 +0900
>>>> @@ -139,7 +139,7 @@
>>>>               interrupt-controller;
>>>>       };
>>>>
>>>> -     irqpin0: irqpin@fe780010 {
>>>> +     irqpin0: irqpin@fe780000 {
>>>>               compatible =3D "renesas,intc-irqpin-r8a7779", "renesas,i=
ntc-irqpin";
>>>>               #interrupt-cells =3D <2>;
>>>>               status =3D "disabled";
>>>> @@ -148,7 +148,8 @@
>>>>                       <0xfe780010 4>,
>>>>                       <0xfe780024 4>,
>>>>                       <0xfe780044 4>,
>>>> -                     <0xfe780064 4>;
>>>> +                     <0xfe780064 4>,
>>>> +                     <0xfe780000 4>;
>>>
>>> Is there any order implied by the above list?
>>> Na=C3=AFvely I would expect it to be sorted numerically.
>>
>> Yes, the driver assumes the register banks to be passed in a certain
>> order. In the case of r8a7779 we add one more register bank at the end
>> for IRLM setup. Register detail (base address, access size, order and
>> bitfield width) varies with SoC version. So the IRLM register will be
>> at different addresses depending on SoC, but the driver wants it at
>> the end of the list.
>
> As these are all individual registers, and there are that many, I think
> it's worth adding a reg-names property to identify the registers.
> Of course the driver still has to support the old anonymous order
> for backwards compatibility.

If we should rework things, then I propose going the other way around.
=3D) Basically only passing a single base address with a certain SoC
specific compat string, and based on that letting the driver
internally figure out which register is at what offset and the access
size and bitfield size. Either way we have a limited number of SoCs
and they are all old.

Cheers,

/ magnus
