From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 21 Dec 2018 07:06:59 +0000
Subject: Re: [GIT PULL] asm-generic: syscall table script for arch/sh
Message-Id: <20181221070659.GA32300@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <CAK8P3a3iAF3J8X2yj7JaCaTM_BcZ--2LZj32kkDf55mBn_cQ5g@mail.gmail.com>
In-Reply-To: <CAK8P3a3iAF3J8X2yj7JaCaTM_BcZ--2LZj32kkDf55mBn_cQ5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Rich Felker <dalias@libc.org>, Firoz Khan <firoz.khan@linaro.org>, Linux API <linux-api@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

> The conversion does not include the old 64-bit sh5 architecture, which
> has never shipped and not even compiled in a long time.

Maybe it is time to drop the code for it then?
