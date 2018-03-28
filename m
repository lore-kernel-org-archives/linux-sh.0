From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 17:00:05 +0000
Subject: Re: [PATCH V4 Resend] ZBOOT: fix stack protector in compressed boot phase
Message-Id: <CAGXu5j+p9fy=fVkBtyXUNH6tmCfraWdZTJCqiRHvyO3vxNxzng@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1522226933-29317-1-git-send-email-chenhc@lemote.com>
 <20180328152115.GB1991@saruman>
In-Reply-To: <20180328152115.GB1991@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Mar 28, 2018 at 8:21 AM, James Hogan <jhogan@kernel.org> wrote:
> On Wed, Mar 28, 2018 at 04:48:53PM +0800, Huacai Chen wrote:
>> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
>> index fdf99e9..81df904 100644
>> --- a/arch/mips/boot/compressed/decompress.c
>> +++ b/arch/mips/boot/compressed/decompress.c
>> @@ -76,12 +76,7 @@ void error(char *x)
>>  #include "../../../../lib/decompress_unxz.c"
>>  #endif
>>
>> -unsigned long __stack_chk_guard;
>> -
>> -void __stack_chk_guard_setup(void)
>> -{
>> -     __stack_chk_guard = 0x000a0dff;
>> -}
>> +const unsigned long __stack_chk_guard = 0x000a0dff;
>>
>>  void __stack_chk_fail(void)
>>  {
>> @@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boot_heap_start)
>>  {
>>       unsigned long zimage_start, zimage_size;
>>
>> -     __stack_chk_guard_setup();
>> -
>>       zimage_start = (unsigned long)(&__image_begin);
>>       zimage_size = (unsigned long)(&__image_end) -
>>           (unsigned long)(&__image_begin);
>
> This looks good to me, though I've Cc'd Kees as apparently the original
> author from commit 8779657d29c0 ("stackprotector: Introduce

I wonder what changed in the compiler -- I regularly boot
stack-protected ARM images. Regardless, this is fine. :)

> CONFIG_CC_STACKPROTECTOR_STRONG") in case there was a particular reason
> this wasn't done in the first place.

I think I was copying from other places? It's been long enough that I
don't remember, actually. :)

> Acked-by: James Hogan <jhogan@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

> (Happy to apply with acks from Kees and ARM, SH maintainers if nobody
> else does).

That'd be fine by me, FWIW. Thanks!

-Kees

-- 
Kees Cook
Pixel Security
