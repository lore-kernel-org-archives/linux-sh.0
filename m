From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Jun 2015 07:45:20 +0000
Subject: Re: possible regression caused by "clocksource: sh_tmu: Set cpu_possible_mask to fix SMP broadcast"
Message-Id: <CAMuHMdXeWSMsJ0oGQZcbKqCUepHPe=s+ehyg_sKP9pac1VpVkw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150617024833.GE5143@verge.net.au>
In-Reply-To: <20150617024833.GE5143@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 17, 2015 at 8:52 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Wed, Jun 17, 2015 at 11:48 AM, Simon Horman <horms@verge.net.au> wrote:
>> I have observed what appears to be a regression caused by
>> f2a5473861cf ("clocksource: sh_tmu: Set cpu_possible_mask to fix SMP
>> broadcast"), which was included in v3.19.
>>
>> The problem I see is that with a kernel compiled using marzen_defconfig on
>> the r8a7779/marzen board: i.e. a "legacy" kernel.
>>
>> The problem does not manifest when booting the same board using
>> a kernel built with shmobile_defconfig: i.e. a multiplatform kernel.
>>
>> It does not appear to affect other boards I have access to:
>> emev2/kzm9d, r7s72100/genmai, r8a73a4/ape6evm, r8a7740/armadillo900eva,
>> r8a77798/bockw r8a7790/lager r8a7791/koelsch, r8a7794/alt, sh73a0/kzm9g.
>>
>> I have observed this problem on the renesas-devel-20150617-v4.1-rc8
>> tag of my renesas tree. But I do not believe it is exclusive to that tag.
>>
>> The problem appears to be that there is no clocksource available during
>> early boot. The boot log at the end of the email was obtained by
>> enabling DEBUG_LL and earlyprintk.
>
> Thanks for reporting this. I suspect that the reason why this triggers
> on legacy is that we i such case most likely don't have TWD together
> with CCF. Since this is just old legacy code and the multiplatform

We do have other A9 SMP SoCs (sh73a0, r8a7778).

r8a7779.dtsi has an "arm,cortex-a9-twd-timer" node. r8a7778 hasn't.
sh73a0 also has it, but see http://www.spinics.net/lists/linux-sh/msg39128.html
As bockw and marzen still have -reference variants, it may be more
difficult to fix.

> version should be equivalent I suggest that the correct approach is to
> use multiplatform support instead of legacy. And legacy r8a7779
> support should be removed right away if it hasn't already.

Please wait, so I don't have to rebase the sh73a0/r8a7740 patches I'm
about to send out ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
