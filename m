From: Jarkko Nikula <jhnikula@gmail.com>
Date: Thu, 20 Aug 2009 12:59:31 +0000
Subject: Re: [alsa-devel] [PATCH v2 1/4] Add SuperH FSI driver support for
Message-Id: <20090820160053.c631bb62.jhnikula@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uy6ped79a.wl%morimoto.kuninori@renesas.com>
	<20090820152212.b8be38b9.jhnikula@gmail.com>
	<20090820123911.GA10046@rakim.wolfsonmicro.main>
	<aec7e5c30908200544i9275017i93b4292ded02f9de@mail.gmail.com>
In-Reply-To: <aec7e5c30908200544i9275017i93b4292ded02f9de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, linux-sh@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lethal@linux-sh.org

On Thu, 20 Aug 2009 21:44:37 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> On Thu, Aug 20, 2009 at 9:39 PM, Mark
> Brown<broonie@opensource.wolfsonmicro.com> wrote:
> > On Thu, Aug 20, 2009 at 03:22:12PM +0300, Jarkko Nikula wrote:
> >
> >> I'm not familiar with the SH but this arch specific header file
> >> sh_fsi.h should go either into sound/soc/sh or if generic enough, then
> >> somewhere under arch/sh/include/.
> >
> > It needs to go under include, either with the sound stuff or with the
> > arch stuff since it contains platform data that boards are going to need
> > to set. =A0I don't really mind which myself, both schemes are in use.
>=20
> The FSI block may be used by other architectures in the near future as we=
ll. =3D)
>=20
Ok, nice to know, so the patch author did it right then :-)


--=20
Jarkko
