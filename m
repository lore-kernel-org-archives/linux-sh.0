From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 04 Dec 2014 09:19:54 +0000
Subject: Re: [PATCH 02/02] ARM: shmobile: marzen-reference: Remove IRLM workaround
Message-Id: <CAMuHMdW=-yXKUKQPc2rU0P2PQgjqnYzSZxZCPXLVYJjai+L04w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141203121753.5936.36253.sendpatchset@w520>
	<20141203121813.5936.17433.sendpatchset@w520>
	<20141204072153.GE25806@verge.net.au>
	<CANqRtoRq5j6q=XGd1eJUH5TzSAGmZjyxnnSs+p_jum50zZn0Wg@mail.gmail.com>
In-Reply-To: <CANqRtoRq5j6q=XGd1eJUH5TzSAGmZjyxnnSs+p_jum50zZn0Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, SH-Linux <linux-sh@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>

Hi Magnus,

On Thu, Dec 4, 2014 at 8:33 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> --- 0002/arch/arm/boot/dts/r8a7779.dtsi
>>> +++ work/arch/arm/boot/dts/r8a7779.dtsi       2014-12-03 20:27:49.00000=
0000 +0900
>>> @@ -139,7 +139,7 @@
>>>               interrupt-controller;
>>>       };
>>>
>>> -     irqpin0: irqpin@fe780010 {
>>> +     irqpin0: irqpin@fe780000 {
>>>               compatible =3D "renesas,intc-irqpin-r8a7779", "renesas,in=
tc-irqpin";
>>>               #interrupt-cells =3D <2>;
>>>               status =3D "disabled";
>>> @@ -148,7 +148,8 @@
>>>                       <0xfe780010 4>,
>>>                       <0xfe780024 4>,
>>>                       <0xfe780044 4>,
>>> -                     <0xfe780064 4>;
>>> +                     <0xfe780064 4>,
>>> +                     <0xfe780000 4>;
>>
>> Is there any order implied by the above list?
>> Na=C3=AFvely I would expect it to be sorted numerically.
>
> Yes, the driver assumes the register banks to be passed in a certain
> order. In the case of r8a7779 we add one more register bank at the end
> for IRLM setup. Register detail (base address, access size, order and
> bitfield width) varies with SoC version. So the IRLM register will be
> at different addresses depending on SoC, but the driver wants it at
> the end of the list.

As these are all individual registers, and there are that many, I think
it's worth adding a reg-names property to identify the registers.
Of course the driver still has to support the old anonymous order
for backwards compatibility.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
