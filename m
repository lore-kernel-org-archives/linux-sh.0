From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 07 May 2010 09:26:58 +0000
Subject: Re: [PATCH] sh: fix clock framework on SH7757
Message-Id: <20100507092658.GB14009@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4BE3DB68.1040503@renesas.com>
In-Reply-To: <4BE3DB68.1040503@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 07, 2010 at 06:20:40PM +0900, Yoshihiro Shimoda wrote:
>  - fix the recalc function's prototype
>  - This CPU don't have FRQCR
> 
Does it have FRQMR?

Does it support variable settings? If so, this just breaks it even
further since you're just limiting it to one arbitrary configuration.

You can look at the updated SH7785 and SH7786 clock frameworks for an
idea of how to deal with the FRQMR handling and MSTP-bits-as-clocks.

Any updates to existing subtypes in the clock framework should be moving
them over to the new interfaces, rather than perpetuating a hardcoded
pclk and divisors/multipliers for values that aren't fixed by the PLL.
