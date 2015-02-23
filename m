From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 23 Feb 2015 21:58:47 +0000
Subject: Re: fs: dax: do not build on ARC or SH
Message-Id: <20150223215847.GA29052@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <5778538.KJ98x3yxkB@wuerfel>
 <20150223184025.GD2780@wil.cx>
 <20150223215634.GA23928@roeck-us.net>
In-Reply-To: <20150223215634.GA23928@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Matthew Wilcox <willy@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>

On Mon, Feb 23, 2015 at 01:56:34PM -0800, Guenter Roeck wrote:
> Guess there a philosophical difference in opinion if the architecture code
> should (have to) provide copy_user_page() or not outside the architecture
> code itself. After all, fs/dax.c _is_ the only user of this function outside
> the architecture code.

Given that copy_user_page just is an optimized version of copy_page
all these architectures should just grab the trivial macro defintion
from the asm-generic version so that we could avoid this discussion.
