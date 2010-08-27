From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Fri, 27 Aug 2010 06:38:58 +0000
Subject: Re: [RFC][PATCH] add
Message-Id: <20100827063858.GA22848@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20100827051907.GA17521@pengutronix.de>
	<20100827145712Z.fujita.tomonori@lab.ntt.co.jp>
	<201008270923.30297.mitov@issp.bas.bg>
	<20100827153204A.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100827153204A.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello,

On Fri, Aug 27, 2010 at 03:32:14PM +0900, FUJITA Tomonori wrote:
> On Fri, 27 Aug 2010 09:23:21 +0300
> Marin Mitov <mitov@issp.bas.bg> wrote:
>=20
> > On Friday, August 27, 2010 08:57:59 am FUJITA Tomonori wrote:
> > > On Fri, 27 Aug 2010 07:19:07 +0200
> > > Uwe Kleine-K=1B$(D+S=1B(Bnig <u.kleine-koenig@pengutronix.de> wrote:
> > >=20
> > > > Hey,
> > > >=20
> > > > On Fri, Aug 27, 2010 at 02:00:17PM +0900, FUJITA Tomonori wrote:
> > > > > On Fri, 27 Aug 2010 06:41:42 +0200
> > > > > Uwe Kleine-K=1B$(D+S=1B(Bnig <u.kleine-koenig@pengutronix.de> wro=
te:
> > > > > > On Thu, Aug 26, 2010 at 07:00:24PM +0900, FUJITA Tomonori wrote:
> > > > > > > On Thu, 26 Aug 2010 11:53:11 +0200
> > > > > > > Uwe Kleine-K=1B$(D+S=1B(Bnig <u.kleine-koenig@pengutronix.de>=
 wrote:
> > > > > > >=20
> > > > > > > > > > We have currently a number of boards broken in the main=
line. They must be=20
> > > > > > > > > > fixed for 2.6.36. I don't think the mentioned API will =
do this for us. So,=20
> > > > > > > > > > as I suggested earlier, we need either this or my patch=
 series
> > > > > > > > > >=20
> > > > > > > > > > http://thread.gmane.org/gmane.linux.ports.sh.devel/8595
> > > > > > > > > >=20
> > > > > > > > > > for 2.6.36.
> > > > > > > > >=20
> > > > > > > > > Why can't you revert a commit that causes the regression?
> > > > > > > > >=20
> > > > > > > > > The related DMA API wasn't changed in 2.6.36-rc1. The DMA=
 API is not
> > > > > > > > > responsible for the regression. And the patchset even exn=
teds the
> > > > > > > > > definition of the DMA API (dma_declare_coherent_memory). =
Such change
> > > > > > > > > shouldn't applied after rc1. I think that DMA-API.txt say=
s that
> > > > > > > > > dma_declare_coherent_memory() handles coherent memory for=
 a particular
> > > > > > > > > device. It's not for the API that reserves coherent memor=
y that can be
> > > > > > > > > used for any device for a single device.
> > > > > > > > The patch that made the problem obvious for ARM is
> > > > > > > > 309caa9cc6ff39d261264ec4ff10e29489afc8f8 aka v2.6.36-rc1~59=
1^2~2^4~12.
> > > > > > > > So this went in before v2.6.36-rc1.  One of the "architectu=
res which
> > > > > > > > similar restrictions" is x86 BTW.
> > > > > > > >=20
> > > > > > > > And no, we won't revert 309caa9cc6ff39d261264ec4ff10e29489a=
fc8f8 as it
> > > > > > > > addresses a hardware restriction.
> > > > > > >=20
> > > > > > > How these drivers were able to work without hitting the hardw=
are restriction?
> > > > > > In my case the machine in question is an ARMv5, the hardware re=
striction
> > > > > > is on ARMv6+ only.  You could argue that so the breaking patch =
for arm
> > > > > > should only break ARMv6, but I don't think this is sensible fro=
m a
> > > > > > maintainers POV.  We need an API that works independant of the =
machine
> > > > > > that runs the code.
> > > > >=20
> > > > > Agreed. But insisting that the DMA API needs to be extended wrong=
ly
> > > > > after rc2 to fix the regression is not sensible too. The related =
DMA
> > > > > API wasn't changed in 2.6.36-rc1. The API isn't responsible for t=
he
> > > > > regression at all.
> > > > I think this isn't about "responsiblity".  Someone in arm-land found
> > > > that the way dma memory allocation worked for some time doesn't work
> > > > anymore on new generation chips.  As pointing out this problem was
> > > > expected to find some matches it was merged in the merge window.  O=
ne
> > > > such match is the current usage of the DMA API that doesn't current=
ly
> > > > offer a way to do it right, so it needs a patch, no?
> > >=20
> > > No, I don't think so. We are talking about a regression, right?
> > >=20
> > > On new generation chips, something often doesn't work (which have
> > > worked on old chips for some time). It's not a regresiion. I don't
> > > think that it's sensible to make large change (especially after rc1)
> > > to fix such issue. If you say that the DMA API doesn't work on new
> > > chips and proposes a patch for the next merge window, it's sensible, I
> > > suppose.
> > >=20
> > > Btw, the patch isn't a fix for the DMA API. It tries to extend the DMA
> > > API (and IMO in the wrong way).=20
> > > In addition, the patch might break the
> > > current code.=20
> >=20
> > To "break the current code" is simply not possible. Sorry to oppose. As=
 you have written it=20
> > "extend the DMA API", so if you do not use the new API (and no current =
code is using it)
> > you cannot "break the current code".=20
>=20
> Looks like that the patch adds the new API that touches the exisitng
> code. It means the existing code could break. So the exsising API
> could break too.
>=20
> http://thread.gmane.org/gmane.linux.ports.sh.devel/8595
I'm still trying to find out what you actually suggest we should do now.
Maybe this is a request for a minimal "fix" without the cleanups
Guennadi did?  That is only patches 2(?), 4 and 5 of the series?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
