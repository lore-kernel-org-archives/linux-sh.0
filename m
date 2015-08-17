From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Aug 2015 10:33:20 +0000
Subject: Re: renesas-drivers-2015-08-11-v4.2-rc6
Message-Id: <CAMuHMdW6Bif+DWK-+p9FcjCdn429TfiL3Fzs-cskL35yccMhcw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1439282896-30594-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1439282896-30594-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Mon, Aug 17, 2015 at 12:12 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> >> I've pushed renesas-drivers-2015-08-11-v4.2-rc6 to
>> >> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
>> >> This tree is meant to ease development of platform support and drivers for
>> >> Renesas ARM ("shmobile") SoCs. It's created by merging (a) the for-next
>> >> branches of various subsystem trees and (b) branches with driver code
>> >> submitted or planned for submission to maintainers into the development
>> >> branch of Simon Horman's renesas.git tree.
>> >
>> > I noticed latest kernel can't use sound.
>> > It seems this commit breaks it.
>> >
>> >         0738e941ed60bf3365cbe92a9eb52198f13c13d8
>> >         (Merge branches 'pm-domains', 'pm-sleep' and 'pm-devfreq' into linux-next)
>> >
>> > This commit was OK
>> >
>> >         2b8b3834cb7e5b8116993d0b40f33d81f662124f
>> >         (Merge branch 'pm-opp' into linux-next)
>> >
>> > Are we missing something ? or bug ?
>>
>> Do you see an informative difference in dmesg?
>
> I didn't check detail, but it seems no difference in my check.
>
> commit 0738e941ed60bf3365cbe92a9eb52198f13c13d8 is
> 2b8b383 + 311fa6a + 2fd77ff + 00dabd5
> So, I tried this
>
>         OK 2b8b383
>         OK 2b8b383 + 311fa6a

Does "+" mean merge or cherry-pick?
I assume merge, as these are the parents of the offending merge commit.

>         OK 2b8b383 + 311fa6a + 2fd77ff
>         NG 2b8b383 + 311fa6a + 2fd77ff + 00dabd5

However, merging in 00dabd5 shouldn't make a difference, as it affects
exynos only.

> So, I thought 00dabd5 seems criminal. But,
>
>         OK 2b8b383 + 00dabd5
>
> I should try more, but I need information.
> It seems merge issue ?

I don't think so. I tried to redo the 3 merges separately, and the end result
is the same.

Perhaps the issue is intermittent, and doesn't happen at every boot?
Can you retry "2b8b383 + 311fa6a" and "2b8b383 + 311fa6a + 2fd77ff"?

Alternatively, you can start from 2b8b383 and cherry-pick all commits from the
3 branches that matter (i.e. dropping Documentation and exynos changes),
until it breaks. That would be just
ba2bbfbf63075850bb523e2adb815d45e3509995
311fa6adf92c5110057daa439fdaff012864aa2b
6ce12a977b7e484540482febe47d1e65f7427abf
019d8817b1b064c2bacfbcf40fc68184438ad05a
2fd77fff4b440c29b48c31db0ce2aec7d319959f

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
