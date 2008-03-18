From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Mar 2008 03:11:49 +0000
Subject: Re: [PATCH] Use relative path when creating include/asm/{mach,cpu} symlinks
Message-Id: <20080318031149.GA3302@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <47DEC594.6010502@gmail.com>
In-Reply-To: <47DEC594.6010502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 17, 2008 at 08:25:08PM +0100, Franck Bui-Huu wrote:
> From: Franck Bui-Huu <fbuihuu@gmail.com>
> 
> Usually relative paths are preferred because they survive directory
> moves, work across networked file systems/chrooted environments.
> 
Usually, yes. But in this case, as Stuart noted, they are needed for
out-of-tree builds.

It would be nice to get rid of the symlinks completely, and Sam had some
ideas on how we could do that by doing a massive header reorganization,
which is probably the way we'll go in the longer run. For now we just
have to live with the obfuscation. Patches that clean it up without
breaking existing behaviour are welcome, though.
