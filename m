From: Michael Trimarchi <trimarchimichael@yahoo.it>
Date: Wed, 26 Nov 2008 13:04:28 +0000
Subject: Re: [RFC PATCH V2 FIX] Fix deadlock during find
Message-Id: <375040.72760.qm@web23502.mail.ird.yahoo.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20081120134502.GA27286@gandalf.sssup.it>
In-Reply-To: <20081120134502.GA27286@gandalf.sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,



----- Messaggio originale -----
> Da: Paul Mundt <lethal@linux-sh.org>
> A: Michael Trimarchi <trimarchimichael@yahoo.it>
> Cc: linux-sh@vger.kernel.org
> Inviato: Marted=EC 25 novembre 2008, 18:06:03
> Oggetto: Re: [RFC PATCH V2 FIX] Fix deadlock during find
>=20
> On Thu, Nov 20, 2008 at 02:45:02PM +0100, Michael Trimarchi wrote:
> > Fix a deadlock during find.
> >=20
> > Continue with testing i find and errata implementation in the unlock.
> > This patch fix the deadlock.
> >=20
> > Signed-off-by: Michael Trimarchi=20
> >=20
> > ---
> >  arch/sh/include/asm/mutex_sh.h |   12 ++++++------
> >  1 files changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/arch/sh/include/asm/mutex_sh.h b/arch/sh/include/asm/mutex=
_sh.h
> > index c98e875..c65f19e 100644
> > --- a/arch/sh/include/asm/mutex_sh.h
> > +++ b/arch/sh/include/asm/mutex_sh.h
> > @@ -48,18 +48,18 @@ __mutex_fastpath_lock_retval(atomic_t *count, int=20
> (*fail_fn)(atomic_t *))
> >  static inline void
> >  __mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t *))
> >  {
> > -    int __res, __orig;
> > +    int __res;
> > =20
> >      __asm__ __volatile__ (
> > -        "movli.l    @%2, %0    \n\t"
> > -        "mov        %0, %1    \n\t"
> > +        "1: movli.l    @%1, %0    \n\t"
> >          "add        #1, %0    \n\t"
> > -        "movco.l    %0, @%2 "
> > -        : "=3D&z" (__res), "=3D&r" (__orig)
> > +        "movco.l    %0, @%1 \n\t"
> > +        "bf        1b\n\t"
> > +        : "=3D&z" (__res)
> >          : "r" (&(count)->counter)
> >          : "t" );
> > =20
> > -    if (unlikely(__orig !=3D 0))
> > +    if (unlikely(__res <=3D 0))
> >          fail_fn(count);
> >  }
> > =20
>=20
> Making __mutex_fastpath_unlock() loop seems counter-intuitive. I think
> the initial test on __orig is what was causing you issues rather than the
> need for looping. I do see why ARM did it this way, but we don't have
> precisely the same semantics there.
>=20
> Does the following patch against current git pass your test cases?
>=20
 This is an old one patch. You integrate the correct one V3

Regards MIchael


     =20
