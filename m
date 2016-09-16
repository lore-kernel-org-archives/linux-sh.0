From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Fri, 16 Sep 2016 21:31:41 +0000
Subject: Re: Runtime failure running sh:qemu in -next due to 'sh: fix copy_from_user()'
Message-Id: <20160916213141.GB2356@ZenIV.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20160916191218.GA12104@roeck-us.net>
 <20160916194532.GY2356@ZenIV.linux.org.uk>
 <20160916205938.GB29767@roeck-us.net>
In-Reply-To: <20160916205938.GB29767@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>

On Fri, Sep 16, 2016 at 01:59:38PM -0700, Guenter Roeck wrote:
> Yes, reverting 6e050503a150 fixes the problem.
> 
> I added a BUG() into the "if (unlikely())" below, but it doesn't catch,
> and I still get the ip: OVERRUN errors. Which leaves me a bit puzzled.
> 
> Guenter
> 
> > The change in question is
> >         if (__copy_size && __access_ok(__copy_from, __copy_size))
> > -               return __copy_user(to, from, __copy_size);
> > +               __copy_size = __copy_user(to, from, __copy_size);
> > +
> > +       if (unlikely(__copy_size))
> > +               memset(to + (n - __copy_size), 0, __copy_size);
> >  
> >         return __copy_size;

So we don't even hit that memset()?  What the hell?  __copy_user() is
declared as
__kernel_size_t __copy_user(void *to, const void *from, __kernel_size_t n);

and __copy_size copy_from_user() is

        __kernel_size_t __copy_size = (__kernel_size_t) n;

So
	return __copy_user(to, from, __copy_size);
and
	__copy_size = __copy_user(to, from, __copy_size);
	return __copy_size;
ought to be doing exactly the same thing.  At that point it's starting to
smell like a compiler bug somewhere in there.

Try to remove that (not triggered) if (unlikely(__copy_size)) memset(...)
and see if that's enough to recover.  And it would be nice to see what
all three variants (as it is, with commit reverted and with just that if
removed) generate in e.g. sys_utimensat() (fs/utimes.s)
