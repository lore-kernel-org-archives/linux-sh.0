From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 13 Apr 2010 07:13:03 +0000
Subject: Re: Sourcery G++ 4.4-136 Release - kernel 2.6.33 compiled with sh-uclinux-gcc works
Message-Id: <201004130913.03701.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

I have to fix some minors to make it perfectly running.

Regards



In data marted=C3=AC 06 aprile 2010 11:11:07, Andrew Stubbs ha scritto:
: > On 06/04/10 09:06, Fabio Giovagnini wrote:
> > Hi Andrew, the warnign of the kernel I reported you are a problem or I
> > can try the kernel I have built?
> > I solved the problem of the path for FDPIC and  not FDPIC stuff
>=20
> I think you can ignore the 'size changed' warnings. If you have a kernel
> image to boot then why not try it? Mine work on SH7203.
>=20
> I'm not sure how to fix the zImage libgcc issue. I could add a non-FDPIC
> multilib to the toolchain somehow, but that's not as easy as it sounds,
> and we wouldn't want it for anything else. I suggest just using
> uncompressed kernels until the problem is solved.
>=20
> Andrew
>=20


--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
