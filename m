From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 10 May 2012 06:55:26 +0000
Subject: Re: [PATCH] mach-shmobile: Invalidate caches when booting secondary cores
Message-Id: <CANqRtoSLAQJsLy8sR0=4J2+aJXUd=OQZd7p1-hfreAq3aM31Vw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120509072459.20583.11420.sendpatchset@w520>
In-Reply-To: <20120509072459.20583.11420.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, May 10, 2012 at 3:47 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> At Thu, 10 May 2012 14:21:29 +0900,
> Magnus wrote:
>>
>> On Wed, May 9, 2012 at 4:24 PM, Magnus Damm <magnus.damm@gmail.com> wrot=
e:
>> > From: Magnus Damm <damm@opensource.se>
>> >
>> > Make sure L1 caches are invalidated when booting secondary
>> > cores. Needed to boot all mach-shmobile SMP systems that
>> > are using Cortex-A9 including sh73a0, r8a7779 and EMEV2.
>> >
>> > Thanks to imx and tegra guys for actual code.
>> >
>> > Signed-off-by: Magnus Damm <damm@opensource.se>
>> > ---
>> >
>> > =A0This should really be moved into a common location. Feel free
>> > =A0to point me in the right direction and I will be happy to
>> > =A0submit a patch that unifies the code.
>> >
>> > =A0Tested on EMEV2.
>>
>> Now also successfully tested on the r8a7779 Marzen board.
>
> I used this patch on KZM9G board. it allows SMP boot.
>
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for testing, Morimoto-san.

Since KZM9G is based on sh73a0 we have now tested all mach-shmobile
SMP SoCs with this patch.

Rafael, please pick up!

Cheers,

/ magnus
