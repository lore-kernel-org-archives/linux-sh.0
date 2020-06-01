From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 01 Jun 2020 09:13:26 +0000
Subject: Re: [PATCH] sh: Implement __get_user_u64() required for 64-bit get_user()
Message-Id: <fbfca28d-217d-4857-a010-8c6e277db67c@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200529174540.4189874-1-glaubitz@physik.fu-berlin.de>
 <20200529174540.4189874-2-glaubitz@physik.fu-berlin.de>
 <CAMuHMdWG1wudoBP0EK8FiEj1BMEoL3r5oqJMUEbt2rqRU2gQpw@mail.gmail.com>
 <ba354e30-82ab-68c2-0771-2489463c9279@physik.fu-berlin.de>
 <2ad089c1-75cf-0986-c40f-c7f3f8fd6ead@physik.fu-berlin.de>
 <CAMuHMdXzje-qFH=pGoouSuXTZYf4NvnzbaYxTm_boMek-DbWMg@mail.gmail.com>
 <20200601030300.GT1079@brightrain.aerifal.cx>
 <CAMuHMdUmpLRyYTPO8LPtOyYtraQ77XZqYy9=8cUiWphmpvczmg@mail.gmail.com>
In-Reply-To: <CAMuHMdUmpLRyYTPO8LPtOyYtraQ77XZqYy9=8cUiWphmpvczmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Rich Felker <dalias@libc.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello!

On 6/1/20 11:02 AM, Geert Uytterhoeven wrote:
>> Can I propose a different solution? For archs where there isn't
>> actually any 64-bit load or store instruction, does it make sense to
>> be writing asm just to do two 32-bit loads/stores, especially when
>> this code is not in a hot path?
>>
>> What about just having the 64-bit versions call the corresponding
>> 32-bit version twice? (Ideally this would even be arch-generic and
>> could replace the m68k asm.) It would return EFAULT if either of the
>> 32-bit calls did.
> 
> Yes, that's an option, too.

That's the solution that Michael Karcher suggested to me as an alternative
when I talked to him off-list.

While I understand that it works, I don't like the inconsistency and I also
don't see why we should opt for a potentially slower solution when we can
used the fastest one.

I'm also not sure how the exception handling would properly work when you
have two invocations of __get_user_asm().

My current approach is consistent with the existing code, so I think it's
the natural choice. I just need someone with more experience in SH assembler
than me that the solution is correct.

I have already pinged Niibe-san in private, he'll hopefully get back to me
within the next days.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
