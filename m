From: Olof Johansson <olof@lixom.net>
Date: Tue, 04 Nov 2014 22:39:01 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC r8a73a4 DT Timers Updates for v3.19
Message-Id: <20141104223901.GF5908@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1414557047.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1414557047.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Oct 29, 2014 at 01:59:53PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC r8a73a4 DT timers updates for v3.19.
> 
> This pull-request is based on "[GIT PULL] Renesas ARM Based SoC DT Cleanups
> for v3.19", tagged as dt-cleanups-for-v3.19, which I have also sent a
> pull-request for.
> 
> The reason for this base is to avoid conflicts.
> 
> 
> This pull-request is in a stand-alone branch as it includes
> an board, SoC and DT changes that depend on each other in
> an order other than the way branches dependencies are usually arranged.
> 
> 
> The following changes since commit 120f038cf04b95dc895cba503a7516ff75561438:
> 
>   ARM: shmobile: kzm9d dts: Add chosen/stdout-path (2014-10-24 10:44:10 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-r8a73a4-dt-timers-for-v3.19
> 
> for you to fetch changes up to fd3edcbe9f7bf24b13cadca7616f8e10bbe7e2b3:
> 
>   ARM: shmobile: r8a73a4: Remove empty r8a73a4_add_dt_devices (2014-10-24 11:54:49 +0900)

Merged into next/dt.


-Olof
