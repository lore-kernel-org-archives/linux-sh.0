From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Date: Thu, 31 Jul 2014 04:07:01 +0000
Subject: Re: [PATCH repost] ARM: shmobile: sh73a0: Remove spurious 0x from SCIFB clock name
Message-Id: <53D9C0E5.7040301@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1406766463.git.horms+renesas@verge.net.au>
 <20140731004246.GA31860@verge.net.au>
In-Reply-To: <20140731004246.GA31860@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Am 31.07.2014 02:42, schrieb Simon Horman:
> A stray '0x' crept into a0f7e7496d56ac2d ("ARM: shmobile: sh73a0: add CMT1
> clock support for DT"). This  patch removes it.
>=20
> This change should not have any run-time affect at this time as

"effect", in case Olof wants to fix it up.

> the clock in question is used by a SCIF device that is not enabled by
> default.
>=20
> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Cheers,
Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 16746 AG N=FCrnberg
