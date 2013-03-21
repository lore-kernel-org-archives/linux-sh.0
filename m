From: Simon Horman <horms@verge.net.au>
Date: Thu, 21 Mar 2013 10:38:35 +0000
Subject: Re: [PATCH/RFC 2/2] ARM: shmobile: kzm9g: add fixed voltage regulators for SDHI0 and SDHI2
Message-Id: <20130321103835.GG2348@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1303181926060.4980@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1303181926060.4980@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 18, 2013 at 07:26:44PM +0100, Guennadi Liakhovetski wrote:
> Both SDHI0 and SDHI2 power supplies on kzm9g can be switched on and off. In
> the current version this is not used and the regulators are hard-wired to
> "on." This patch switches SDHI0 and SDHI2 to proper fixed-voltage
> regulators, using GPIOs to enable and disable them. Both ports shall
> now be specifying the MMC_CAP_POWER_OFF_CARD MMC capability. Only SDHI0
> has been tested with an SDIO card, since SDHI2 is a microSD slot.

(mentioned elsewhere, but for the record) Thanks, applied to the boards branch.
