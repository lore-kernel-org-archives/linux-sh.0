From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Oct 2013 09:30:42 +0000
Subject: Re: [PATCH 3/6] sh: clkfwk: Select sh-/common- clkfwk alternatively
Message-Id: <CANqRtoSwYgTHSzrrYNULajn45gsSJw9ST7rb=WGiHiLDsQLSTQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <52410F86.4040301@renesas.com>
	<20130924131206.d57d07f5faa5cb0773fc328c@ops.dti.ne.jp>
In-Reply-To: <20130924131206.d57d07f5faa5cb0773fc328c@ops.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: takasi-y@ops.dti.ne.jp
Cc: SH-Linux <linux-sh@vger.kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>, Paul Mundt <lethal@linux-sh.org>, Mike Turquette <mturquette@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Tue, Sep 24, 2013 at 1:12 PM,  <takasi-y@ops.dti.ne.jp> wrote:
> Make sh clock framework core depend on HAVE_MACH_CLKDEV, and
> set it
> - y on sh for backward compatibility
> - !CONFIG_COMMON_CLK on sh-mobile
> This is a preparation for migration to common clock framework
> from sh clock framework on sh-mobile.
>
> Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> ---
>  arch/arm/Kconfig        | 2 +-
>  arch/sh/Kconfig         | 1 +
>  drivers/sh/clk/Makefile | 3 +--
>  3 files changed, 3 insertions(+), 3 deletions(-)

Hi Yoshii-san,

Thanks for your patch. I'm sure there is a reason behind this, but I'm
trying to understand why you need this modification. It looks to me
like you're trying to enable COMMON_CLK on ARCH_SHMOBILE but in my
mind it is enough to only enable COMMON_CLK in the case of
ARCH_SHMOBILE_MULTI.

During my test using ARCH_SHMOBILE_MULTI on KZM9D I omitted this patch
and only used patch 1, 2, 4, 5, and a modified 6 from your series.
This worked just fine, but I may be missing something.

Let me know if you really want to keep this patch or not. If it's not
needed for MULTIPLATFORM then I suggest that we just drop it.

Cheers,

/ magnus
