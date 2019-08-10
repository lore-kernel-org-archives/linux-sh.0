From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Sat, 10 Aug 2019 02:47:23 +0000
Subject: Re: [PATCH] sh: Drop -Werror from kernel Makefile
Message-Id: <6a06245f-33f2-1d92-0d0e-c8b270dc24af@embeddedor.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1564971263-21562-1-git-send-email-linux@roeck-us.net>
 <20190805032441.GO9017@brightrain.aerifal.cx>
 <20190809195630.GA15606@roeck-us.net>
 <5f26547f-b48e-4b9f-b8ef-858283915e3d@embeddedor.com>
 <20190809215608.GA11065@roeck-us.net>
In-Reply-To: <20190809215608.GA11065@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Guenter,

On 8/9/19 4:56 PM, Guenter Roeck wrote:
> On Fri, Aug 09, 2019 at 04:36:01PM -0500, Gustavo A. R. Silva wrote:
>> Hi Guenter,
>>
>> On 8/9/19 2:56 PM, Guenter Roeck wrote:
>>> On Sun, Aug 04, 2019 at 11:24:41PM -0400, Rich Felker wrote:
>>>> On Sun, Aug 04, 2019 at 07:14:23PM -0700, Guenter Roeck wrote:
>>>>> Since commit a035d552a93b ("Makefile: Globally enable fall-through
>>>>> warning"), all sh builds fail with errors such as
>>>>>
>>>>> arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
>>>>> arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through
>>>>>
>>>>> Since this effectively disables all build and boot tests for the
>>>>> architecture, let's drop -Werror from the sh kernel Makefile until
>>>>> the problems are fixed.
>>>>>
>>>>> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>>
>>>> Acked-by: Rich Felker <dalias@libc.org>
>>>>
>>> Any chance to get this or a similar patch applied soon ? All sh builds
>>> in mainline and -next are still broken.
>>>
>>
>> If no one cares, I can add it to my tree and include it in my pull-request
>> for 5.3-rc4.
>>
>> I would just need your Tested-by.
>>
> 
> Sure:
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> [ Applied to ToT and built sh:{defconfig,allnoconfig,tinyconfig} ]
> 

On second thought it seems to me that this is not a good idea, at least
for mainline. For the time being I'll take this patch for linux-next only.

Who is the maintainer of sh?

The best solution is to fix those fall-through warnings you see. Could you
please send me all the warnings you see? I can try to fix them.

Thanks!
--
Gustavo
