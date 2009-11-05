From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Nov 2009 08:42:38 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: Enable SPU2 clock when boot
Message-Id: <aec7e5c30911050042n3e7df043m37d46eafbb3cd1b1@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uocnifuik.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uocnifuik.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hey Morimoto-san,

On Thu, Nov 5, 2009 at 5:01 PM, Kuninori Morimoto
<morimoto.kuninori@renesas.com> wrote:
>> This is just doing an enable on init, so it's better to just flag this in
>> the CPU code. ie:
> (snip)
>> Although this is going to be a nuisance for power management.
>
> I'm 100% not sure about power management.
> Is spu clock operation unnecessary if there is following ?
>
> + =A0 =A0 =A0 .archdata =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hwblk_id =3D HWBLK_SPU,
> + =A0 =A0 =A0 },
>
> If so, please throw away this patch.

No, your code is correct. And Paul has a nicer solution for the spu_clk.

At this point you need to enable the parent clock and use hwblk_id for
module stop bits.

Cheers,

/ magnus
