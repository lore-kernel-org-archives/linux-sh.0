From: Olof Johansson <olof@lixom.net>
Date: Tue, 28 May 2013 03:18:26 +0000
Subject: Re: [GIT PULL] Renesas ARM based emev2 SoC updates for v3.11
Message-Id: <20130528031826.GE13532@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1369573523-10980-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1369573523-10980-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, May 26, 2013 at 10:05:22PM +0900, Simon Horman wrote:
> Hi Arnd, Hi Olof,
> 
> The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:
> 
>   Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-emev2-for-v3.11
> 
> for you to fetch changes up to 94a6af856df56ed39bb59ebe17bfa2d10fb333f2:
> 
>   ARM: shmobile: emev2: Remove init_irq declaration in machine description (2013-05-22 21:42:03 +0900)

Hi,

You could have grouped all of the SoC updates into one branch instead of
sending them up SoC by SoC to us. Either way works, just letting you know
there's no need to keep them separate if that's easier.

Also, the changes from Maxime could all have gone into one cleanup branch
together instead of with the SoC code.

Anyway, no harm done, I've pulled this branch (and will pull the others as
well) into our next/soc branch.


Thanks,

-Olof
