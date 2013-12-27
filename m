From: Valentine <valentine.barshak@cogentembedded.com>
Date: Fri, 27 Dec 2013 10:59:25 +0000
Subject: Re: [PATCH] arm: shmobile: r8a7790: Fix I2C controller names
Message-Id: <52BD5D8D.4060501@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387379302-20223-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387379302-20223-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 12/27/2013 06:10 AM, Simon Horman wrote:
> On Thu, Dec 19, 2013 at 04:35:37PM +0400, Valentine wrote:
>> On 12/19/2013 04:24 PM, Valentine wrote:
>>> On 12/19/2013 12:58 PM, Simon Horman wrote:
>>>> On Wed, Dec 18, 2013 at 09:17:05PM -0800, Kuninori Morimoto wrote:
>>>>>
>>>>> Hi
>>>>>
>>>>>> The R8A7790 is an R-Car Gen2 SoC. The clock division factor
>>>>>> (CDF) width is 3 bits on Gen2 as opposed to 2 bits on Gen1.
>>>>>> Fix the device names for R8A7790 SoC to make the R-Car I2C
>>>>>> driver configure the hardware properly.
>>>>>>
>>>>>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>>>>>> ---
>>>>>
>>>>> Grr... this is correct
>>>>> sorry my fault.
>>>>>
>>>>> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>>>>
>>>>> Simon, this patch is based on below patch
>>>>>
>>>>> 043a3f113ce41e3e6fdbb49551df75e82e8c4ae7
>>>>> (i2c: rcar: fixup rcar type naming)
>>>>
>>>> Thanks.
>>>>
>>>> Valentine could you please:
>>>>
>>>> 1. Rebase this on the fixes-for-v3.13 branch in the renesas tree and;
>>>> 2. Include something like this in the following.
>>>>
>>>> This resolves a regression which was introduced by
>>>> 043a3f113ce41e3 ("i2c: rcar: fixup rcar type naming") in v3.12-rc4.
>>>>
>>>
>>> Sure, I'll rebase, but I think the comment is not needed since the issue here is not really related to 043a3f113ce41e3.
>>> That patch changed the device name from "i2c-rcar_h2" to "i2c-rcar_gen2" in the driver, while the patch that adds i2c to
>>> the r8a7790 platform (b448c904f5058b6c "ARM: shmobile: r8a7790: add I2C support") uses a wrong ("i2c-rcar") name anyways.
>>>
>>
>> In fact there's nothing to rebase to. I've just looked at fixes-for-v3.13. The branch doesn't have commit
>> b448c904f5058b6c "ARM: shmobile: r8a7790: add I2C support" which in fact follows v3.13-rc1 (Linux 3.13-rc1)
>
> Sorry, I assumed this was a fix for v3.13, but its actually a fix
> for code that has been queued up for v3.14.
>
> Could you please do the following:
>
> 1. Note which patch caused the problem in the changelog.
> 2. Rebase on top of the latest devel tag,
>     currently renesas-devel-v3.13-rc5-20131226.
>
> Thanks
>

Just send the V2 version.

Thanks,
Val.
