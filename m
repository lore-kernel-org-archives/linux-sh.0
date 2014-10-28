From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Oct 2014 07:59:28 +0000
Subject: Re: non-Multiplatform APE6EVM broken in v3.18-rc1
Message-Id: <CAMuHMdXmOeJowF9FSQtoUzNK4zohvSYm+r3qp41-JigAOJ=+fg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141028004131.GA8280@verge.net.au>
In-Reply-To: <20141028004131.GA8280@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Tue, Oct 28, 2014 at 1:41 AM, Simon Horman <horms@verge.net.au> wrote:
> I have noticed that there appears to be a regression between v3.17 and
> v3.18-rc1 such that non-multiplatform APE6EVM (ape6evm_defconfig) no longer
> boots.  This appears to be the case using both reference DT (MACH_APE6EVM)

How does it manifest itself?
If you don't get any console output, have you tried my early debug patch?

> and Legacy-C (MACH_APE6EVM_REFERENCE).
>
> I have tried bisecting this problem but dew a blank: the problem
> seems to arise on a merge commit.

Which merge commit?

> This problem also seems to be present in v3.18-rc2 and the devel and next
> branches of my renesas tree (which are based on v3.18-rc2 and v3.18-rc1
> respectively).
>
> To be clear this problem, whatever it is, does not seem to affect
> multiplatform APE6EVM (shmobile_defconfig).

AFAIK, there's no APE6EVM support in multiplatform yet?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
