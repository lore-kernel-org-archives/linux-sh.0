From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 14 Apr 2010 08:22:22 +0000
Subject: Re: Hi Andrew
Message-Id: <201004141022.22382.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201004140908.16136.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201004140908.16136.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

You undestood exactly!!!
Your answer make very clear all the aspects of the problem

Thanks a lot



In data mercoled=EC 14 aprile 2010 09:30:51, Andrew Stubbs ha scritto:
: > On 14/04/10 08:08, Fabio Giovagnini wrote:
> > Ok. so the Makefile for zImage needs to be modified to use the libc
> > functions embedded into the kernel source tree. Is it right?
> > If yes, how is it possible to have a general coccect behaviour?
>=20
> I'm sorry, I'm not sure I understand the question.
>=20
> Yes, the makefile needs to be modified to remove the dependency on
> libgcc. This was done for the kernel itself a few versions ago. It means
> that the toolchain does not need any special configuration to build the
> kernel, in cases like this where the usermode compiler is incompatible
> with the kernel.
>=20
> If you're asking how to do the modification, I don't know. I'm not a
> kernel hacker.
>=20
> If you're asking how any hypothetical project should handle this, then
> the answer is that they should rely on the toolchain, and not have to
> worry about it. The kernel is special - it is traditionally compiled
> with a toolchain unsuitable for building bare-metal programs. It is
> desirable that the same compiler is used for user mode, and for the
> kernel, because having a whole separate toolchain would be a lot of
> wasted effort, but it means that the kernel makefiles have to work hard
> to reconfigure the tools using custom parameters, linker scripts and
> overriding compiler built-ins.
>=20
> Is that the answer to the question you were asking?
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
