From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 20 Jun 2015 08:10:01 +0000
Subject: Re: [musl] Re: SH sigcontext ABI is broken
Message-Id: <CAMuHMdWqBh4xJiiEO6a6QQzTrjUJ99w4Bxf3ZkBBBNVk6FNkhA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 19, 2015 at 10:32 PM, Rich Felker <dalias@libc.org> wrote:
> On Fri, Jun 19, 2015 at 09:57:22PM +0200, Andreas Schwab wrote:
>> Rich Felker <dalias@libc.org> writes:
>>
>> > Thanks, but most of the links seem to be broken.
>>
>> Are they?  I'm only seeing a single broken link, which has a mirror.
>
> My bad. Indeed only the davej one is broken, but that's where the code
> must have been introduced (even the earliest commit in tglx
> history.git has the #ifdef __SH4__ for FPU regs) and I can't find a
> cgit interface to it. Fetching several GB to browse history locally is
> going to take a while if I have to do that..

Using web interfaces for archeology doesn't fly.
If you're doing serious Linux work, you should already have a git repository
of the kernel. full-history-linux.git.tar weights in at only ca. 0.5 giB.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
