From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 13 Aug 2019 13:18:54 +0000
Subject: Re: [PATCH] sh: Drop -Werror from kernel Makefile
Message-Id: <ee8b2e37-643d-9b29-b7de-d83c7739c3a0@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1564971263-21562-1-git-send-email-linux@roeck-us.net>
 <87a7cdpi06.wl-ysato@users.sourceforge.jp>
In-Reply-To: <87a7cdpi06.wl-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A . R . Silva" <gustavo@embeddedor.com>

On 8/13/19 1:49 AM, Yoshinori Sato wrote:
> On Mon, 05 Aug 2019 11:14:23 +0900,
> Guenter Roeck wrote:
>>
>> Since commit a035d552a93b ("Makefile: Globally enable fall-through
>> warning"), all sh builds fail with errors such as
>>
>> arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
>> arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through
>>
>> Since this effectively disables all build and boot tests for the
>> architecture, let's drop -Werror from the sh kernel Makefile until
>> the problems are fixed.
>>
>> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   arch/sh/kernel/Makefile | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
>> index 59673f8a3379..ef65f0625c6c 100644
>> --- a/arch/sh/kernel/Makefile
>> +++ b/arch/sh/kernel/Makefile
>> @@ -47,5 +47,3 @@ obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
>>   obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
>>   obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-coherent.o
>>   obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
>> -
>> -ccflags-y := -Werror
>> -- 
>> 2.7.4
>>
> 
> Applied sh-next.
> Sorry too late replay.
> 

Please note that _mainline_ builds are currently broken.

Guenter
