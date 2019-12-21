From: Karl Nasrallah <knnspeed@aol.com>
Date: Sat, 21 Dec 2019 02:35:31 +0000
Subject: Re: [PATCH v2 0/3] sh: fixup strncpy()
Message-Id: <20191221023531.GA31@knnspeed.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87woatyutt.wl-kuninori.morimoto.gx@renesas.com>
 <s59o8w3qa0l.wl-ysato@users.sourceforge.jp>
In-Reply-To: <s59o8w3qa0l.wl-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Rich Felker <dalias@libc.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Karl Nasrallah <knnspeed@aol.com>

On Sat, Dec 21, 2019 at 12:42:02AM +0900, Yoshinori Sato wrote:
> On Thu, 19 Dec 2019 10:20:46 +0900,
> Kuninori Morimoto wrote:
> > 
> > 
> > Hi Sato-san, Rich
> > 
> > These are strncpy() fixup patches, but using different solutions.
> > Karl's patches are updating current strncpy(), but using 2 patterns.
> > Kuninori's patch is using generic strncpy().
> > 
> > We don't know which is the best, but we can follow
> > SH maintainer's selection.
> > 
> > Karl Nasrallah (2):
> >       sh: fixup strncpy() warning and add missing padding
> >       sh: fixup strncpy() warning and add missing padding
> > 
> > Kuninori Morimoto (4):
> >       sh: use generic strncpy()
> > 
> > Thank you for your help !!
> > Best regards
> > ---
> > Kuninori Morimoto
> 
> I think the generic version is better, but I want to decide after comparing what code is generated.
> If it is not very inefficient, I would like to make it a generic version.
> 
> --
> Yoshinori Sato

Hello,

I did some testing using the following pure C version:

static inline char *strncpy(char *__dest, const char *__src, size_t __n)
{
	register char * __xdest = __dest;
	const char * __dest_end = __dest + __n - 1;

	if (__n = 0)
		return __xdest;

	while(__dest != __dest_end)
	{
		if(!(*__src))
		{
			*__dest++ = 0;
		}
		else
		{
			*__dest++ = *__src++;
		}
	}

	return __xdest;
}

This takes 8 instructions for the while loop using Os and O2 on SH4 
under GCC 9.2.0. I challenged myself to beat GCC and was only able to
do it in 8 in-loop instructions at best. On SH2A it should be possible
to hit closer to 6, and I think it may be possible to hit 7 on SH4, but
these are the kind of numbers we are looking at.

For reference, this is what I came up with, using only instructions
common to all SH cores:

static inline char *strncpy(char *__dest, const char *__src, size_t __n)
{
	register char * __xdest = __dest;
	const char * __dest_end = __dest + __n - 1;

	if (__n = 0)
		return __xdest;

	__asm__ __volatile__(
		"strncpy_start:\n\t"
			"mov.b @%[src]+,r0\n\t"
		"strncpy_loop:\n\t"
			"cmp/eq %[dest],%[dest_end]\n\t"
			"bt.s strncpy_end\n\t"
			" mov.b r0,@%[dest]\n\t"
			"cmp/eq #0,r0\n\t"
			"bt.s strncpy_loop\n\t"
			" add #1,%[dest]\n\t"
			"bf.s strncpy_loop\n\t"
			" mov.b @%[src]+,r0\n\t"
		"strncpy_end:\n\t"
		: [dest] "+r" (__dest), [src] "+r" (__src)
		: [dest_end] "r" (__dest_end)
		: "r0","t","memory");

	return retval;
}
(In maintaining the spirit of the original work, consider these pieces of
code public domain.)

I did also discover that the m68k and xtensa architectures have similar
assembly strncpy() implementations that do not add padding.

See arch/m68k/include/asm/string.h and arch/xtensa/include/asm/string.h.

Another oddity is that it does not appear that all online documentation
notes that strncpy() is supposed to add padding if the size parameter
exceeds the string size. The official man page of strncpy(3) states it
should, but some other sources make no mention of such behavior.

Hope this helps,
Karl Nasrallah
