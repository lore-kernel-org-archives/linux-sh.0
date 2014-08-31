From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 31 Aug 2014 02:02:21 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: Add CA7 arch_timer initialization for secondary CPUs
Message-Id: <CANqRtoRrTXQ3auh2fN=2k9RBgTz632uCAA1S4+hiiEN2Qty7BA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409336145-619-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409336145-619-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Sat, Aug 30, 2014 at 3:15 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>
> In case of CA7, arch timer CNTVOFF register is uninitialized.
> CNTVOFF must be initialized. This patch is for secondary CPUs.
>
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> ---
>  arch/arm/mach-shmobile/headsmp.S | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Thanks for the patch. It looks like the CPU core variant is being
run-time detected, if so it would be nice with a comment in the code
about that. If not then we should do some kind of detection.

In my opinion this kind of detection is mainly needed on r8a7790 since
it has both CA15 and CA7. On r8a7794 with only CA7 I assume we can
provide a boot reset vector for this case that is shared with r8a7790
and performs run-time detection and applies the arch timer setup when
needed. The other SMP platforms can simply use a different boot reset
vector to not having to deal with this detection.

This makes me wonder how the boot CPU is supposed to be handled? I
believe it is somehow related to CPU Hotplug as well. Because of that
this is all dependent on SMP.

Did you try this code on r8a7790 Lager in little boot mode? It would
be great to see how it works there. Let's discuss more offline.

Cheers,

/ magnus
