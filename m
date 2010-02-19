From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Feb 2010 09:56:11 +0000
Subject: Re: [PATCH 2/2] Add DMA support for the sh-sci.c serial driver
Message-Id: <Pine.LNX.4.64.1002191053220.4594@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002181624190.4373@axis700.grange>
 <Pine.LNX.4.64.1002181726230.4373@axis700.grange>
 <d6a0f7aa1002190147u57a4d88g42b376eb8891e44d@mail.gmail.com>
In-Reply-To: <d6a0f7aa1002190147u57a4d88g42b376eb8891e44d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Govindraj <govindraj.ti@gmail.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <damm@opensource.se>, Dan Williams <dan.j.williams@intel.com>, linux-serial@vger.kernel.org

On Fri, 19 Feb 2010, Govindraj wrote:

> > + =A0 =A0 =A0 chan =3D dma_request_channel(mask, filter, param);
> > + =A0 =A0 =A0 dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, =
chan);
>=20
>=20
> If dma channel allocation fails how this scenario will be handled,
> There is an possibility of dma_request_channel returning -EBUSY,

Really? How? I thought it could only return a pointer to a channel or a=20
NULL? And if it fails, i.e., chan =3D NULL, the whole code just stays=20
inactive and the driver falls back to normal PIO.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
