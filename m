From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 17 Dec 2010 10:42:13 +0000
Subject: Re: [PATCH] clocksource: sh_cmt: Remove nested spinlock fix
Message-Id: <20101217104212.GF20847@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101217072509.32699.95165.sendpatchset@t400s>
In-Reply-To: <20101217072509.32699.95165.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 17, 2010 at 04:25:09PM +0900, Magnus Damm wrote:
> From: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
> 
> There are control flow that sh_cmt_set_next() does double
> spin-lock. The callers sh_cmt_{start,stop}() already have
> lock. But another callers sh_cmt_clock_event_{start,next}()
> does not.
>     
> Now sh_cmt_set_next() does not lock by itself. All the
> callers should hold spin-lock before calling it.
> 
> [damm@opensource.se: use __sh_cmt_set_next() to simplify code]
> [damm@opensource.se: added stable, suitable for v2.6.35 + v2.6.36]
> Cc: stable@kernel.org
> Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied to sh/urgent, thanks.
