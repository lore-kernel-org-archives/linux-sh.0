From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 12 Feb 2020 17:03:02 +0000
Subject: Re: [PATCH] sh: boards: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Message-Id: <158152698263.121156.7691702987273535933@swboyd.mtv.corp.google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200212101813.9230-1-geert+renesas@glider.be>
In-Reply-To: <20200212101813.9230-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-12 02:18:13)
> The SuperH/J2 DT platform code is not a clock provider, and just needs
> to call of_clk_init().
> 
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
