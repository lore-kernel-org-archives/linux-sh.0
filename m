From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 03 May 2014 19:29:43 +0000
Subject: Re: [PATCH] drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI
Message-Id: <CANqRtoTz_kz29Wb0XogbvGrB-LVn6Rit8PggvbvpqTd5VEQqEA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398906582-29888-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1398906582-29888-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Thu, May 1, 2014 at 4:42 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Simon,
>
> On Thu, May 1, 2014 at 6:27 AM, Simon Horman <horms@verge.net.au> wrote:
>> On Thu, May 01, 2014 at 03:09:42AM +0200, Geert Uytterhoeven wrote:
>>> If the kernel is built to support multi-ARM configuration with shmobile
>>> support built in, then drivers/sh is not built. This contains the PM
>>> runtime code in drivers/sh/pm_runtime.c, which implicitly enables the
>>> module clocks for all devices, and thus is quite essential.
>>> Without this, the state of clocks depends on implicit reset state, or on
>>> the bootloader.
>>>
>>> If ARCH_SHMOBILE_MULTI then build the drivers/sh directory, but ensure that
>>> bits that may conflict (drivers/sh/clk if the common clock framework is
>>> enabled) or are not used (drivers/sh/intc), are not built.
>>> Also, only enable the PM runtime code when actually running on a shmobile
>>> SoCs that needs it.
>>>
>>> ARCH_SHMOBILE_MULTI was added a while ago by commit
>>> efacfce5f8a523457e9419a25d52fe39db00b26a ("ARM: shmobile: Introduce
>>> ARCH_SHMOBILE_MULTI"), but drivers/sh was compiled for both
>>> ARCH_SHMOBILE_LEGACY and ARCH_SHMOBILE_MULTI until commit
>>> bf98c1eac1d4a6bcf00532e4fa41d8126cd6c187 ("ARM: Rename ARCH_SHMOBILE to
>>> ARCH_SHMOBILE_LEGACY").
>>>
>>> Inspired by a patch from Ben Dooks <ben.dooks@codethink.co.uk>.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>> This is a minimal solution to fix the issue for multi-platform shmobile
>>> kernels in a multi-platform-friendly way.
>>> As it touches drivers/sh-specific code only, Simom should still be able to
>>> get it in v3.15, and backported to v3.14-stable.
>>>
>>> This is an RFC for several reasons:
>>>   1. I'm at ELC, and away from my hardware to test it properly (also on
>>>      non-shmobile).
>>>   2. Can we already reduce the list of SoCs to check for?
>>>      E.g. is this needed for emev2, which doesn't have MSTP clocks?

Thanks a lot for your efforts! I think this patch makes sense as next
step for Runtime PM since it will allow us to use DT-only for board
support together with Runtime PM.

> According to Magnus, emev2 doesn't rely on Runtime PM, so it can be
> removed from the list.

Correct, but let me clarify a bit. At this point we are not using
Runtime PM in any driver used by EMEV2. At some point it would however
be good to use Runtime PM, so I don't think it would hurt enabling it.
Actually, I think we should enable it for all our SoCs, so matching on
"renesas," may make even more sense.

Cheers,

/ magnus
