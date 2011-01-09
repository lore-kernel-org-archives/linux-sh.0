From: Simon Horman <horms@verge.net.au>
Date: Sun, 09 Jan 2011 22:50:42 +0000
Subject: Re: [PATCH] mmc, ARM: Add zboot from MMC support for SuperH Mobile
Message-Id: <20110109225042.GB29257@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110109124928.GC25591@verge.net.au>
	<1294589548.8897.1.camel@rojo>
In-Reply-To: <1294589548.8897.1.camel@rojo>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Sun, Jan 09, 2011 at 04:12:28PM +0000, Pawe=C5=82 Moll wrote:
> Hi,
>=20
> >  Documentation/arm/SH-Mobile/Makefile              |    8 +
> >  Documentation/arm/SH-Mobile/vrl4.c                |  169 +++++++++++++=
++++++++
>=20
> How about putting those two into "tools" (in particular "tools/arm")
> instead of "Documentation"?
>=20
> Just a thought... ;-)

Thats fine by me except that tools/arm doesn't exist yet.
It would be good to get some consensus before creating it.
