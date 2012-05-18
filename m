From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 18 May 2012 09:58:46 +0000
Subject: Re: [PATCH 24/29] mmc: add a simple generic OF parser
Message-Id: <Pine.LNX.4.64.1205181156460.23140@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-25-git-send-email-g.liakhovetski@gmx.de>
 <CAOesGMg7eUTjX6+DJtd7G5N69yteWMLWPaB0jjaz12_fH7-JEQ@mail.gmail.com>
In-Reply-To: <CAOesGMg7eUTjX6+DJtd7G5N69yteWMLWPaB0jjaz12_fH7-JEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Olof Johansson <olof@lixom.net>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

Hi Olof

On Fri, 4 May 2012, Olof Johansson wrote:

> On Thu, May 3, 2012 at 8:05 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Many MMC host drivers already use OF data to obtain their platform-spec=
ific
> > configuration. Each of them is doing this in its special way, whereas m=
any
> > parameters are identical and can easily be generalised. This patch adds
> > such a generic parser. So far it only adds and handles very few basic
> > properties. New ones can be added in the future as required.
>=20
> The bindings need to be documented under Documentation/devicetree/mmc

Right, I would do that, but I think, I'll drop this patch altogether for=20
now. There is an alternative patch being developed at the moment, that=20
standardises mmc bindings too. It doesn't provide a parser, but that can=20
be added later if needed.

Thanks
Guennadi

> It's common to use dashes (-) instead of underscores (_) in properties
>=20
> Also, no need to prefix with mmc. But also:
>=20
>=20
> > + =A0 =A0 =A0 if (of_get_property(node, "mmc,4_bit_data", NULL))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_BIT_DATA;
> > + =A0 =A0 =A0 if (of_get_property(node, "mmc,8_bit_data", NULL))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_8_BIT_DATA;
>=20
> In the device tree, do these encode the capability of the controller,
> or how the device under the controller is wired up? It's not uncommon
> to have an 4-bit device on a controller that could possibly support
> 8-bit devices. It needs to be clear from the property name which is
> which to not confuse everyone all the time.
>=20
> > + =A0 =A0 =A0 if (of_get_property(node, "mmc,sdio_irq", NULL))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SDIO_IRQ;
>=20
> "supports-sdio-interrupts"
>=20
> > + =A0 =A0 =A0 if (of_get_property(node, "mmc,nonremovable", NULL))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_NONREMOVABLE;
>=20
> This is a property of the card (well, how the card is connected), not
> the controller, right? Again, see above regarding confusion.
>=20
> > + =A0 =A0 =A0 if (of_get_property(node, "mmc,needs_poll", NULL))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_NEEDS_POLL;
>=20
> This should be implicit from lack of interrupt property in the device nod=
e.
>=20
> > + =A0 =A0 =A0 if (of_get_property(node, "mmc,inverted_cd", NULL))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps2 |=3D MMC_CAP2_INVERTED_CD;
> > + =A0 =A0 =A0 if (of_get_property(node, "mmc,inverted_ro", NULL))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps2 |=3D MMC_CAP2_INVERTED_RO;
>=20
> The GPIO specifiers should be able to encode polarity. Is this needed
> for other cases as well?
>=20
>=20
> -Olof
>=20

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
