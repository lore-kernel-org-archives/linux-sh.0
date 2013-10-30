From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 30 Oct 2013 00:19:25 +0000
Subject: Re: [PATCH v7 4/5] clk: Add common __clk_get(), __clk_put() implementations
Message-Id: <20131030001924.GX16735@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
 <1383076268-8984-5-git-send-email-s.nawrocki@samsung.com>
In-Reply-To: <1383076268-8984-5-git-send-email-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 29, 2013 at 08:51:07PM +0100, Sylwester Nawrocki wrote:
> This patch adds common __clk_get(), __clk_put() clkdev helpers that
> replace their platform specific counterparts when the common clock
> API is used.
> 
> The owner module pointer field is added to struct clk so a reference
> to the clock supplier module can be taken by the clock consumers.
> 
> The owner module is assigned while the clock is being registered,
> in functions _clk_register() and __clk_register().
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
