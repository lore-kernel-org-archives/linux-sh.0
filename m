From: Mike Travis <travis@sgi.com>
Date: Thu, 08 May 2008 21:31:09 +0000
Subject: Re: sh migor_defconfig build breakage
Message-Id: <4823711D.70401@sgi.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080508203949.GC22887@cs181133002.pp.htv.fi> <48236E59.8070400@sgi.com>
In-Reply-To: <48236E59.8070400@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Mike Travis wrote:
> Adrian Bunk wrote:
>> Commit aa6b54461cc5c0019b9d792adf3176b444c10763
>> (asm-generic: add node_to_cpumask_ptr macro)
>> causes the following build error with migor_defconfig:
>>
>> <--  snip  -->
>>
>> ...
>>   CC      arch/sh/kernel/asm-offsets.s
>> In file included from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/mm.h:8,
>>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/kernel/asm-offsets.c:13:
>> /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/gfp.h: In function 'alloc_pages_node':
>> /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/gfp.h:190: 
>> error: implicit declaration of function 'cpu_to_node'
>> make[2]: *** [arch/sh/kernel/asm-offsets.s] Error 1
>>
>> <--  snip  -->
>>
>> cu
>> Adrian
>>
> 
> Hi Adrian,
> 
> Thanks for the feedback, I'll cross-compile test this config.
> 
> Mike


Ouch.  I just discovered I don't have a cross-compiler for 'sh'.  Can you point me
towards one?

Thanks,
Mike
