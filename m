From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 28 May 2020 22:32:07 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <a2fd7d94-2610-476a-a06a-5a058956db56@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org> <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200528221450.GF1079@brightrain.aerifal.cx>
In-Reply-To: <20200528221450.GF1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hello Rich!

On 5/29/20 12:14 AM, Rich Felker wrote:
> To follow up, I see that there was a patch series of yours (3/24) I
> missed ack'ing fairly recently. At first glance it looks good. It
> happened to arrive while I was getting over being horribly sick with
> what I thought was covid19. If there's further action needed on it
> I'll address it asap now that I'm aware of it.

Glad to hear from you again! I hope you have fully recovered!

> In general, most of the patches I see are things that the linux-sh
> list and myself end up cc'd on that are only tangentially related to
> arch/sh or even not related at all. In that case I normally trust
> other maintainers familiar with the cross-arch changes being made that
> the small arch/sh part of the change is ok if the broader change is
> abstractly ok.
> 
> Part of why I really disliked the "just kill it all" response to this
> thread is that the sh5 removal is specifically for the sake of making
> the arch more maintainable. That, along with forward-porting Sato's
> SH4 device tree patches (I've tried this but ran into problems, and
> need some help with it), has long been on my agenda for the arch, to
> reduce (and ultimately eliminate) the amount of legacy "only on
> arch/sh" stuff left so that it's not a burden on other maintainers and
> contributors. Seeing sentiment along the lines of "why don't you just
> remove it all while you're at it?" as a response is disheartening and
> also dismissive of Arnd's work making the sh5 removal happen.

I agree. I have also poured endless hours into Debian's sh4 port fixing
dozens of bugs myself and reporting them upstream whenever I couldn't
fix them myself.

I would also like to add that getting device tree support into SH would
be a huge leap forward and I would be happy to help with the efforts. I
still have some LANDISK and NextVoD devices available if anyone needs
hardware for testing and development, FWIW.

Would be great to also hear back from Sato-san, he is still active
on his other Linux trees [1].

> Aside from that, the open source & open hardware J-core models are
> still active and in development, with the latest release having been
> made this month, and the J32 with MMU nearly complete and pending
> release, contingent mostly on integration and testing with Linux.

And I'm still very much looking forward to these. I will certainly
buy a bunch of J32 to use them as buildds for Debian's sh4 port!

Thanks,
Adrian

> [1] https://osdn.net/projects/uclinux-h8/scm/git/linux/branches

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
