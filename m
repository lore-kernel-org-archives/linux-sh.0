From: Olof Johansson <olof@lixom.net>
Date: Tue, 06 Nov 2012 14:19:25 +0000
Subject: Re: [GIT PULL v2] Renesas ARM-based SoC defconfig for v3.8
Message-Id: <20121106141925.GE27284@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1351731731-8435-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1351731731-8435-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 01, 2012 at 09:02:08AM +0800, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following defconfig enhancements for 3.8.
> 
> I will work on the suggestions by Arnd to reduce the number
> of defconfigs for shmobile - in essence moving towards one or
> two generic configs rather than per-board configs. However,
> this seems to be somewhat non-trivial and in the mean time
> I would like to keep updating the existing defcoings.
> 
> ----------------------------------------------------------------
> The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:
> 
>   Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git defconfig

Thanks, pulled into next/boards with the other branch.


-Olof
