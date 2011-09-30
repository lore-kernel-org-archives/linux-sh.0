From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 30 Sep 2011 19:29:44 +0000
Subject: Re: [PATCH 4/5] ARM: mach-shmobile: r8a7740: Add i2c support
Message-Id: <CABMQnVJv-xCLKGpee6PWvS8ecmqYy++u5KtbqL-JknfJLk2F0Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8762kcqglg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8762kcqglg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

2011/9/30 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>:
>
> Hi Iwamatsu-san
>
> Thank you for your check
>
>> > +static void r8a7740_i2c_workaround(struct platform_device *pdev)
>> > +{
>> > + =A0 =A0 =A0 struct resource *res;
>> > + =A0 =A0 =A0 void __iomem *reg;
>> > +
>> > + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> > + =A0 =A0 =A0 if (!res) {
>>
>> if (unlikely(res =3D NULL)) { =A0?
>> Please check NULL.
>
> Sorry. what is your opinion ?
>
> if (!res) checks NULL I think.
> or do you mean add "unlikely()" ?

Both.
This function was return pointer or NULL.

Best regards,
  Nobuhiro



--=20
Nobuhiro Iwamatsu
=A0=A0 iwamatsu at {nigauri.org / debian.org}
=A0=A0 GPG ID: 40AD1FA6
