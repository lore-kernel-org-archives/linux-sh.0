From: Simon Horman <horms@verge.net.au>
Date: Tue, 02 Apr 2013 04:33:37 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790 SoC 64-bit DT support
Message-Id: <20130402043337.GD1696@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130329074917.15695.92956.sendpatchset@w520>
In-Reply-To: <20130329074917.15695.92956.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Mar 29, 2013 at 04:49:17PM +0900, Magnus Damm wrote:
> From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> 
> The r8a7790 SoC supports LPAE and has memory window up to
> 0x2ffffffff. Convert to 64-bit addresses by enlarging
> #addr-cells and #size-cells to 2.
> 
> Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, queued up for v3.10 in the soc branch.
