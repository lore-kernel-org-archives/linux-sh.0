From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 16 Sep 2016 20:59:38 +0000
Subject: Re: Runtime failure running sh:qemu in -next due to 'sh: fix copy_from_user()'
Message-Id: <20160916205938.GB29767@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20160916191218.GA12104@roeck-us.net>
 <20160916194532.GY2356@ZenIV.linux.org.uk>
In-Reply-To: <20160916194532.GY2356@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>

On Fri, Sep 16, 2016 at 08:45:33PM +0100, Al Viro wrote:
> On Fri, Sep 16, 2016 at 12:12:18PM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > I see the following runtime failure when running a 'sh' image with qemu in -next.
> 
> > Bisect points to commit 6e050503a150 ("sh: fix copy_from_user()"). Bisect log is
> > attached.
> 
> Does reverting it recover the thing?
> 
Yes, reverting 6e050503a150 fixes the problem.

I added a BUG() into the "if (unlikely())" below, but it doesn't catch,
and I still get the ip: OVERRUN errors. Which leaves me a bit puzzled.

Guenter

> The change in question is
>         if (__copy_size && __access_ok(__copy_from, __copy_size))
> -               return __copy_user(to, from, __copy_size);
> +               __copy_size = __copy_user(to, from, __copy_size);
> +
> +       if (unlikely(__copy_size))
> +               memset(to + (n - __copy_size), 0, __copy_size);
>  
>         return __copy_size;
> 
> so the only difference is zeroing the tail of destination; return value
> remains the same in all cases (what used to be return foo(); becomes
> __copy_size = foo(); /* operations not modifying __copy_size */
> return __copy_size;) and that memset is 100% legitimate -
> copy_from_user(to, from, n) returning m means that the last m bytes of
> [to .. to + n - 1] have not been copied into and must be zeroed.
> 
> If it affects anything at all, we have a serious problem somewhere in the
> caller.
