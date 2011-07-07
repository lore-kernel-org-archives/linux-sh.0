From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 Jul 2011 13:28:13 +0000
Subject: Re: [RFC][PATCH 0/8] sh: clock-shxxxx: add CLKDEV_ICK_ID for cleanup
Message-Id: <CANqRtoQibx7T6wqeku+diU+q9QPoQRCOf9hsq6gZwhQHPwe1WA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vcvgjjhj.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vcvgjjhj.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wed, Jul 6, 2011 at 10:17 AM,  <kuninori.morimoto.gx@renesas.com> wrote:
>
> Dear Paul, Magnus
>
> These are not so important, but are clean-up patches.
> Current clock-shxxxx are a little bit un-readable.
> I put it as [RFC]
>
> Kuninori Morimoto (8):
> =A0 =A0 =A0sh: clock-sh7724: add CLKDEV_ICK_ID for cleanup
> =A0 =A0 =A0sh: clock-sh7722: add CLKDEV_ICK_ID for cleanup
> =A0 =A0 =A0sh: clock-sh7343: add CLKDEV_ICK_ID for cleanup
> =A0 =A0 =A0sh: clock-sh7366: add CLKDEV_ICK_ID for cleanup
> =A0 =A0 =A0sh: clock-sh7757: add CLKDEV_ICK_ID for cleanup
> =A0 =A0 =A0sh: clock-sh7785: add CLKDEV_ICK_ID for cleanup
> =A0 =A0 =A0sh: clock-sh7786: add CLKDEV_ICK_ID for cleanup
> =A0 =A0 =A0sh: clock-shx3: add CLKDEV_ICK_ID for cleanup
>
> I checked sh7724, but couldn't others.

You mean that your compiler doesn't know how to talk SH4A? =3D)

Please at least build with the defconfigs that use the SoCs above.

Thanks,

/ magnus

/ magnus
