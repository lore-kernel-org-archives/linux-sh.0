From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 31 May 2020 08:03:13 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <eea4f39c-23d4-d435-a770-652d71268f34@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org> <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org>
 <20200529175335.GK1079@brightrain.aerifal.cx>
 <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
 <8b4ff7fe-c10c-fc8e-72bc-88ef69bdb2b4@landley.net>
In-Reply-To: <8b4ff7fe-c10c-fc8e-72bc-88ef69bdb2b4@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>, Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>

On 5/31/20 5:20 AM, Rob Landley wrote:
> On 5/30/20 3:08 AM, John Paul Adrian Glaubitz wrote:
>> On 5/29/20 7:53 PM, Rich Felker wrote:
>>> Frustratingly, I _still_ don't have an official tree on kernel.org for
>>> the purpose of being the canonical place for linux-next to pull from,
>>> due to policies around pgp keys and nobody following up on signing
>>> mine. This is all really silly since there are ridiculously many
>>> independent channels I could cryptographically validate identity
>>> through with vanishing probability that they're all compromised. For
>>> the time being I'll reactivate my repo on git.musl-libc.org.
>>
>> May I suggest to pick up these patches, for example? There might be
>> more I missed, but getting these merged should already help a lot with
>> the clean-up of arch/sh.
> 
> Does that include the 2 fixes to build with current binutils I made puppy eyes
> about last -rc7 (in march)?
> 
> https://marc.info/?l=linux-sh&m8544749818664&w=2
Yes, listed as "[PATCH 1/2] arch/sh: vmlinux.scr".

@Rich: Do you think you can merge all those fixes in your local tree within
       the next days and send a PR to Linus?

Otherwise, I can volunteer to become a third maintainer for arch/sh as I have
the hardware for testing and can accept patches and send PRs.

We shouldn't let contributors to arch/sh wait for too long.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
