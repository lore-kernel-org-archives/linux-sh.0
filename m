From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 11 Nov 2011 08:05:40 +0000
Subject: Re: [PATCH 15/20] ARM: mach-shmobile: add bonito board support.
Message-Id: <20111111080539.GK29807@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87fwhv9y0d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fwhv9y0d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 10, 2011 at 06:46:45PM -0800, Kuninori Morimoto wrote:
> This adds basic bonito board (R-Mobile A1) support

On Thu, Nov 10, 2011 at 06:46:56PM -0800, Kuninori Morimoto wrote:
> devices enable/disable are controled by dip-switch on bonito board.
> If bonito core board is connected to base board,
> you can check the settings from FPGA.
> This patch adds basic code and controls SCIFA5 settings

On Thu, Nov 10, 2011 at 06:47:07PM -0800, Kuninori Morimoto wrote:
> bonito board needs some settings by pmic which use i2c access.
> It is dependent on the device to be used.
> This patch adds standard settings.

On Thu, Nov 10, 2011 at 06:47:16PM -0800, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-bonito.c  |  117 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/clock-r8a7740.c |    6 ++-
>  2 files changed, 122 insertions(+), 1 deletions(-)

On Thu, Nov 10, 2011 at 06:47:26PM -0800, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-bonito.c |   78 +++++++++++++++++++++++++++++++++
>  1 files changed, 78 insertions(+), 0 deletions(-)

On Thu, Nov 10, 2011 at 06:47:36PM -0800, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-bonito.c |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)

These have been rolled in to rmobile/bonito (which is based off of
rmobile/a1), where you can do some preliminary integration testing. I
won't roll it in to rmobile-latest until the necessary machine type has
settled though, as we're presently not able to build the defconfig until
that dependency has been sorted out.
