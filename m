From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 02 Mar 2014 22:52:44 +0000
Subject: Re: [PATCH 1/3] clk: add clock-indices support
Message-Id: <5313B63C.7060802@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1392314571-30107-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392314571-30107-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 02/03/14 22:37, Laurent Pinchart wrote:
> Hi Ben,
>
> On Sunday 02 March 2014 22:28:09 Ben Dooks wrote:
>> On 23/02/14 21:00, Mike Turquette wrote:
>>> Quoting Ben Dooks (2014-02-13 10:02:49)
>>>
>>>> Add a property called clock-indices to allow clock-output-names
>>>> to be used where the index used to lookup a clock is not a 1:1
>>>> mapping to the array position in the clock-output-names
>>>>
>>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>
>>> Ben & Laurent,
>>>
>>> The clock-indices stuff looks sane to me. I've taken Ben's patch #1 into
>>> clk-next. It seems patch #3 might be dropped and patch #2 didn't apply
>>> cleanly for me.
>>>
>>> Can Laurent's patches and Ben's #2 be rebased and sent together as a PR?
>>> I'll leave it up to you guys to figure out the backwards compatibility
>>> issue with Ben's patch #3.
>>
>> Thanks, I've only just found this in my mailbox.
>> Is there still any actions I need to take?
>
> I've sent a pull request for my patches only. Could you please rebase yours ?

Ok, will go and see if I can find it.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
