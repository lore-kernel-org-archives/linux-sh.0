From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 08 Dec 2009 08:20:44 +0000
Subject: Re: [PATCH 4/5] sh: stylistic improvements for the DMA driver
Message-Id: <Pine.LNX.4.64.0912080916300.4948@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912041936541.3981@axis700.grange> 
 <Pine.LNX.4.64.0912041942040.3981@axis700.grange>
 <e9c3a7c20912071654y19313fd5j6d9ff5a62cde028e@mail.gmail.com>
In-Reply-To: <e9c3a7c20912071654y19313fd5j6d9ff5a62cde028e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

On Mon, 7 Dec 2009, Dan Williams wrote:

> On Fri, Dec 4, 2009 at 11:45 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > =A0drivers/dma/shdma.c | =A0 34 +++++++++++++++++-----------------
> > =A0drivers/dma/shdma.h | =A0 14 +++++++-------
> > =A02 files changed, 24 insertions(+), 24 deletions(-)
> >
> [..]
> > -static int dmae_is_idle(struct sh_dmae_chan *sh_chan)
> > +static int dmae_is_busy(struct sh_dmae_chan *sh_chan)
>=20
> This one isn't purely style, I agree with it, but think it would be a
> bit cleaner to return a bool rather than an error code.

Yes, I also thought about it, but I wasn't sure whether the author had=20
some special considerations, why he has chosen to return an error code.=20
Besides, that return code is also used in functions dmae_set_chcr() and=20
dmae_set_dmars() as their return value. So, you'd have to change those two =

to something like

	if (dmae_is_busy(sh_chan))
		return -EBUSY;

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
