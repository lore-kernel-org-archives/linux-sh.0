From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 01 Apr 2014 09:53:51 +0000
Subject: Re: [PATCH] clk: shmobile: rcar-gen2: fix lb/sd0/sd1/sdh clock parent to pll1
Message-Id: <533A8CAF.90200@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1396277434-24925-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396277434-24925-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/04/14 01:00, Mike Turquette wrote:
> Quoting Laurent Pinchart (2014-03-31 16:38:55)
>> Hi Mike,
>>
>> On Monday 31 March 2014 11:13:10 Mike Turquette wrote:
>>> Quoting Ben Dooks (2014-03-31 07:50:34)
>>>
>>>> The clock generator for rcar-gen2 has the lb, sdh, sd0 and sd1 clocks
>>>> parented to pll1_div2 where the hardware diagram shows these to be
>>>> directly fed from pll1.
>>>>
>>>> This fixes the initial rate for sdh0 clock to be 97.5MHz instead of
>>>> the reported 48MHz where the manual says the default register values
>>>> are for 97.5MHz.
>>>>
>>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>
>>> Taken into clk-next.
>>
>> I'm glad to see the clock patches being applied quickly, but it would make
>> sense to wait at least a couple of days for acks or nacks :-) In this case the
>> patch looks good to me, so there's no issue.
>
> Normally I would, and I did hesitate on the point of waiting for your
> Ack. However the change is a trivial fix and I wanted to get this into
> my pull request for 3.15, so it's not an ordinary circumstance. I've
> added your Ack now.

This isn't exactly a trivial fix. I know it works for the R8A7790 but
it may not work for all rcar-gen2.

Thanks for sorting this.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
