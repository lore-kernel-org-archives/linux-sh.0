From: David Miller <davem@davemloft.net>
Date: Sun, 07 Aug 2011 22:41:37 +0000
Subject: Re: [Regression] Boot crash caused by commit
Message-Id: <20110807.154137.1593570736451213760.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201108080031.26165.rjw@sisk.pl>
In-Reply-To: <201108080031.26165.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rjw@sisk.pl
Cc: msb@chromium.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, magnus.damm@gmail.com, lethal@linux-sh.org, linux-sh@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 8 Aug 2011 00:31:25 +0200

> Hi,
> 
> Unfortuately, your commit 1eb19a12bd2214cdcad5273d472b062a4ba97fa1
> (lib/sha1: use the git implementation of SHA-1) causes one of my test
> systems, which is an ARM shmobile Mackerel development boards, to crash
> during boot (due to referencing invalid addresses AFAICS).
> 
> Please fix or revert.

It's already been fixed by removing the ARM specific SHA1 assembler,
simply repull.
