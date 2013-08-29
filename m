From: Olof Johansson <olof@lixom.net>
Date: Thu, 29 Aug 2013 23:59:58 +0000
Subject: Re: [GIT PULL 0/5] Third round of Renesas ARM-based SoC board updates for v3.12
Message-Id: <20130829235958.GI29606@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1377653181.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1377653181.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Wed, Aug 28, 2013 at 10:37:40AM +0900, Simon Horman wrote:
> please consider this third round of Renesas ARM based SoC board
> updates for v3.12.

It's time to start closing down the tree, so please hold these (and the other
branches you sent pull requests for on the 28th) for right after -rc1. We'll of
course be happy to take fixes to things before then, but cleanups and new code
should wait.

That will also simplify a lot of the dependencies on these late branches. :)


Thanks,

-Olof
