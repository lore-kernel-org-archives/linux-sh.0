From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 25 Jun 2019 12:02:50 +0000
Subject: Re: [RFC] remove arch/sh?
Message-Id: <401b12c0-d175-2720-d26c-b96ce3b28c71@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190625085616.GA32399@lst.de>
 <ccfa78f3-35c2-1d26-98b5-b21a76b90e1e@physik.fu-berlin.de>
 <20190625112146.GA9580@angband.pl>
In-Reply-To: <20190625112146.GA9580@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adam Borowski <kilobyte@angband.pl>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Adam,

On 6/25/19 1:21 PM, Adam Borowski wrote:
>> We're still using sh4 in Debian
> 
> I wouldn't call it "used": it has popcon of 1, and despite watching many
> Debian channels, I don't recall hearing a word about sh4 in quite a while.

So, according to your logic, Debian should drop the mips64el (popcon 1)
and riscv64 ports (popcon 2) [1]?

> Hardware development is dead: we were promised modern silicon by j-core
> after original patents expired, but after J2 nothing happened, there was
> silence from their side, and now https://j-core.org is down.

It's not dead. You can still run it on an FPGA, the code is freely available.
Plus, the architecture seems to be still in use in the industry [2].

Adrian

> [1] https://popcon.debian.org/
> [2] https://marc.info/?l=linux-sh&m5170489401832&w=2

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
