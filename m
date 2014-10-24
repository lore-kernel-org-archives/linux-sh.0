From: Michal Nazarewicz <mina86@mina86.com>
Date: Fri, 24 Oct 2014 16:26:58 +0000
Subject: Re: [PATCH v2 3/4] mm: cma: Ensure that reservations never cross the low/high mem boundary
Message-Id: <xa1toat13031.fsf@mina86.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414145922-26042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1414145922-26042-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414145922-26042-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 24 2014, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com> wrote:
> Commit 95b0e655f914 ("ARM: mm: don't limit default CMA region only to
> low memory") extended CMA memory reservation to allow usage of high
> memory. It relied on commit f7426b983a6a ("mm: cma: adjust address limit
> to avoid hitting low/high memory boundary") to ensure that the reserved
> block never crossed the low/high memory boundary. While the
> implementation correctly lowered the limit, it failed to consider the
> case where the base..limit range crossed the low/high memory boundary
> with enough space on each side to reserve the requested size on either
> low or high memory.
>
> Rework the base and limit adjustment to fix the problem. The function
> now starts by rejecting the reservation altogether for fixed
> reservations that cross the boundary, tries to reserve from high memory
> first and then falls back to low memory.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>
