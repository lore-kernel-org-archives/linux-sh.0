From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 16 Feb 2010 01:10:41 +0000
Subject: Re: [PATCH] ptrace: unify FDPIC implementations
Message-Id: <20100216011041.GB4889@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1266280229-18469-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1266280229-18469-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>, David Howells <dhowells@redhat.com>, Oleg Nesterov <oleg@redhat.com>, uclinux-dist-devel@blackfin.uclinux.org, linux-sh@vger.kernel.org

On Mon, Feb 15, 2010 at 07:30:29PM -0500, Mike Frysinger wrote:
> The Blackfin/FRV/SuperH guys all have the same exact FDPIC ptrace code in
> their arch handlers (since they were probably copied & pasted).  Since
> these ptrace interfaces are an arch independent aspect of the FDPIC code,
> unify them in the common ptrace code so new FDPIC ports don't need to copy
> and paste this fundamental stuff yet again.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> Acked-by: Roland McGrath <roland@redhat.com>
> Acked-by: David Howells <dhowells@redhat.com>
> Acked-by: Paul Mundt <lethal@linux-sh.org>

Just to follow up on this, this code obviously expects consistent entries
in mm_context_t. Presently include/asm-generic/mmu.h is aimed at nommu,
so it would probably be worthwhile stubbing in the FDPIC loadmap entries
there to make things easier for future ports.
