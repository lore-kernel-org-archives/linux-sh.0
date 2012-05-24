From: Joe Perches <joe@perches.com>
Date: Thu, 24 May 2012 17:50:49 +0000
Subject: Re: [PATCH] lib/decompress_unxz.c: removing all memory helper functions
Message-Id: <1337881849.5070.32.camel@joe2Laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1337875436-27640-1-git-send-email-tmac@hp.com>
 <1337880371.5070.24.camel@joe2Laptop> <4FBE6FF6.5090904@zytor.com>
 <1337881229.5070.29.camel@joe2Laptop> <4FBE72C4.3040204@zytor.com>
In-Reply-To: <4FBE72C4.3040204@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 2012-05-24 at 10:41 -0700, H. Peter Anvin wrote:
> On 05/24/2012 10:40 AM, Joe Perches wrote:
> > Many of these functions are only optimized in certain cases; if not
> > optimized in a particular case, a call to the library function will be
> > emitted.
> Right, what part of that don't you understand?

:)

Whether or not the many applies to __builtin_mem<foo>.
I believe not.

cheers,

