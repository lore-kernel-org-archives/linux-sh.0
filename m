From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 15 Sep 2009 00:41:40 +0000
Subject: Re: [PATCH] sh: kfr2r09: add the reason to change PLL/FLL
Message-Id: <20090915004139.GA16784@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <utyz9kg1v.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <utyz9kg1v.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 11, 2009 at 06:05:00PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  .../mach-kfr2r09/mach/partner-jet-setup.txt        |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

On Mon, Sep 14, 2009 at 08:22:31PM +0900, Kuninori Morimoto wrote:
> This patch prevent USB1 interrupt immediately after re-boot
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/sh/boards/mach-ecovec24/setup.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

On Mon, Sep 14, 2009 at 08:23:00PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/sh/boards/mach-ecovec24/setup.c |   52 ++++++++++++++++++++++++++++++++++
>  1 files changed, 52 insertions(+), 0 deletions(-)

On Mon, Sep 14, 2009 at 08:23:16PM +0900, Kuninori Morimoto wrote:
> this patch modify compile error
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/sh/boards/mach-ecovec24/setup.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

On Tue, Sep 15, 2009 at 09:21:34AM +0900, Kuninori Morimoto wrote:
> After KYCR2 is set, udelay  might become necessary
> when the connected KEY is few.
> This patch add kycr2_delay for this problem.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> v1 -> v2
> 
> add if (pdata->kycr2_delay)
> 
>  arch/sh/include/asm/sh_keysc.h    |    1 +
>  drivers/input/keyboard/sh_keysc.c |    3 +++
>  2 files changed, 4 insertions(+), 0 deletions(-)

All applied (with some minor changelog sanitization), thanks.
