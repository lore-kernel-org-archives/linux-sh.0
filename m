From: David Long <dave.long@linaro.org>
Date: Tue, 09 Feb 2016 20:53:39 +0000
Subject: Re: [PATCH v3 0/2] Consolidate redundant register/stack access code
Message-Id: <56BA51D3.9030204@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1454996337-7935-1-git-send-email-dave.long@linaro.org>
 <1455010600.13384.3.camel@ellerman.id.au>
In-Reply-To: <1455010600.13384.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 02/09/2016 04:36 AM, Michael Ellerman wrote:
> On Tue, 2016-02-09 at 00:38 -0500, David Long wrote:
>
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Move duplicate and functionally equivalent code for accessing registers
>> and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
>> common kernel files.
>>
>> I'm sending this out again (with updated distribution list) because v2
>> just never got pulled in, even though I don't think there were any
>> outstanding issues.
>
> A big cross arch patch like this would often get taken by Andrew Morton, but
> AFAICS you didn't CC him - so I just added him, perhaps he'll pick it up for
> us :D
>
> cheers
>

Thanks much.

-dl

