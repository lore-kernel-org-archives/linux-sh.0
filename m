From: Olof Johansson <olof@lixom.net>
Date: Wed, 28 Aug 2013 16:59:40 +0000
Subject: Re: [GIT 00/14] Second round of Renesas ARM based SoC cleanups for v3.12
Message-Id: <20130828165940.GA8607@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 01, 2013 at 05:26:14PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> Please consider this second round of Renesas ARM based SoC cleanups for
> v3.12.
> 
> This pull-request is based on a merge of renesas-tpu-pwm-for-v3.12,
> renesas-backlight-for-v3.12 and renesas-soc-for-v3.12, each of which
> I have previously sent a pull-request for, in order to provide
> the pre-requisite code that that is being removed or cleaned up.
> 
> The following changes since commit 4431374926363df1d907d9c8783f473eb7facf42:
> 
>   Merge branches 'tpu-pwm', 'backlight' and 'soc' into cleanup2-base (2013-07-24 16:35:12 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup2-for-v3.12

Pulled.

Given that you have inversed the chain of dependencies, I'll just keep
all the "late" (inverted and actual late) renesas branches in one topic
now, since it's just busy work to create next/cleanup2, next/soc2,
next/boards2, etc, just for renesas.


-Olof
