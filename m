From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Mon, 23 Feb 2009 05:10:42 +0000
Subject: Re: [PATCH 1/3] sh: Add support 32-bit physical addressing by	other
Message-Id: <49A22FD2.5020303@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <499E867C.6080202@renesas.com>
In-Reply-To: <499E867C.6080202@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Jean-Christophe PLAGNIOL-VILLARD wrote:
<- snip ->
> On 19:31 Fri 20 Feb     , Yoshihiro Shimoda wrote:
>> diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
>> index c16ccd4..d7ff2af 100644
>> --- a/arch/sh/boot/Makefile
>> +++ b/arch/sh/boot/Makefile
>> @@ -34,8 +34,10 @@ $(obj)/compressed/vmlinux: FORCE
>>  	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
>>
> is it not possible to create a var or a macro to avoid all this if esle
> and idef else?

Thank you very much for your comment. I modified it as follows. I think that
it improved that before.

******************************************
KERNEL_MEMORY := 0x00000000
ifeq ($(CONFIG_FIXED_PMB),y)
KERNEL_MEMORY := $(shell /bin/bash -c 'printf "0x%08x" \
		     $$[$(CONFIG_MEMORY_START) & 0x1fffffff]')
endif
ifeq ($(CONFIG_29BIT),y)
KERNEL_MEMORY := $(shell /bin/bash -c 'printf "0x%08x" \
		     $$[$(CONFIG_MEMORY_START)]')
endif

KERNEL_LOAD	:= $(shell /bin/bash -c 'printf "0x%08x" \
		     $$[$(CONFIG_PAGE_OFFSET)  + \
			$(KERNEL_MEMORY) + \
			$(CONFIG_ZERO_PAGE_OFFSET)]')

KERNEL_ENTRY	:= $(shell /bin/bash -c 'printf "0x%08x" \
		     $$[$(CONFIG_PAGE_OFFSET)  + \
			$(KERNEL_MEMORY) + \
			$(CONFIG_ZERO_PAGE_OFFSET) + $(CONFIG_ENTRY_OFFSET)]')
******************************************

<- snip ->
>> index 7b4b82b..69fe954 100644
>> --- a/arch/sh/kernel/vmlinux_32.lds.S
>> +++ b/arch/sh/kernel/vmlinux_32.lds.S
>> @@ -15,8 +15,11 @@ OUTPUT_ARCH(sh)
>>  ENTRY(_start)
>>  SECTIONS
>>  {
>> -#ifdef CONFIG_32BIT
>> -	. = CONFIG_PAGE_OFFSET + CONFIG_ZERO_PAGE_OFFSET;
>> +#ifdef CONFIG_FIXED_PMB
>> +	. = CONFIG_PAGE_OFFSET + (CONFIG_MEMORY_START & 0x1fffffff) +
>> +	    CONFIG_ZERO_PAGE_OFFSET;
>> +#elif defined(CONFIG_32BIT)
>> +	. = CONFIG_PAGE_OFFSET + CONFIG_MEMORY_START + CONFIG_ZERO_PAGE_OFFSET;
> sure? 32Bit and 29bit are the same

Thank you! I have made a mistake. I will fix it as follows.

******************************************
#elif defined(CONFIG_32BIT)
	. = CONFIG_PAGE_OFFSET + CONFIG_ZERO_PAGE_OFFSET;
#else
	. = CONFIG_PAGE_OFFSET + CONFIG_MEMORY_START + CONFIG_ZERO_PAGE_OFFSET;
#endif
******************************************

Best Regards,
Yoshihiro Shimoda

