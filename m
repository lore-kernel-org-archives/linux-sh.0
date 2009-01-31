From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Sat, 31 Jan 2009 17:53:06 +0000
Subject: Re: [PATCH] fix build failure w. gcc-4.3.3
Message-Id: <20090131185306.6ab017eb@scarran.roarinelk.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20090130102854.GA13640@roarinelk.homelinux.net>
In-Reply-To: <20090130102854.GA13640@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, 31 Jan 2009 12:35:21 -0500
Mike Frysinger <vapier@gentoo.org> wrote:

> On Saturday 31 January 2009 12:13:26 Manuel Lauss wrote:
> > On Sat, 31 Jan 2009 11:56:05 -0500 Mike Frysinger wrote:
> > > On Saturday 31 January 2009 03:46:05 Manuel Lauss wrote:
> > > > On Fri, 30 Jan 2009 11:28:54 +0100 Manuel Lauss wrote:
> > > > > gcc-4.3.3 likes to have printf() and related functions to have
> > > > > at least 2 arguments when the format string is not a constant:
> > > > >
> > > > > cc1: warnings being treated as error
> > > > > arch/sh/kernel/setup.c: In function 'early_parse_mem':
> > > > > arch/sh/kernel/setup.c:111: error: format not a string literal and no
> > > > > format arguments
> > > >
> > > > Please disregard this patch:  turns out that Gentoo applied a patch
> > > > which unconditionally enables -Wformat-security and produces this
> > > > message.
> > >
> > > that's incorrect.  the patch sets format-security on by default, not
> > > unconditionally.  having the common kernel itself build with -Wno-format-
> > > security probably is worthwhile.
> >
> > Well, at least here -Wno-format-security doesn't work, neither on x86,
> > sh nor mips.  Otherwise I would have sent a patch doing exactly that.
> 
> works fine for me.  not that it matters as the kernel already can handle this:
> KBUILD_CFLAGS += $(call cc-option,-Wno-format-security,)

I was beginning to suspect something bad on my end.
 
> also, this isnt a Gentoo specific issue.  other distros are enabling this flag 
> by default as well.  they just dont make cross-compiler generation as easy as 
> Gentoo ;).
> -mike

That's why I like Gentoo so much ;-)

In any case, I rebuilt all compilers without this patch so it's no
longer a concern for me.

Thanks Mike,
	Manuel Lauss
