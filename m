From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 31 May 2011 04:35:36 +0000
Subject: Re: [PATCH] sh: asm/tlb.h needs linux/swap.h
Message-Id: <20110531043536.GC1745@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1306723858-745-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1306723858-745-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 30, 2011 at 11:50:58AM +0900, Nobuhiro Iwamatsu wrote:
> By commit 1e56a56410bb64bce62d44563e35a143fc2d515f, mmu_gather of sh
> was reworked. But this forgot include linux/swap.h in asm/tlb.h.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> CC: Peter Zijlstra <a.p.zijlstra@chello.nl>

Applied, thanks.
