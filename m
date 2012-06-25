From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 Jun 2012 16:13:08 +0000
Subject: Re: [PATCH][rework] ARM: shmobile: patch set rework
Message-Id: <CANqRtoTq0AvDGh1Vr87KDJp2xyjYZmQt6MV+PdhyFQuLCaQPrg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87hatzlm7x.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hatzlm7x.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Mon, Jun 25, 2012 at 7:28 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Rafael, Magnus
> Cc Simon
>
> These are rework patch set which are not included on latest rafael's tree.
> (and additional patch)
> I separated each patches to become independent as much as possible.

Thanks for splitting out your patches!

> My previous patch set tried to sharing "gpio" and "DMAEngine" definitions=
 on top.
> This patch set still try to sharing it, but it was on last patches.

Good plan. I like when you prioritize adding hardware support over
moving around code. =3D)

> gpio/DMAEngine sharing patch were separated as "add common xxx",
> and "use common xxx".
> I hope it is good fit for rafael's branch control

Looks fine to me, but I will let Rafael decide about that.

> 1st "PM domain" patch is new one.
> It adds very basic PM domain support for Armadillo
>
> Kuninori Morimoto (1):
> =A0 =A0 =A0ARM: shmobile: r8a7740: basic PM domain support

I believe this one needs more work. So I prefer holding off on this
for a while, alternatively including it in some topic branch for
incremental fixing and possible rebase,

> Kuninori Morimoto (2):
> =A0 =A0 =A0ARM: shmobile: armadillo800eva: enable FSI-WM8978 sound
> =A0 =A0 =A0ARM: shmobile: armadillo800eva: enable FSI-HDMI sound
>
> Kuninori Morimoto (3):
> =A0 =A0 =A0ARM: shmobile: sh73a0: add USB clock support
> =A0 =A0 =A0ARM: shmobile: kzm9g: enable USB func
> =A0 =A0 =A0ARM: shmobile: kzm9g: enable MicroSD
>
> Kuninori Morimoto (6):
> =A0 =A0 =A0ARM: shmobile: r8a7740: add DMAEngine support for FSI
> =A0 =A0 =A0ARM: shmobile: r8a7740: add DMAEngine support for SDHI
> =A0 =A0 =A0ARM: shmobile: r8a7740: add DMAEngine support for USB
> =A0 =A0 =A0ARM: shmobile: armadillo800eva: enable DMAEngine on FSI
> =A0 =A0 =A0ARM: shmobile: armadillo800eva: enable DMAEngine on SDHI
> =A0 =A0 =A0ARM: shmobile: armadillo800eva: enable DMAEngine on USB
>
> Kuninori Morimoto (3):
> =A0 =A0 =A0ARM: shmobile: sh73a0: add DMAEngine support for MPDMAC
> =A0 =A0 =A0ARM: shmobile: kzm9g: enable DMAEngine on FSI
> =A0 =A0 =A0ARM: shmobile: kzm9g: enable DMAEngine on MMCIF
>
> Kuninori Morimoto (5):
> =A0 =A0 =A0ARM: shmobile: add common extra gpio functions
> =A0 =A0 =A0ARM: shmobile: use common extra gpio functions on ap4evb
> =A0 =A0 =A0ARM: shmobile: use common extra gpio functions on g4evm
> =A0 =A0 =A0ARM: shmobile: use common extra gpio functions on mackrel
> =A0 =A0 =A0ARM: shmobile: use common extra gpio functions on armadillo800=
eva
>
> Kuninori Morimoto (4):
> =A0 =A0 =A0ARM: shmobile: add common DMAEngine definitions
> =A0 =A0 =A0ARM: shmobile: use common DMAEngine definitions on r8a7740
> =A0 =A0 =A0ARM: shmobile: use common DMAEngine definitions on sh7372
> =A0 =A0 =A0ARM: shmobile: use common DMAEngine definitions on sh73a0

These all look fine to me. Thanks for reposting your patches.

Rafael, please feel free to include my acked-by and pick up unless you
or someone else thinks differently.

Morimoto-san, in general I'm happy with you resending your patches
like this time, and I'm not sure if you can easily change the format
of this kind of email, but to make your patches even more easy to read
please consider:
a) including a diffstat in each [PATCH 0/x] (this is good to show why
the cleanup is useful)
b) include the [PATCH x/y] information in your patch list included in
[PATCH 0/x] (and this email)

Cheers,

/ magnus
