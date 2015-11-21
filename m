From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Date: Sat, 21 Nov 2015 15:55:45 +0000
Subject: Re: [PATCH] m32r: Fix clearing of thread info fault code
Message-Id: <20151121165545.14962900@wiggum>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/xi8n/s5t0Ht65BpCjCcMXeY"
List-Id: <linux-sh.vger.kernel.org>
References: <20151119211319.784149af@wiggum>
	<20151119150832.43f94bdd211e71f9f91c90ae@linux-foundation.org>
In-Reply-To: <20151119150832.43f94bdd211e71f9f91c90ae@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>

--Sig_/xi8n/s5t0Ht65BpCjCcMXeY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Nov 2015 15:08:32 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> I don't think we should apply this unless someone can runtime test it.=20
> Presumably the current code works OK, but we just don't know what
> nasties the fixed version might expose.

I fully agree. But who can test it?

> The best I can think of is to put a big FIXME comment in there, so
> perhaps one day if someone is working on m32r stuff, they may try
> fixing it.

Or remove the architecture, if nobody is using it? :)

--=20
Michael

--Sig_/xi8n/s5t0Ht65BpCjCcMXeY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWUJQCAAoJEPUyvh2QjYsOepkP/2Nu5YsjALGCLFlI4TW7aTbd
yEa7gPWPyMlEtnsRzYu/6f43KKEpyYc0yrLY/Zodaketbs1kQq8m4e6gu9+r8alJ
YX1Y/k8y6kdLZ63um7xtgESmXT/bXG+GWot7yXK8zn1xmz96aib2ILMubNFqINPB
YR7LObSqQmYy9MDrxl798ncAQoDC8fUWhhEtESbjRL87izMJZxcjVrkKXC7YD3LQ
IpM9Dr6nxM9T6MJUCzFvkgcWw5kpeOMjH1WquR/KXu0JlRcQUsnI7OBp3HTPLE0u
n9j+VJCm2GqAjlVREvf+9DyOnclIOjxE4RAbuu8/jZjD75szsiG3Xv5u86L7gZ7c
1KFFOfzyXN6KMqsH4v/ObTgzkExDBi+RZ+xlc7Ad1owIZiuNAy4k5YhofOp52Jec
tiez6jLCRoK8hvx+0lbFGD8gRtH2AY+pR8ju4lcolDCBhLpPHyBLX0aXYDTedI/3
k25xPL1ozZqOicmk4OwWTos+mrSJjtBhN32G2hR5Zxg4yRvPnmVs6azCqGHyZ0fA
iov1l9UhjLEGQi/VneR9Q98p5fr3Zwm2w5yHIfdB2c0u5D4nDb8RFE1s84HjFmLx
YQjzIkKZ29WETBnM1ay0unt5GVks694mB3r/RhXkNMmvu0gS5VFoCQ38FqInzx1B
XBpygtag6C/OvPz7yQnx
=xerk
-----END PGP SIGNATURE-----

--Sig_/xi8n/s5t0Ht65BpCjCcMXeY--
