From: Olof Johansson <olof@lixom.net>
Date: Wed, 05 Sep 2012 22:44:13 +0000
Subject: Re: [GIT PULL] Renesas ARM-based SoC: KZM-A9-GT for 3.7 #2
Message-Id: <20120905224413.GC32084@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1346305648-25263-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1346305648-25263-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 30, 2012 at 02:47:27PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following enhancement to the KZM-A9-GT board by
> from Morimoto-san for inclusion in 3.7.
> 
> * This pull request is based on the devel branch of
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
>   which is based on v3.6-rc2.
> 
>   This is to satisfy compile-time dependencies.
>   Please let me know if you would like this handled a different way.

Hi,

It seems like Linus W's devel branch is not a stable one, since at least the
topmost commit you pulled in from his branch is no longer available on it. This
means we can't pull it in as a dependency in arm-soc without risking merge
conflicts, etc.

So, we can't pull in this branch with its dependency without an agreement that
Linus holds a branch stable with at least the pcf857x patch on it. Linus?


-Olof
