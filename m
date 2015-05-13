From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Date: Wed, 13 May 2015 08:20:53 +0000
Subject: Re: [PATCH/RFC 00/12] ARM: shmobile: dts: Add overlays for various serial ports
Message-Id: <E6970DEC-BA7C-4D97-AEA7-1874983414D4@konsulko.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431452235-11692-1-git-send-email-geert+renesas@glider.be> <D9B202C5-6460-4217-9F58-67078C3DB9B1@konsulko.com> <CAMuHMdXhLUJqpdAZc7X==s6cyeBdf7TVdJi7JtA1jC_V=hEXsQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXhLUJqpdAZc7X==s6cyeBdf7TVdJi7JtA1jC_V=hEXsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Geert,

> On May 13, 2015, at 11:19 , Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>=20
> Hi Pantelis,
>=20
> On Wed, May 13, 2015 at 10:16 AM, Pantelis Antoniou
> <pantelis.antoniou@konsulko.com> wrote:
>>> - The overlay sources use full paths to refer to the device nodes for
>>>   creating aliases, as path references (unlike phandle references) are
>>>   not yet supported by overlays.
>>=20
>> Hmm, phandle references are completely supported. You just have to remem=
ber
>> to build your base tree with the -@ option to generate the fixups :)

> The aliases need _path_ references.
>=20

Ugh, yeah, that=E2=80=99s a problem :)

> Gr{oetje,eeting}s,
>=20
>                        Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                -- Linus Torvalds

