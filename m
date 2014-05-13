From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 13 May 2014 12:09:57 +0000
Subject: Re: [PATCH] tmio_mmc_pio: prevent endless loop in tmio_mmc_set_clock()
Message-Id: <53720B95.401@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201405040219.30018.sergei.shtylyov@cogentembedded.com> <20140513013820.GC10973@verge.net.au>
In-Reply-To: <20140513013820.GC10973@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, ian@mnementh.co.uk, linux-sh@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org

Hello.

On 05/13/2014 05:38 AM, Simon Horman wrote:

>> I've spent a couple of days with the driver just hanging due to me forgetting
>> to specify the external crystal frequency, so that clk_get_rate() returned 0
>> and thus the loop in tmio_mmc_set_clock() never ended. I don't think that's an
>> acceptable behavior, so I suggest that the minimum frequency is checked for 0
>> in tmio_mmc_host_probe().

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> My suggestion is to update tmio_mmc_host_probe() so that it always exits,
> perhaps returning an error if appropriate.

    Did you mean tmio_mmc_set_clock()?

WBR, Sergei

