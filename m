From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 May 2020 08:32:22 +0000
Subject: Re: [PATCH] sh: include linux/time_types.h for sockios
Message-Id: <CAK8P3a281ZLKwkWCKkAdQvA6=XA4=+mKWbwEzK_BR4Uu1c5DNQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200519131327.1836482-1-arnd@arndb.de> <20200519181034.58c67eb5bea24aae24d33421@linux-foundation.org>
In-Reply-To: <20200519181034.58c67eb5bea24aae24d33421@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, May 20, 2020 at 3:10 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 19 May 2020 15:13:13 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Using the socket ioctls on arch/sh (and only there) causes build
> > time problems when __kernel_old_timeval/__kernel_old_timespec are
> > not already visible to the compiler.
> >
> > Add an explict include line for the header that defines these
> > structures.
>
> I can grab this.

Thanks!

> > Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Fixes: 8c709f9a0693 ("y2038: sh: remove timeval/timespec usage from headers")
> > Fixes: 0768e17073dc ("net: socket: implement 64-bit timestamps")
>
> cc:stable?

Yes, I missed that.

     Arnd
