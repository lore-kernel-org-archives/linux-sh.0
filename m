From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 23 Mar 2010 04:33:03 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: Add i2c_put_adapter on sh_eth_init
Message-Id: <20100323043303.GD13417@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uy6htyqgy.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uy6htyqgy.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 16, 2010 at 11:01:33AM +0900, Kuninori Morimoto wrote:
> i2c_put_adapter is needed after i2c_get_adapter
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/sh/boards/mach-ecovec24/setup.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

On Tue, Mar 16, 2010 at 11:01:53AM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/sh/boards/mach-se/7724/setup.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)

On Tue, Mar 16, 2010 at 11:02:08AM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> In fact, ${LINUX}/arch/sh/kernel/reboot.c :: watchdog_trigger_immediate
> call sh_wdt_write_csr(0xC2);
> But SH7722/SH7723/SH7724 doesn't have 0x40 (= WTCSR_WT) bit.
> It will be just ignored, but should I add any MASK ?
> 
>  arch/sh/include/cpu-sh4/cpu/watchdog.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

applied, thanks.

The watchdog stuff needs a bit of a rework, so I wouldn't worry about it
for now. It's on my TODO list.
