From: Simon Horman <horms@verge.net.au>
Date: Tue, 28 Apr 2015 00:48:28 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7740 dtsi: Fix SCIFB naming
Message-Id: <20150428004827.GA557@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430142924-15777-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430142924-15777-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Apr 27, 2015 at 03:55:23PM +0200, Geert Uytterhoeven wrote:
> The single SCIFB on R-Mobile A1 is called "scifb", not "scifb8".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Cfr. commit 0b3a0ef613538cae ("ARM: shmobile: r8a73a4: fix scifb* naming")

Thanks, both patches queued up for v4.2.
