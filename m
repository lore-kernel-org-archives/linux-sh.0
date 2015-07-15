From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Jul 2015 05:59:32 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a7779 Marzen legacy fix V2
Message-Id: <CANqRtoTTr2WgjdMVYkzAzeyVWpS0qCWnqtFng0BgxSRh=_g4rA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150714072522.2854.69938.sendpatchset@little-apple>
In-Reply-To: <20150714072522.2854.69938.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Jul 15, 2015 at 9:23 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Jul 14, 2015 at 04:25:22PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Unbreak the r8a7779 Marzen legacy code provided by marzen_defconfig.
>>
>> As it is today Marzen multiplatform is working, but the legacy code
>> is broken. This patch intends to leave multiplatform as-is but do
>> a simple one-shot fix to unbreak the legacy code base.
>>
>> Without this patch there is no preset delay and the TWD is defined
>> both in C code and in DT. Solve the delay by invoking shmobile_init_delay()
>> and simply disable TWD in case of building for legacy.
>>
>> Marzen legacy code will be removed in the near future, but until then
>> we may as well avoid breaking it.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>
>
> Thanks, that does seem to improve things a lot.
> I can now boot all the way to a nfs userspace :^)

Yay!

> Tested-by: Simon Horman <horms+renesas@verge.net.au>

Thanks for testing!

> I wonder if we should also add the following?
>
> Fixes: f2a5473861cf ("clocksource: sh_tmu: Set cpu_possible_mask to fix SMP broadcast")
>
>
> For the record, I found that after I enabled CONFIG_SMSC_PHY the boot
> now gets as far as initialising SDHI.

Feel free to include any comment you think will help. My view is that
the TMU commit pointed out by itself is not really troublesome, it is
more that on legacy systems using earlytimer and TWD that this problem
happens. For multiplatform the commit is fine.

Cheers,

/ magnus
