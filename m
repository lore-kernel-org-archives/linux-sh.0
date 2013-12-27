From: Valentine <valentine.barshak@cogentembedded.com>
Date: Fri, 27 Dec 2013 17:55:54 +0000
Subject: Re: [PATCH] clk: shmobile: Fix SMTP clock index
Message-Id: <52BDBF2A.5050906@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1388155329-11124-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1388155329-11124-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 12/27/2013 06:53 PM, Laurent Pinchart wrote:
> Hi Valentine,
>
> Thank you for the patch.
>
> On Friday 27 December 2013 18:42:09 Valentine Barshak wrote:
>> Use clkidx when registering SMTP clocks instead of loop counter
>> since the value is then used to access the specific clock index bit
>> in the smtp register.
>>
>> The issue was introduced by the following commit:
>> f94859c215b6d977 "clk: shmobile: Add MSTP clock support"
>
> I wonder how I've failed to notice this :-/

Unfortunately there's more than that. I'll bundle this patch with
another one that attempts to fix a couple of more issues with clks
array initialization and resend the whole series in a bit.

>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Mike, could you please pick this up for v3.14 ?
>
>> ---
>>   drivers/clk/shmobile/clk-mstp.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/shmobile/clk-mstp.c
>> b/drivers/clk/shmobile/clk-mstp.c index e576b60..be7d017 100644
>> --- a/drivers/clk/shmobile/clk-mstp.c
>> +++ b/drivers/clk/shmobile/clk-mstp.c
>> @@ -205,8 +205,8 @@ static void __init cpg_mstp_clocks_init(struct
>> device_node *np) continue;
>>   		}
>>
>> -		clks[clkidx] = cpg_mstp_clock_register(name, parent_name, i,
>> -						       group);
>> +		clks[clkidx] = cpg_mstp_clock_register(name, parent_name,
>> +						       clkidx, group);
>>   		if (!IS_ERR(clks[clkidx])) {
>>   			group->data.clk_num = max(group->data.clk_num, clkidx);
>>   			/*

Thanks,
Val.
