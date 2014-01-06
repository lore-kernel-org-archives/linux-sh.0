From: Valentine <valentine.barshak@cogentembedded.com>
Date: Mon, 06 Jan 2014 16:33:17 +0000
Subject: Re: [PATCH V2 0/2] clk: shmobile: clk-mstp fixes
Message-Id: <52CADACD.9050002@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1388232549-6740-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1388232549-6740-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 12/30/2013 01:54 AM, Mike Turquette wrote:
> Quoting Valentine Barshak (2013-12-28 04:09:07)
>> This fixes a number of issues with CPG MSTP clock array handling.
>
> Thanks for the quick respin. Taken into clk-next.

Sorry, I don't see it in https://git.linaro.org/people/mike.turquette/linux.git/shortlog/refs/heads/clk-next
Is this the right place to look for?

>
> Regards,
> Mike

Thanks,
Val.

>
>>
>> Changes in V2:
>> * removed brackets from the one-line for loop
>>
>> Valentine Barshak (2):
>>    clk: shmobile: Fix MSTP clock index
>>    clk: shmobile: Fix MSTP clock array initialization
>>
>>   drivers/clk/shmobile/clk-mstp.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> --
>> 1.8.3.1
>>

