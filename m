From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 05 Jun 2020 15:38:18 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <0af28795-b27a-2dd9-0d0f-c2a8d4b8d512@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org> <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org>
 <20200529175335.GK1079@brightrain.aerifal.cx>
 <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
 <20200601181259.GV1079@brightrain.aerifal.cx>
 <20200602013332.GY1079@brightrain.aerifal.cx>
In-Reply-To: <20200602013332.GY1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

Hi Rich!

On 6/2/20 3:33 AM, Rich Felker wrote:
>>>> [PATCH 1/2] arch/sh: vmlinux.scr
>>>> https://marc.info/?l=linux-sh&m8429470120959&w=2
>>
>> OK.
> 
> Included in -mm.

I just had a look at your tree and it looks you forgot to merge the second
patch of the series, see:

> https://marc.info/?l=linux-sh&m8429470221261&w=2

Can you include the patch as well? And would it be okay to send a PR to Linus
after that?

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
