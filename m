From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Thu, 26 Jun 2014 01:48:19 +0000
Subject: Re: [PATCH 05/14] ARM: shmobile: Mark all SoCs in shmobile as CPUFreq, capable
Message-Id: <53AB7BE3.9070302@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403681315.git.horms+renesas@verge.net.au>
 <6596e97e054647fecb016ecb7e1935aa2b7db954.1403681315.git.horms+renesas@verge.net.au>
 <CAOh2x==C1XDjxdxpE6fYk3j6gO1X7d976Kr-Gjj_-+W6xVzOsw@mail.gmail.com>
 <20140625092609.GC7496@verge.net.au>
In-Reply-To: <20140625092609.GC7496@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon-san,

(2014/06/25 18:26), Simon Horman wrote:
> On Wed, Jun 25, 2014 at 02:26:24PM +0530, Viresh Kumar wrote:
>> On Wed, Jun 25, 2014 at 1:05 PM, Simon Horman
>> <horms+renesas@verge.net.au> wrote:
>>> From: Benoit Cousson <bcousson@baylibre.com>
>>>
>>> Mark all SoCs in shmobile as CPUFreq capable
>>> on multiplatform build only.
>>>
>>> Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
>>> [gaku.inami.xw@bp.renesas.com: Move the definition of cpufreq capable]
>>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>> ---
>>>  arch/arm/mach-shmobile/Kconfig | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
>>> index dbd954e..c32fa7c 100644
>>> --- a/arch/arm/mach-shmobile/Kconfig
>>> +++ b/arch/arm/mach-shmobile/Kconfig
>>> @@ -12,6 +12,8 @@ config ARCH_SHMOBILE_MULTI
>>>         select NO_IOPORT_MAP
>>>         select PINCTRL
>>>         select ARCH_REQUIRE_GPIOLIB
>>> +       select ARCH_HAS_CPUFREQ
>>> +       select ARCH_HAS_OPP
>> https://lkml.org/lkml/2014/6/2/714
>> http://patchwork.ozlabs.org/patch/356780/
> I believe this patch was queued up before those patches hit Linus's tree.
>
> In the case of ARCH_HAS_CPUFREQ, a subsequent patch in
> this pull-request, "ARM: shmobile: Remove ARCH_HAS_CPUFREQ config for shmobile",
> removes it.
>
> Inami-san, could you see about making a patch to remove ARCH_HAS_OPP too?

Sorry for late reply. I posted this patch to linux-sh ML on May 29.
At that time, I couldn't see a patch to remove ARCH_HAS_CPUFREQ.
However, I should have noticed this modification earlier.

