From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 18 Mar 2016 11:16:43 +0000
Subject: Re: [GIT PULL] arch/sh updates for 4.6
Message-Id: <CAMuHMdXf9YuQ58m8xPOsuxNvMeTOGfRy8bzHME34SExduEQ4sQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317180253.GA24679@brightrain.aerifal.cx>
In-Reply-To: <20160317180253.GA24679@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rich,

On Thu, Mar 17, 2016 at 9:22 PM, Rich Felker <dalias@libc.org> wrote:
>> > After the release of v4.6-rc1, you may want to prepare a "for-next" branch
>> > where you commit patches that are meant for the next (v4.7) kernel version,
>> > and inform Stephen Rothwell (CCed, as he may have more advice).
>> > Then your "for-next" branch will be part of "linux-next", and will receive more
>> > testing. Actually it may be a good idea to create a "for-next" branch now,
>> > identical to "sh-for-4.6", let it be included in "linux-next" for a few days,
>> > and send the pull request to Linus afterwards. That would catch accidentally
>> > introduced breakage.
>>
>> OK, I can do that. I don't anticipate any breakage since I haven't
>> touched other archs but it can't hurt to check.
>
> One question on this -- my understanding is that, unlike normal
> branches intended to be pulled by others, for-next is okay to
> rebase/force-push basically at any time. Is that right? I've setup a
> for-next branch at:

Yes, you can rebase your for-next branch.

If you want immutable branches, merge everything (immutable and
non-immutable branches) into your for-next branch when a change has
been made.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
