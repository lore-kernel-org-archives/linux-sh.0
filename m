From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 05 Jun 2020 15:47:34 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <c4900bf6-99b3-c9b9-4fd0-7f491bd46de6@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org> <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org>
 <20200529175335.GK1079@brightrain.aerifal.cx>
 <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
 <20200601181259.GV1079@brightrain.aerifal.cx>
 <20200602013332.GY1079@brightrain.aerifal.cx>
 <0af28795-b27a-2dd9-0d0f-c2a8d4b8d512@physik.fu-berlin.de>
 <20200605154343.GU1079@brightrain.aerifal.cx>
In-Reply-To: <20200605154343.GU1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

On 6/5/20 5:43 PM, Rich Felker wrote:
>> Can you include the patch as well?
> 
> This one is outside arch/sh and I'm not sure it's permissible to go up
> through my tree. I was also under the impression that only part 1 was
> needed to fix the immediate problem on sh and tha part 2 was for
> completeness and to make sure the same doesn't happen on other archs
> in the future, but maybe my understanding here is incorrect.

Ah, sorry, I missed that. You're right, it should probably go through
someone else's tree then.

>> And would it be okay to send a PR to Linus
>> after that?
> 
> Sure, will do right away once we resolve what to do with the above,
> and provided you don't have anything else you want me to evaluate for
> inclusion.

Since we haven't agreed on the __get_user_64() patch yet, I would be
in favor of getting the changes pulled in that have already been
reviewed and acknowledged. I rather don't want the other contributors
to wait any longer. Arnd in particular has done a tremendous job to
untangle all the SH-5 code and I think we should finally get this
in :).

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
