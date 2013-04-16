From: Simon Horman <horms@verge.net.au>
Date: Tue, 16 Apr 2013 02:35:22 +0000
Subject: Re: [PATCH] arm: shmobile: armadillo800eva: Fix maximum number of SCIF
Message-Id: <20130416023522.GA28660@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1366001092-8753-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1366001092-8753-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Apr 15, 2013 at 01:44:52PM +0900, Nobuhiro Iwamatsu wrote:
> The r8a77740 has 9ch SCIF. It is not 8ch.

Thanks, queued up for v3.11 in the defconfig-armadillo800eva branch.
I plan to push that branch later today.
