From: Simon Horman <horms@verge.net.au>
Date: Wed, 26 Feb 2014 05:54:03 +0000
Subject: Re: [PATCH] ARM: shmobile: Move SYSC base variable to inside ifdefs
Message-Id: <20140226055357.GA6392@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140224055212.1822.52295.sendpatchset@w520>
In-Reply-To: <20140224055212.1822.52295.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Feb 24, 2014 at 02:52:12PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Move the rcar_sysc_base variable to inside #ifdefs to avoid
> triggering build warnings in case PM or SMP is not selected.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up.
