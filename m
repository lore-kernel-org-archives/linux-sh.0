From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 07 Aug 2011 23:19:34 +0000
Subject: Re: [Regression] Boot crash caused by commit 1eb19a12bd2214cdcad5273d472b062a4ba97fa1
Message-Id: <201108080119.35061.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201108080031.26165.rjw@sisk.pl> <20110807.154137.1593570736451213760.davem@davemloft.net>
In-Reply-To: <20110807.154137.1593570736451213760.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: msb@chromium.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, magnus.damm@gmail.com, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Monday, August 08, 2011, David Miller wrote:
> From: "Rafael J. Wysocki" <rjw@sisk.pl>
> Date: Mon, 8 Aug 2011 00:31:25 +0200
> 
> > Hi,
> > 
> > Unfortuately, your commit 1eb19a12bd2214cdcad5273d472b062a4ba97fa1
> > (lib/sha1: use the git implementation of SHA-1) causes one of my test
> > systems, which is an ARM shmobile Mackerel development boards, to crash
> > during boot (due to referencing invalid addresses AFAICS).
> > 
> > Please fix or revert.
> 
> It's already been fixed by removing the ARM specific SHA1 assembler,
> simply repull.

It works now, thanks!
