From: Olof Johansson <olof@lixom.net>
Date: Sat, 15 Jun 2013 01:01:48 +0000
Subject: Re: [PATCH 00/11] Renesas ARM-based SoC updates for v3.11 #2
Message-Id: <20130615010148.GN18124@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jun 13, 2013 at 04:00:50PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> this pull-request is based on renesas-soc-for-v3.11 which you have
> previously pulled.
> 
> This pull may cause various conflicts though I believe all of them are not
> difficult to resolve. The renesas-next-20130613 tag in my tree illustrates
> how I have handled the conflicts with both changes already in arm-soc and
> changes I intend to send pull requests for in the near future.
> 
> The following changes since commit 413bfd0e67894c930242482cd15ac09a800e2ab8:
> 
>   ARM: shmobile: sh73a0: div4 clocks must check the kick bit before changing rate (2013-06-07 14:24:52 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.11

Thanks, pulled. Looked like all add/add conflicts. Those clock ID enums, and
their sort of random line wrapping, is odd though. I'm sure it corresponds to
some hardware docs but it seems completely random for someone reading the code.

-Olof
