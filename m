From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 07 Feb 2011 06:29:13 +0000
Subject: Re: [RFC, PATCH 3/3] clk: add warnings for incorrect enable/prepare semantics
Message-Id: <AANLkTinq=HieqGUFthm04F21RuLijg2mZH+eoan9p5HN@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<1297058877.800990.238556019385.3.gpush@pororo>
In-Reply-To: <1297058877.800990.238556019385.3.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Feb 7, 2011 at 3:07 PM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
> This change adds warnings to check for:
>
>  1) enabling a clock that hasn't been prepared; and
>
>  2) unpreparing a clock that is still enabled
>
> While the correctness can't be guaranteed, these warnings should cover
> most situations.
>
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
>
> ---
>  drivers/clk/clk.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 51dbd33..2369959 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -35,6 +35,8 @@ void clk_unprepare(struct clk *clk)
>        if (!clk->ops->unprepare)
>                return;
>
> +       WARN_ON(clk->enable_count);
> +
>        mutex_lock(&clk->prepare_lock);
>        if (--clk->prepare_count = 0)
>                clk->ops->unprepare(clk);
> @@ -50,6 +52,8 @@ int clk_enable(struct clk *clk)
>        if (!clk->ops->enable)
>                return 0;
>
> +       WARN_ON(clk->ops->prepare && clk->prepare_count);
> +

Shouldn't the prepare_count be checked against 0 ?
