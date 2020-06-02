From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 02 Jun 2020 22:41:05 +0000
Subject: Re: linux-sh for-next reactivation
Message-Id: <20200603084105.47bd62c5@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/.dwtc6obdFlmLkY.lFda2yE"
List-Id: <linux-sh.vger.kernel.org>
References: <20200602031123.GA1079@brightrain.aerifal.cx>
        <20200602150039.780a0ac0@canb.auug.org.au>
        <20200602202832.GA3776@brightrain.aerifal.cx>
In-Reply-To: <20200602202832.GA3776@brightrain.aerifal.cx>
To: Rich Felker <dalias@libc.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

--Sig_/.dwtc6obdFlmLkY.lFda2yE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rich,

On Tue, 2 Jun 2020 16:28:33 -0400 Rich Felker <dalias@libc.org> wrote:
>
> On Tue, Jun 02, 2020 at 03:00:39PM +1000, Stephen Rothwell wrote:
> > Hi Rich,
> >=20
> > On Mon, 1 Jun 2020 23:11:39 -0400 Rich Felker <dalias@libc.org> wrote: =
=20
> > >
> > > Could you reactivate linux-next pull from my arch/sh for-next branch?
> > > It's where it was before, at:
> > >=20
> > >     git://git.libc.org/linux-sh for-next
> > >=20
> > > and has newly accepted patches ready. =20
> >=20
> > I already have an SH tree from
> > git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git#sh-next .  Should
> > I do anything with that one?
> >=20
> > It currently contains:
> >=20
> > $ git log --oneline origin/master..sh/sh-next=20
> > a193018e5290 (sh/sh-next) sh: add missing EXPORT_SYMBOL() for __delay
> > 1d5fd6c33b04 sh: add missing DECLARE_EXPORT() for __ashiftrt_r4_xx
> > d70f1e3d5dbd Merge remote-tracking branch 'origin/master' into sh-next
> > baf58858e8b6 sh: prefer __section from compiler_attributes.h
> > 8619b5a9035a sh: Drop -Werror from kernel Makefile
> > 3a3a78124693 sh: kernel: disassemble: Mark expected switch fall-throughs
> > fb8f77490f55 sh: kernel: hw_breakpoint: Fix missing break in switch sta=
tement
> > cd10afbc932d sh: remove unneeded uapi asm-generic wrappers
> > cbfc6edb6a4a sh: use __builtin_constant_p() directly instead of IS_IMME=
DIATE() =20
>=20
> Hi Stephen,
>=20
> I completely forgot that you had the tree from our other co-maintainer
> Yoshinori Sato on the list linux-next is pulling from. Would it be
> okay to keep both? That would help with quickly identifying and
> resolving any conflicting commits and make things go more smoothly
> with two maintainers trying to be active.
>=20
> Let me know if this doesn't work for you and we'll figure out
> alternative arrangements.

Added from today (I called it "sh-rf" - if you want a different name,
please let me know).

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/.dwtc6obdFlmLkY.lFda2yE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7W1YEACgkQAVBC80lX
0GxVZAgAimxKIcraDpE2K87qzDmZP+oslCaTChUho1oSKmGXBvMCq4IfScsvhshQ
Wah5+bTdRM5dzebPB21SuCvXjZhKMVI688ziityzNvLbcak1peFRyBEDhvwR433N
uZeNGl2z+2emgidbCW9byWAxqv3d4Y2sbaGlEbeL377NzQ17yYRn9aqmuNO5MhEC
Yp4pkKC01CTAEkSDcMaf4tzpbcs8hAJpck08MrCB7U/hOx9rWf8RU7DUJc6RT/Jk
Xvi+cggVv5EyXrQ0290qJg+HP6b6bMj0E0rEg08wEXbv1lBmCwHimz6fYWjliEEf
4A48Mz3ZiZStRpp2NyXK6waQCHe2Og==
=98WM
-----END PGP SIGNATURE-----

--Sig_/.dwtc6obdFlmLkY.lFda2yE--
