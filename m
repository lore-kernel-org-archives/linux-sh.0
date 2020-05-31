From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 31 May 2020 10:52:20 +0000
Subject: Re: [PATCH] sh: Implement __get_user_u64() required for 64-bit get_user()
Message-Id: <f281aec4-b66c-393b-bb2e-93916abd8a34@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200529174540.4189874-1-glaubitz@physik.fu-berlin.de>
 <20200529174540.4189874-2-glaubitz@physik.fu-berlin.de>
 <CAMuHMdWG1wudoBP0EK8FiEj1BMEoL3r5oqJMUEbt2rqRU2gQpw@mail.gmail.com>
 <ba354e30-82ab-68c2-0771-2489463c9279@physik.fu-berlin.de>
 <2ad089c1-75cf-0986-c40f-c7f3f8fd6ead@physik.fu-berlin.de>
 <CAMuHMdXzje-qFH=pGoouSuXTZYf4NvnzbaYxTm_boMek-DbWMg@mail.gmail.com>
In-Reply-To: <CAMuHMdXzje-qFH=pGoouSuXTZYf4NvnzbaYxTm_boMek-DbWMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Geert!

Thanks a lot for the explanation!

On 5/31/20 12:43 PM, Geert Uytterhoeven wrote:
>> Hmm, this change is not the case for __put_user_asm() vs. __put_user_u64().
>> But I have to admit, I don't know what the part below "3:\n\t" is for.
> 
> It's part of the exception handling, in case the passed (userspace) pointer
> points to an inaccessible address, and triggers an exception.
> 
> For an invalid store, nothing is done, besides returning -EFAULT.
> Hence there's no "mov #0, %1\n\t" in the put_user case.

I have replaced it with two individual mov's now as suggested since I now
understand what's happening here.

> For an invalid load, the data is replaced by zero, and -EFAULT is returned.
> 
>> +__asm__ __volatile__( \
>> +       "1:\n\t" \
>> +       "mov.l  %2,%R1\n\t" \
>> +       "mov.l  %T2,%S1\n\t" \
>> +       "2:\n" \
> 
> (reordering the two sections for easier explanation)
> 
>> +       ".section       __ex_table,\"a\"\n\t" \
>> +       ".long  1b, 3b\n\t" \
> 
> In case an exception happens for the instruction at 1b, jump to 3b.
> 
> Note that the m68k version has two entries here: one for each half of
> the 64-bit access[*].
> I don't know if that is really needed (and thus SH needs it, too), or if
> the exception code handles subsequent instructions automatically.

Hmm. I assume this is something one of the SH maintainers or Yutaka Niibe
can answer.

>> +       ".section       .fixup,\"ax\"\n" \
>> +       "3:\n\t" \
>> +       "mov    #0, %1\n\t" \
> 
> Return zero instead of the data at the (invalid) address.

Makes sense.

>> +       "mov.l  4f, %0\n\t" \
>> +       "jmp    @%0\n\t" \
> 
> Resume at 2b.
> Remember: branch delay slot, so the instruction below is executed first!

I didn't even know that SH has delay slots.

>> +       " mov   %3, %0\n\t" \
> 
> Set err to -EFAULT.

Yes.

>> +       ".balign        4\n" \
>> +       "4:     .long   2b\n\t" \
>> +       ".previous\n" \
> 
>> +       ".previous" \
>> +       :"=&r" (err), "=&r" (x) \
>> +       :"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
> 
> [*] arch/m68k/include/asm/uaccess_mm.h
> 
>                         "1:     "MOVES".l       (%2)+,%1\n"             \
>                         "2:     "MOVES".l       (%2),%R1\n"             \
> 
>                         "       .section __ex_table,\"a\"\n"            \
>                         "       .align  4\n"                            \
>                         "       .long   1b,10b\n"                       \
>                         "       .long   2b,10b\n"                       \
> 

Hmm. I'll wait for more feedback whether need to do the same as on m68k here.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
