From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 03 Nov 2011 23:12:28 +0000
Subject: Re: [PATCH 0/3] Change ARCH_NR_GPIO into a Kconfig variable
Message-Id: <201111031912.33040.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1436663.HJnIWhvqZU"
List-Id: <linux-sh.vger.kernel.org>
References: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
	<20111103224452.GS12913@n2100.arm.linux.org.uk>
	<201111031907.46434.vapier@gentoo.org>
In-Reply-To: <201111031907.46434.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org

--nextPart1436663.HJnIWhvqZU
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 03 November 2011 19:07:42 Mike Frysinger wrote:
> i'm aware of these efforts, but i don't see how this Kconfig solution gets
> you there.  it's still a single define depending on arch-specific knobs.=
=20
> now, if this were treated as a max value that was based on all the arch
> needs, it's now useful across SoCs.

s/arch/mach/g
=2Dmike

--nextPart1436663.HJnIWhvqZU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOsx/gAAoJEEFjO5/oN/WBvwEP/2BOrHVDTP0ctjIWGNSMRRsE
f3Wv0ukiY1DHs+1wMJSLzfGIqHsxtZ/FyJR7cwNfXRRlkgaqy4huO0HbtOf8aYl0
nS+fWjq9KmBC2bdr1jKNxVAJ3dFzjXTdTS0F3+dXsdL00lIUA1xA4t7SoBDgOvHO
2EbnuEYwjRspRGZyJQ6BLZj92NxjrQKQx1EaWOe7qQ+JlJuCNcLl0zTFFH7qAoRr
pkf41Lg/9L5MmiYxKqbKmCz7zUr9rGogXu3nJ1GU0WfWGpJ4A6B3aQZHzzWHGKtI
dLOhX8RMP+Hxb3gtF+xauZ8s7yJSx9AcGX7R3VPLLZtwyvH9MdmuVJXpbnGMOfA0
Sb8n5W6/oU6mgP7V4+m0C+GMDAJ3Yb0TKnO54IRoOXRZLZGFfI5asVdvy4Aebppc
SV1pyaZXEX4y4zVJuieIEhZFVccKQH374UFH4i0DZJaOQuztvk3D2tU2QxirJlHu
J/BPDo+BAJnkXv3w4UgTF2hAB/CZ/9FTkzaBrbh37GPJebyl2gyt2wIkvkmF4gr1
Fptm21lr2zb2Q9a636+W51RLG6KfDqASoq9vH4fr0kgYIymspgsXsqzksuwahO8/
AoRGdJrAM0M9lqKgh5uZ5fJbToruuRexmGecKS/F6X8QSJZqk3iRd/9tW3arkAhj
Nx+0JlV4iXBkIxSSCjyR
=VaoW
-----END PGP SIGNATURE-----

--nextPart1436663.HJnIWhvqZU--
