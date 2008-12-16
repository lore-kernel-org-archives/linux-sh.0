From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 16 Dec 2008 00:22:35 +0000
Subject: Re: [PATCH] sh: Do not pass SLAB_POISON to kmem_cache_create()
Message-Id: <20081216002235.GB7407@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1229274556-31790-1-git-send-email-mjf@gentoo.org>
In-Reply-To: <1229274556-31790-1-git-send-email-mjf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Dec 14, 2008 at 05:09:16PM +0000, Matt Fleming wrote:
> SLAB_POISON is not a valid flag for kmem_create_cache() unless
> CONFIG_DEBUG_SLAB is set, and can we ever know if it's set? Since no
> drivers seem to use this flag just remove it from the flags argument.
> 
> Acked-by: Adrian McMenamin <adrian@newgolddream.dyndns.info>
> Signed-off-by: Matt Fleming <mjf@gentoo.org>

Applied, thanks. In the future, if your patch is tied to a fixed
subsystem, please denote that in the subject. ie, something like
'sh: maple: ...' so it is obvious where the problem is and what it does
and does not apply to. There is no need to punish the rest of the port
for the sins of the dreamcast.
