From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 May 2014 20:43:56 +0000
Subject: Re: [PATCH v5 00/15] Renesas CMT, MTU2 and TMU platform cleanups
Message-Id: <CAMuHMdWWjOi7=UOsjD+xPwUi8NczRHp4o5DOMx7x+Qxw2Bb8yg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398251722-31667-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398251722-31667-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Mon, May 12, 2014 at 10:00 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 12 May 2014 19:00:28 Geert Uytterhoeven wrote:
>> On Mon, May 12, 2014 at 4:03 PM, Laurent Pinchart wrote:
>> >> On Koelsch (both legacy and reference), I get:
>> >> -sh_cmt sh_cmt.0: used for clock events
>> >> -sh_cmt sh_cmt.0: used for periodic clock events
>> >> +sh_cmt sh-cmt-48-gen2.0: ch0: used for clock events
>> >> +sh_cmt sh-cmt-48-gen2.0: ch0: used for periodic clock events
>> >> +sh_cmt sh-cmt-48-gen2.0: ch1: used as clock source
>> >> +Switched to clocksource sh-cmt-48-gen2.0
>> >> +Clockevents: could not switch to one-shot mode:
>> >> +Clockevents: could not switch to one-shot mode: dummy_timer is not
>> >> functional.
>> >> +Could not switch to high resolution mode on CPU 1
>> >> + dummy_timer is not functional.
>> >> +Could not switch to high resolution mode on CPU 0
>> >>
>> >> What's up with the high resolution mode?
>> >
>> > That's surprising, I haven't noticed anything similar before. I've just
>> > tested Simon's latest devel branch on both Koelsch legacy and Koelsch
>> > reference, and I can't reproduce the problem.
>>
>> I did some digging, as I'm usually not running directly from Simon's
>> latest devel branch (currently I have 183 local commits on top of
>> git:///git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git#ren
>> esas-drivers-v3.15-rc5-2014-05-12).
>>
>> The one-shot mode failures I can reproduce with koelsch_defconfig on
>> renesas-devel-v3.15-rc5-20140511.
>>
>> For the high resolution mode errors you have to enable HIGH_RES_TIMERS.
>
> Actually, after investigating the issue, this isn't really surprising, but
> it's a mess nonetheless.
>
> First of all the problem is caused by the combination of the CMT, MTU2 and TMU
> cleanups *and* commit 521c42990e9d561ed5ed9f501f07639d0512b3c9 ("tick-common:
> Fix wrong check in tick_check_replacement()"). The latter has been merged in
> v3.15-rc2, which explains why I haven't noticed the problem before.
>
> Then, please note that the problem only occurs when the architected timer is
> disabled in the kernel configuration, which is the case with
> koelsch_defconfig. If you enable the architected timer the error messages will
> disappear.

Indeed. shmobile_defconfig, which uses the architected tiimer, doesn't
show the messages.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
