From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 20 Mar 2014 09:35:23 +0000
Subject: Re: [PATCH 0/5] ARM: shmobile: Enable drivers/sh/pm_runtime.c on multi-platform
Message-Id: <532AB65B.8090002@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 20/03/14 10:14, Geert Uytterhoeven wrote:
> Hi Ben,
>
> On Thu, Mar 20, 2014 at 9:56 AM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>>     [2/5] sh: intc: Restrict INTC_USERIMASK to SH4A
>>
>> I thought there was already a of capable intc driver in the
>> irq drivers directory?
>
> SH4A doesn't use OF. Or am I missing your point?
>
>> Thanks, I will probably not get around to testing this until next
>> week as I am not in the office until Monday now. I think there is
>> one more thing we need to do, which is to do a device suspend and
>> resume like the current davinci implementation.
>
> Thanks, I'll have a look at that.

I've already done a patch which I am testing for it.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
