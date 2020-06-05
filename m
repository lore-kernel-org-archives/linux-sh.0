From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 05 Jun 2020 17:58:29 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <25e0729d-8158-94a4-f081-ccdfa50ecb1d@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org>
 <20200529175335.GK1079@brightrain.aerifal.cx>
 <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
 <20200601181259.GV1079@brightrain.aerifal.cx>
 <20200602013332.GY1079@brightrain.aerifal.cx>
 <0af28795-b27a-2dd9-0d0f-c2a8d4b8d512@physik.fu-berlin.de>
 <20200605154343.GU1079@brightrain.aerifal.cx>
 <c4900bf6-99b3-c9b9-4fd0-7f491bd46de6@physik.fu-berlin.de>
 <20200605155954.GV1079@brightrain.aerifal.cx>
In-Reply-To: <20200605155954.GV1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

Hi Rich!

On 6/5/20 5:59 PM, Rich Felker wrote:
>> Ah, sorry, I missed that. You're right, it should probably go through
>> someone else's tree then.
> 
> Do you know if it's needed to un-break sh4? If so we should push to
> get whoever has jurisdiction over it to include it; otherwise I'm
> indifferent.

No, the patch is only necessary when enabling Infiniband support with
CONFIG_INFINIBAND_USER_ACCESS enabled.

However, according to Geert, every architecture is supposed to have
64-bit get_user() these days, therefore my patch is required anyways,
but it's not an acute problem.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
