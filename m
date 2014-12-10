From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Dec 2014 00:30:52 +0000
Subject: Re: [PATCH 1/7] ARM: shmobile: genmai dts: Replace status value "ok" by "okay"
Message-Id: <20141210003051.GG9690@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Dec 09, 2014 at 12:24:59PM +0100, Geert Uytterhoeven wrote:
> While the DT parsing code recognizes "ok" as a valid value for the
> "status" property, ePAPR v1.1 doesn't mention it in the list of valid
> values.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued up this and the other 6 patches.
