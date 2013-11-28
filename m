From: Simon Horman <horms@verge.net.au>
Date: Thu, 28 Nov 2013 08:11:00 +0000
Subject: Re: [PATCH v2] ARM: shmobile: Fix r8a7791 GPIO resources in DTS
Message-Id: <20131128081058.GS24146@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131121052200.16972.40390.sendpatchset@w520>
In-Reply-To: <20131121052200.16972.40390.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 21, 2013 at 02:22:00PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The r8a7791 GPIO resources are currently incorrect. Fix that
> by making them match the English r8a7791 v0.31 data sheet.
> 
> Tested with GPIO LED using Koelsch DT reference.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up.
