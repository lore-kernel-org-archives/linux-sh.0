From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Jan 2016 01:45:28 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: timer: Drop support for Cortex A8
Message-Id: <20160118014528.GE1905@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1452537674-20006-1-git-send-email-geert+renesas@glider.be>
 <1452537674-20006-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1452537674-20006-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jan 11, 2016 at 07:41:13PM +0100, Geert Uytterhoeven wrote:
> Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy
> file") removed the DTS for the last shmobile SoC with a Cortex A8 CPU
> core (sh7372 aka SH-Mobile AP4).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up for v4.6.
