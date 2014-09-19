From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Sep 2014 06:07:14 +0000
Subject: Re: [PATCH] ARM: shmobile: Fix wrong calculation in shmobile_init_delay()
Message-Id: <CANqRtoRuM0vdnxn9PQJofEE8GAYpWivUX3s2aafEQ+Sz+9PZWA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5412A889.2000209@renesas.com>
In-Reply-To: <5412A889.2000209@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Khiem-san,

Thanks for your email.

On Fri, Sep 19, 2014 at 10:57 AM, Khiem Nguyen
<khiem.nguyen.xt@renesas.com> wrote:
> Hi Magnus-san,
>
> Thanks for your reply.
>
> On 9/19/2014 10:04 AM, Magnus Damm wrote:
>> Hi Khiem-san,
>>
>> Thanks for your patch.
>>
>> On Fri, Sep 12, 2014 at 5:02 PM, Khiem Nguyen
>> <khiem.nguyen.xt@renesas.com> wrote:
>>> The processing to get CPU information loop on all available CPUs
>>> and decide whether calculating preset_lpj for for CA15 or CA7/8/9.
>>> The calculation will go for CA7/8/9 prior to CA15.
>>>
>>> The commit 0dc50fd ARM: shmobile: support Cortex-A7 in shmobile_init_delay()
>>> introduced wrong CPU selection in case CA15 and CA7/8/9 coexist, e.g R-CarH2.
>>> At the end, it leads to the wrong calculation of preset_lpj for R-CarH2.
>>>
>>> Fix it by selecting the first CPU in DTS file.
>>>
>>> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>

>> I may misunderstand the problem here, but I don't think this patch is needed.
>
> Base on your explanation,  I think it's not needed.
> Sorry for the noise.

No problem, thanks for sending patches.

>> Basically, my view of things is that if we have a CA7 core on the
>> system then a longer delay may be necessary. This to make sure that
>> delays running on CA7 will work as expected as well. This patch
>> introduces some ordering dependency and just considers the first CPU.
>
> So, before 0dc50fd was merged, if all CPUs (CA15 and CA7) in R-CarH2 are enabled,
> like big.LITTLE configuration, system may not run correctly (due to insufficient delay of CA7).
>
> Is it correct ? :)

You are correct that on r8a7790 in upstream only "Big boot mode" with
4 x CA15 SMP mode is working as expected. "Little boot mode" and CA7
seems to lack proper delay handling. =)

I do however wish to get "Little boot mode" correctly supported in
upstream, but we are not 100% there yet. Today there are various
issues related to arch timer and delay calculation in case of "Little
boot mode".

So from my side the "0dc50f5" commit brings us one step closer to
improved CA7 support by correctly handling delays. Arch timer support
needs more work though - both for r8a7794 and r8a7790!

Thanks,

/ magnus
