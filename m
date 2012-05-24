From: Joe Perches <joe@perches.com>
Date: Thu, 24 May 2012 17:26:11 +0000
Subject: Re: [PATCH] lib/decompress_unxz.c: removing all memory helper functions
Message-Id: <1337880371.5070.24.camel@joe2Laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1337875436-27640-1-git-send-email-tmac@hp.com>
In-Reply-To: <1337875436-27640-1-git-send-email-tmac@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 2012-05-24 at 10:03 -0600, T Makphaibulchoke wrote:
> The patch cleans up the file lib/decompress_unxz.c by removing all memory
> helper functions, e.g., memmove.  By doing so, any architecture's preboot
> environment supporting the XZ decompression needs to define its own copy of
> any of the missing memory helper functions.

Perhaps a silly question, but why not use
the __builtin variants?


