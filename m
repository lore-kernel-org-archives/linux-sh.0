From: Simon Horman <horms@verge.net.au>
Date: Wed, 07 Jan 2015 23:55:50 +0000
Subject: Re: [PATCH 0/6] ARM: shmobile: kzm9g-reference: Add missing i2c devices
Message-Id: <20150107235549.GA18943@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1420573329-12762-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1420573329-12762-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 06, 2015 at 08:42:03PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds i2c devices that are supported by kzm9g-legacy
> but missing on kzm9g-reference (and -multiplatform).
> 
> The first patch ("ARM: shmobile: sh73a0 dtsi: Set control-parent for
> all irqpin nodes") is a prerequisite to avoid causing an interrupt
> storm when accessing the adxl345 accelerometer through
> /dev/input/event1, which requires a power-cycle to recover from.
> 
> Parts of this series and of the individual patches were written by
> Laurent Pinchart.
> 
> Thanks for applying!

Thanks, done.
