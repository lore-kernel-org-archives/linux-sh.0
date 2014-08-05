From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 05 Aug 2014 05:39:15 +0000
Subject: Re: [PATCH] ARM: shmobile: Separate APMU resource data into CPU dependant part
Message-Id: <CANqRtoRRWjr2JumuSoz+ir1mtp=RQOCG2aPe=uSso3i2i5K0+g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1407169276-25495-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1407169276-25495-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 5, 2014 at 10:15 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Aug 04, 2014 at 06:21:16PM +0200, Ulrich Hecht wrote:
>> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>>
>> Since APMU resource data were not common data of the R-Car series,
>> it was separated.
>>
>> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>> [uli: moved header file out of arch/arm/mach-shmobile/include/mach]
>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>> ---
>>
>> This is needed for r8a7794 which has a set of CPU cores different from the
>> other Gen2s.
>
> So unfortunate but given the facts this approach seems reasonable to me.
> Magnus (CCed), do you have an opinion on this?

This information shall really be described via DT in my option.
Perhaps this patch could be one step in the right direction though.
Unfortunately the patch seems to contain incorrect information though,
the r8a7791 SoC only contains two CPU cores so now when we separate
the code perhaps we should do it right?

My suggestion is to add R-Car E2 support as UP-only first, then we can
add SMP bits incrementally over time.

Cheers,

/ magnus
