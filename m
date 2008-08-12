From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 12 Aug 2008 02:38:54 +0000
Subject: Re: [PATCH 3/3] binfmt_elf_fdpic: Wire up AT_EXECFD, AT_EXECFN, AT_SECURE.
Message-Id: <20080812023854.GB9162@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080806103458.GE2610@linux-sh.org> <20080806103615.GC5194@linux-sh.org> <20080811141855.a4ddf04d.akpm@linux-foundation.org>
In-Reply-To: <20080811141855.a4ddf04d.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: dhowells@redhat.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Aug 11, 2008 at 02:18:55PM -0700, Andrew Morton wrote:
> On Wed, 6 Aug 2008 19:36:15 +0900
> Paul Mundt <lethal@linux-sh.org> wrote:
> 
> > These auxvec entries are the only ones left unhandled out of the current
> > base implementation. This syncs up binfmt_elf_fdpic with linux/auxvec.h
> > and current binfmt_elf.
> 
> The patches ran afoul of the credentials changes in linux-next.
> 
> #1 and #2 applied OK, but #3 tossed the below reject.  Please check
> that my (fairly obvious) fixups are OK.
> 
Yes, your fixups look fine, thanks.

Also note that you are missing David's signed-off-by on 2/3:

http://marc.info/?l=linux-sh&m1784461423443&w=2
