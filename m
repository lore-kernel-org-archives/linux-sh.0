From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Oct 2013 03:40:57 +0000
Subject: Re: [PATCH v2 3/3] ARM: shmobile: kzm9d: Use common clock framework
Message-Id: <20131009034057.GO15065@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131008143040.52f36df8edb7ab63224d8433@ops.dti.ne.jp>
 <20131008143403.c11f294c8a1701a2ab3bc5fd@ops.dti.ne.jp>
In-Reply-To: <20131008143403.c11f294c8a1701a2ab3bc5fd@ops.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 08, 2013 at 02:34:03PM +0900, takasi-y@ops.dti.ne.jp wrote:
> Use common clock framework version of clock
>  drivers/clk/shmobile/clk-emev2.c
> instead of sh-clkfwk version
>  arch/arm/mach-shmobile/clock-emev2.c
> when it is configured as a part of multi-platform.
> 
> Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

Thanks.

I plan to add this patch to a new topic branch,
topic/emev2-common-clock, in the renesas tree and
queue it up from there for inclusion in mainline
if/when the first patch of this series is accepted
by Mike Turquette.
