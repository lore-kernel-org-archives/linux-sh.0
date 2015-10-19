From: Simon Horman <horms@verge.net.au>
Date: Mon, 19 Oct 2015 00:30:45 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: rcar-gen2 dtsi: Remove bogus imp_clk nodes
Message-Id: <20151019003042.GC20599@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1445004316-17235-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1445004316-17235-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 16, 2015 at 04:05:14PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> In the R-Car Gen2 family, only R-Car H2 and V2H have an IMP core and an
> IMP clock. Hence remove the bogus imp_clk nodes from the R-Car M2-W and
> E2 DTSes.

Thanks, I have queued these up for v4.5.
