From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 29 May 2020 10:12:52 +0000
Subject: Re: Build fails with unknown symbol __get_user_unknown with InifiniBand enabled
Message-Id: <11913b96-0a05-7fca-e744-dd29eddf5327@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <8945f9b7-d4d3-851e-dc4f-2d05ed94c169@physik.fu-berlin.de>
In-Reply-To: <8945f9b7-d4d3-851e-dc4f-2d05ed94c169@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Geert!

On 5/29/20 11:59 AM, Geert Uytterhoeven wrote:
>> I have assumed that the problem is similar to what Kuninori Morimoto fixed in the
> 
> Morimoto-san fixed a different issue.

Yes, that's clear :).

>> sh-next branch [2] but I couldn't figure out where __get_user_unknown() is actually
>> defined within the kernel.
> 
> "git grep __get_user_unknown" tells you ;-)
> See __get_user_size in arch/sh/include/asm/uaccess_32.h
> 
>> Does anyone know how to fix this problem?
> 
> __get_user_size() lacks a case for 64-bit values.
> Interestingly, __put_user_size() has one, cfr. __put_user_u64().

Ah, so this is the problem then? I'm surprised that this issue has
surfaced only recently.

Would this be fixed by Arnds patch series to remove SH-5 support by any chance?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
