From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 06 Dec 2008 13:01:29 +0000
Subject: Re: [RFC PATCH V2 FIX] Fix deadlock during find
Message-Id: <20081206130128.GA7885@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081120134502.GA27286@gandalf.sssup.it>
In-Reply-To: <20081120134502.GA27286@gandalf.sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 26, 2008 at 01:04:28PM +0000, Michael Trimarchi wrote:
> ----- Messaggio originale -----
> > Da: Paul Mundt <lethal@linux-sh.org>
> > A: Michael Trimarchi <trimarchimichael@yahoo.it>
> > Cc: linux-sh@vger.kernel.org
> > Inviato: Marted? 25 novembre 2008, 18:06:03
> > Oggetto: Re: [RFC PATCH V2 FIX] Fix deadlock during find
> > 
[snip]

> > > @@ -48,18 +48,18 @@ __mutex_fastpath_lock_retval(atomic_t *count, int 
> > (*fail_fn)(atomic_t *))
> > >  static inline void
> > >  __mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t *))
> > >  {
> > > -    int __res, __orig;
> > > +    int __res;
> > >  
> > >      __asm__ __volatile__ (
> > > -        "movli.l    @%2, %0    \n\t"
> > > -        "mov        %0, %1    \n\t"
> > > +        "1: movli.l    @%1, %0    \n\t"
> > >          "add        #1, %0    \n\t"
> > > -        "movco.l    %0, @%2 "
> > > -        : "=&z" (__res), "=&r" (__orig)
> > > +        "movco.l    %0, @%1 \n\t"
> > > +        "bf        1b\n\t"
> > > +        : "=&z" (__res)
> > >          : "r" (&(count)->counter)
> > >          : "t" );
> > >  
> > > -    if (unlikely(__orig != 0))
> > > +    if (unlikely(__res <= 0))
> > >          fail_fn(count);
> > >  }
> > >  
> > 
> > Making __mutex_fastpath_unlock() loop seems counter-intuitive. I think
> > the initial test on __orig is what was causing you issues rather than the
> > need for looping. I do see why ARM did it this way, but we don't have
> > precisely the same semantics there.
> > 
> > Does the following patch against current git pass your test cases?
> > 
>  This is an old one patch. You integrate the correct one V3
> 
The patch in question was against what is in current git. The very
definition of the fast-path is that it is a single-shot that isn't busy
looping, as that is what the slow path does. Unless you see any
particular issues with my patch, I will queue it up, as it brings us back
in line with what the fast-path semantics are supposed to be. So far I
haven't had any issues with the refactored fast-path.
