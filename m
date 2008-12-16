From: Matt Fleming <mjf@gentoo.org>
Date: Tue, 16 Dec 2008 07:17:45 +0000
Subject: Re: [PATCH] sh: Do not pass SLAB_POISON to kmem_cache_create()
Message-Id: <20081216071745.GA7025@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1229274556-31790-1-git-send-email-mjf@gentoo.org>
In-Reply-To: <1229274556-31790-1-git-send-email-mjf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 16, 2008 at 09:22:35AM +0900, Paul Mundt wrote:
> 
> Applied, thanks. In the future, if your patch is tied to a fixed
> subsystem, please denote that in the subject. ie, something like
> 'sh: maple: ...' so it is obvious where the problem is and what it does
> and does not apply to. There is no need to punish the rest of the port
> for the sins of the dreamcast.

Sorry, will do.
