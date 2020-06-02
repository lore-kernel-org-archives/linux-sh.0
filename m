From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 02 Jun 2020 05:00:39 +0000
Subject: Re: linux-sh for-next reactivation
Message-Id: <20200602150039.780a0ac0@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/gsE_2=m7QKGJH_vSBhfk+y."
List-Id: <linux-sh.vger.kernel.org>
References: <20200602031123.GA1079@brightrain.aerifal.cx>
In-Reply-To: <20200602031123.GA1079@brightrain.aerifal.cx>
To: Rich Felker <dalias@libc.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

--Sig_/gsE_2=m7QKGJH_vSBhfk+y.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rich,

On Mon, 1 Jun 2020 23:11:39 -0400 Rich Felker <dalias@libc.org> wrote:
>
> Could you reactivate linux-next pull from my arch/sh for-next branch?
> It's where it was before, at:
>=20
>     git://git.libc.org/linux-sh for-next
>=20
> and has newly accepted patches ready.

I already have an SH tree from
git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git#sh-next .  Should
I do anything with that one?

It currently contains:

$ git log --oneline origin/master..sh/sh-next=20
a193018e5290 (sh/sh-next) sh: add missing EXPORT_SYMBOL() for __delay
1d5fd6c33b04 sh: add missing DECLARE_EXPORT() for __ashiftrt_r4_xx
d70f1e3d5dbd Merge remote-tracking branch 'origin/master' into sh-next
baf58858e8b6 sh: prefer __section from compiler_attributes.h
8619b5a9035a sh: Drop -Werror from kernel Makefile
3a3a78124693 sh: kernel: disassemble: Mark expected switch fall-throughs
fb8f77490f55 sh: kernel: hw_breakpoint: Fix missing break in switch stateme=
nt
cd10afbc932d sh: remove unneeded uapi asm-generic wrappers
cbfc6edb6a4a sh: use __builtin_constant_p() directly instead of IS_IMMEDIAT=
E()

--=20
Cheers,
Stephen Rothwell

--Sig_/gsE_2=m7QKGJH_vSBhfk+y.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7V3PcACgkQAVBC80lX
0GyoGAf+PUHFAeyT0a8axcC/6t3R6JTTGr4Dx8bRfuVNwMviPCLt9STH6rNfTuCc
12si3wDrMOxdGC6PQ9CTkiHHYd6uGkRrepV859eZiXhr9da6iBfBtazjDgrbA73L
bPuYDvjbj4VppSTh7gBn2XBV0yTRkpdH4b4CBDe5CN1bLvDnmrwVen6gtPnZHJ+V
2ho2argum7J/j5XkvpQaZIpBXtfNwoQRpbJugfUtuUu3m4zmV9vJNFs/47AUJXEF
gVcl6YqhbKORbrEuAk7qS1TMndbCzJhEitnDFYHmyDaW6gWTuB+36bBFHqcpnStD
alFkOAFx1Ae2VkFfn3e+ImoL3vr8mQ==
=btR0
-----END PGP SIGNATURE-----

--Sig_/gsE_2=m7QKGJH_vSBhfk+y.--
