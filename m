From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 11 Feb 2010 23:26:16 +0000
Subject: Re: [PATCH] ptrace: unify FDPIC implementations
Message-Id: <20100211232616.GC907@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1265880960-26676-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1265880960-26676-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, Feb 11, 2010 at 04:36:00AM -0500, Mike Frysinger wrote:
> The Blackfin/FRV/SuperH guys all have the same exact FDPIC ptrace code in
> their arch handlers (since they were probably copied & pasted).  Since
> these ptrace interfaces are an arch independent aspect of the FDPIC code,
> unify them in the common ptrace code so new FDPIC ports don't need to copy
> and paste this fundamental stuff yet again.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Acked-by: Paul Mundt  <lethal@linux-sh.org>
