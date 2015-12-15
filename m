From: Dirk Behme <dirk.behme@gmail.com>
Date: Tue, 15 Dec 2015 06:31:31 +0000
Subject: Re: [PATCH 2/3] arm64: dts: r8a7795: Add Cortex-A57 CPU cores
Message-Id: <566FB3C3.3060504@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449236333-4410-1-git-send-email-dirk.behme@gmail.com>
 <1449236333-4410-2-git-send-email-dirk.behme@gmail.com>
 <20151211230751.GD6496@verge.net.au> <20151215051243.GA29362@verge.net.au>
In-Reply-To: <20151215051243.GA29362@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 15.12.2015 06:12, Simon Horman wrote:
> On Sat, Dec 12, 2015 at 08:07:51AM +0900, Simon Horman wrote:
>> On Fri, Dec 04, 2015 at 02:38:52PM +0100, Dirk Behme wrote:
>>> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>>>
>>> Add Cortex-A57 CPU cores to r8a7795 SoC for a total of 4 x Cortex-A57.
>>>
>>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>> Sigend-off-by: Dirk Behme <dirk.behme@gmail.com>
>>
>> Thanks, I have queued this up for v4.5.
>
> I meant to test this earlier but somehow it slopped my mind.
>
> With this patch applied I still only see one CPU brought up
> whereas I was expecting 4. Are more patches needed in order to
> get more CPUs operating?


Hmm, I don't think so (?).

I tested this with

https://github.com/dirkbehme/linux-renesas-rcar-gen3/commits/dirk/gen3-latest-update

and got (including the A53 patch)

...
ASID allocator initialised with 65536 entries

Detected PIPT I-cache on CPU1

CPU1: Booted secondary processor [411fd073]

Detected PIPT I-cache on CPU2

CPU2: Booted secondary processor [411fd073]

Detected PIPT I-cache on CPU3

CPU3: Booted secondary processor [411fd073]

Detected VIPT I-cache on CPU4

CPU features: enabling workaround for ARM erratum 845719

CPU4: Booted secondary processor [410fd034]

Detected VIPT I-cache on CPU5

CPU5: Booted secondary processor [410fd034]

Detected VIPT I-cache on CPU6

CPU6: Booted secondary processor [410fd034]

Detected VIPT I-cache on CPU7

CPU7: Booted secondary processor [410fd034]

Brought up 8 CPUs

SMP: Total of 8 processors activated.

CPU: All CPU(s) started at EL1
...

This is based on last weeks renesas-drivers-2015-12-08-v4.4-rc4 and 
besides the patches for SDHI/eMMC I don't think it contains anything 
additional regarding the number of CPU cores.

Best regards

Dirk

