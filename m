From: Valentine <valentine.barshak@cogentembedded.com>
Date: Mon, 06 Jan 2014 13:56:37 +0000
Subject: Re: [PATCH] clk: shmobile: Fix SMTP clock index
Message-Id: <52CAB615.2070305@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1388155329-11124-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1388155329-11124-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/06/2014 05:28 AM, Kuninori Morimoto wrote:
> Hi Valentine
>
>> Use clkidx when registering SMTP clocks instead of loop counter
>> since the value is then used to access the specific clock index bit
>> in the smtp register.
>>
>> The issue was introduced by the following commit:
>> f94859c215b6d977 "clk: shmobile: Add MSTP clock support"
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> ---
>
> In Subject and comment, I think...
>
> - SMTP
> + MSTP
>

This patch is superseded by the "[PATCH V2 1/2] clk: shmobile: Fix MSTP clock index"
which has the typo fixed.

Thanks,
Val.
