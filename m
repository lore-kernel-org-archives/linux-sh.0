From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 30 May 2012 07:15:02 +0000
Subject: Re: [PATCH][RFC] ARM: mach-shmobile: sh73a0: bugfix: SY-DMAC number
Message-Id: <20120530071501.GD11445@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87lika2ob7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lika2ob7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 29, 2012 at 11:08:48PM -0700, Kuninori Morimoto wrote:
> 681e1b3eeb3606e06a7c4984e8058df84296f8bb
> (ARM: mach-shmobile: sh73a0 DMA Engine support for SY-DMAC)
> added SY-DMAC, but the number is 218, not 318
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

With these sorts of changes it is good to note the revision of the data
sheet used in the changelog so we don't run in to ping-ponging issues
where it's not obvious which is newest or most correct.
