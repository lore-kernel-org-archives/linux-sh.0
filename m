From: Christoph Hellwig <hch@lst.de>
Date: Tue, 25 Jun 2019 08:56:16 +0000
Subject: [RFC] remove arch/sh?
Message-Id: <20190625085616.GA32399@lst.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus and maintainers,

arch/sh seems pretty much unmaintained these days.  The last time I got
any reply to sh patches from the list maintainers, and the last maintainer
pull request was over a year ago, and even that has been rather sporadic.

In the meantime we've not really seen any updates for new kernel features
and code seems to be bitrotting.
