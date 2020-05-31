From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 31 May 2020 09:54:37 +0000
Subject: Re: [PATCH] sh: Implement __get_user_u64() required for 64-bit get_user()
Message-Id: <ba354e30-82ab-68c2-0771-2489463c9279@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200529174540.4189874-1-glaubitz@physik.fu-berlin.de>
 <20200529174540.4189874-2-glaubitz@physik.fu-berlin.de>
 <CAMuHMdWG1wudoBP0EK8FiEj1BMEoL3r5oqJMUEbt2rqRU2gQpw@mail.gmail.com>
In-Reply-To: <CAMuHMdWG1wudoBP0EK8FiEj1BMEoL3r5oqJMUEbt2rqRU2gQpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Geert!

On 5/31/20 11:52 AM, Geert Uytterhoeven wrote:
> As this is the 64-bit variant, I think this single move should be
> replaced by a double move:
> 
>        "mov  #0,%R1\n\t" \
>        "mov  #0,%S1\n\t" \
> 
> Same for the big endian version below.
> 
> Disclaimer: uncompiled, untested, no SH assembler expert.

Right, this makes sense. I'll send a new patch shortly.

As for the assembler review, I'll ask Yutaka Niibe who is a friend of mine
and one of the original SuperH wizards ;).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
