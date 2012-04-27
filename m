From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 27 Apr 2012 00:35:50 +0000
Subject: Re: [RFC/PATCH] sh: Remove cast of atomic_t in ATOMIC_INIT macro
Message-Id: <20120427003549.GA7988@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1335149312-1564-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1335149312-1564-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 25, 2012 at 12:11:14PM +0900, Nobuhiro Iwamatsu wrote:
> And this problem occurs by STATIC_KEY_INIT_TRUE and
> STATIC_KEY_INIT_FALSE of include/linux/jump_label.h.
> The architecture by which jumplabel   is defined following,
> 
> > #define STATIC_KEY_INIT_TRUE ((struct static_key) \
> >     { .enabled = ATOMIC_INIT(1), .entries = (void *)1 })
> > #define STATIC_KEY_INIT_FALSE ((struct static_key) \
> >     { .enabled = ATOMIC_INIT(0), .entries = (void *)0 })
> 
> and does not define following.
> 
> > #define STATIC_KEY_INIT_TRUE ((struct static_key) \
> >                { .enabled = ATOMIC_INIT(1) })
> > #define STATIC_KEY_INIT_FALSE ((struct static_key) \
> >                { .enabled = ATOMIC_INIT(0) })
> 
> Although a problem is solved by considering it following.
> 
> > #define STATIC_KEY_INIT_TRUE {ATOMIC_INIT(1)}
> > #define STATIC_KEY_INIT_FALSE {ATOMIC_INIT(0)}
> 
> However, since definitions differ by the same macro name,
> extendibility is lost.
> I think that it is better to remove the cast from ATOMIC_INIT.
> 
Yes, agreed. I'll queue up the patch, thanks.
