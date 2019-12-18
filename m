From: Karl Nasrallah <knnspeed@aol.com>
Date: Wed, 18 Dec 2019 06:06:12 +0000
Subject: Re: can someone solve string_32.h issue for SH ?
Message-Id: <622503158.752777.1576649172224@mail.yahoo.com>
List-Id: <linux-sh.vger.kernel.org>
References: <339916914.636876.1576627652112.ref@mail.yahoo.com> <339916914.636876.1576627652112@mail.yahoo.com> <87tv5yjssb.wl-kuninori.morimoto.gx@renesas.com> <2107393677.694216.1576641363699@mail.yahoo.com> <87a77qjjjp.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a77qjjjp.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: kuninori.morimoto.gx@renesas.com
Cc: dalias@libc.org, geert@linux-m68k.org, ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hi,

> Hi Karl
>
> Thank you for your help
>
> > Or, can we use general strncpy() instead of SH assemble one ?
>(snip)
> > Though ultimately I do not have a say in that, it would appear that string_32.h is in arch/sh/include/asm
> > and has been there for a very long time.
> > In fact, it appears that x86 also has similar utility functions defined in inline assembly:
> > see arch/x86/include/asm. As straightforward as it would be to make C versions, there may be a reason
> > that they are in inline assembly--optimization would be my guess--and converting it all to C may require>
> > an overhaul of the string.h backend (something I would not be much help with given that I am unable to get
> > modern Linux booting on my machine, which is a Sega Dreamcast).
> > I also do not know what the performance implications of switching it all to C would be, if there even are any.
> >
> > Hopefully this information may be useful and my asm version is alright for the time being;
> > I have not been able to unearth much more on the topic of why this is structured the way it is,
>
> How about this ?
> You / I post each patch
> (= Me:  use generic strnpy() patch
>   You: fixup SH strnpy() patch)
> And follow SH maintainer's judge

That sounds fine to me!

However, I may need to find a better way to send e-mails than via this webclient before doing so. It would appear I've been mucking up pretty badly with reply formatting (sorry!!! I don't know how to fix this thread in the mailing list archives... I had no idea that replying like a normal e-mail was a terrible thing to do!!).

-Karl Nasrallah
