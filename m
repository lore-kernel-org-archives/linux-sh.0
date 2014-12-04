From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2014 07:33:25 +0000
Subject: Re: [PATCH 02/02] ARM: shmobile: marzen-reference: Remove IRLM workaround
Message-Id: <CANqRtoRq5j6q=XGd1eJUH5TzSAGmZjyxnnSs+p_jum50zZn0Wg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141203121753.5936.36253.sendpatchset@w520>
	<20141203121813.5936.17433.sendpatchset@w520>
	<20141204072153.GE25806@verge.net.au>
In-Reply-To: <20141204072153.GE25806@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Simon Horman <horms@verge.net.au>
Cc: SH-Linux <linux-sh@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>

Hi Simon,

On Thu, Dec 4, 2014 at 4:21 PM, Simon Horman <horms@verge.net.au> wrote:
> Hi Magnus,
>
> On Wed, Dec 03, 2014 at 09:18:13PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Adjust the r8a7779 SoC DTS and the Marzen Reference
>> C board code to use DTS only for INTC-IRQPIN IRLM setup.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  Written on top of renesas-devel-20141202-v3.18-rc7 and
>>  [PATCH] ARM: shmobile: r8a7779 CCF DTS update
>>
>>  Has a runtime dependency on:
>>  [PATCH 01/02] irqchip: renesas-intc-irqpin: r8a7779 IRLM setup support
>>
>>  arch/arm/boot/dts/r8a7779.dtsi                  |    5 +++--
>>  arch/arm/mach-shmobile/board-marzen-reference.c |    7 -------
>>  2 files changed, 3 insertions(+), 9 deletions(-)
>>
>> --- 0002/arch/arm/boot/dts/r8a7779.dtsi
>> +++ work/arch/arm/boot/dts/r8a7779.dtsi       2014-12-03 20:27:49.000000=
000 +0900
>> @@ -139,7 +139,7 @@
>>               interrupt-controller;
>>       };
>>
>> -     irqpin0: irqpin@fe780010 {
>> +     irqpin0: irqpin@fe780000 {
>>               compatible =3D "renesas,intc-irqpin-r8a7779", "renesas,int=
c-irqpin";
>>               #interrupt-cells =3D <2>;
>>               status =3D "disabled";
>> @@ -148,7 +148,8 @@
>>                       <0xfe780010 4>,
>>                       <0xfe780024 4>,
>>                       <0xfe780044 4>,
>> -                     <0xfe780064 4>;
>> +                     <0xfe780064 4>,
>> +                     <0xfe780000 4>;
>
> Is there any order implied by the above list?
> Na=C3=AFvely I would expect it to be sorted numerically.

Yes, the driver assumes the register banks to be passed in a certain
order. In the case of r8a7779 we add one more register bank at the end
for IRLM setup. Register detail (base address, access size, order and
bitfield width) varies with SoC version. So the IRLM register will be
at different addresses depending on SoC, but the driver wants it at
the end of the list.

Cheers,

/ magnus
