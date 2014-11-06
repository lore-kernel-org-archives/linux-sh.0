From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Thu, 06 Nov 2014 21:02:22 +0000
Subject: Re: (bisected) Lock up on sh73a0/kzm9g on cpuidle initialization
Message-Id: <545BE1DE.6060900@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdXaaa2t6+sH2egGacVxkAPeTUkAgwdYsOnMnEPnuLdB5Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXaaa2t6+sH2egGacVxkAPeTUkAgwdYsOnMnEPnuLdB5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 11/06/2014 09:38 PM, Geert Uytterhoeven wrote:
> When CONFIG_CPU_IDLE=3Dy, the kernel locks up during cpuidle initializati=
on
> on Renesas sh73a0/kzm9g-reference, which has a dual-core Cortex-A9.
>
> Last message is:
>
>      DMA: preallocated 256 KiB pool for atomic coherent allocations
>
> After this it's supposed to print:
>
>      cpuidle: using governor ladder
>      cpuidle: using governor menu
>
> I've bisected this to commit 442bf3aaf55a91ebfec71da46a4ee10a3c905bcc
> ("sched: Let the scheduler see CPU idle states").
>
> Reverting that commit, and commit 83a0a96a5f26d974580fd7251043ff70c8f1823d
> ("sched/fair: Leverage the idle state info when choosing the "idlest"
> cpu") which
> depends on it, fixes the problem.
>
> I saw the discussion "lockdep splat in CPU hotplug", so I enabled lockdep
> debugging, but didn't see a lockdep splat.

Did you try the fix attached ?

https://lkml.org/lkml/2014/10/22/722

> I'm using CONFIG_TREE_RCU=3Dy, as this is SMP without PREEMPT.
>
> Anyone with a clue?




>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                  -- Linus Torvalds
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

