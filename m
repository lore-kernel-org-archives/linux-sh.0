From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 07 May 2010 10:06:43 +0000
Subject: Re: [PATCH] sh: fix clock framework on SH7757
Message-Id: <4BE3E633.60004@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4BE3DB68.1040503@renesas.com>
In-Reply-To: <4BE3DB68.1040503@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Fri, May 07, 2010 at 06:20:40PM +0900, Yoshihiro Shimoda wrote:
>>  - fix the recalc function's prototype
>>  - This CPU don't have FRQCR
>>
> Does it have FRQMR?

No, it doesn't have FRQMR.
But datasheet wasn't written it, actually this cpu may has this register.
I will ask persion in charge about it.

> Does it support variable settings? If so, this just breaks it even
> further since you're just limiting it to one arbitrary configuration.

This CPU has two clock mode. So I have to implement those mode.

> You can look at the updated SH7785 and SH7786 clock frameworks for an
> idea of how to deal with the FRQMR handling and MSTP-bits-as-clocks.
> 
> Any updates to existing subtypes in the clock framework should be moving
> them over to the new interfaces, rather than perpetuating a hardcoded
> pclk and divisors/multipliers for values that aren't fixed by the PLL.

OK. I will study new clock framework and modify this code next week.

Thanks,
Yoshihiro Shimoda
