From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Jan 2013 02:07:12 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: armadillo800eva: Reference DT implementation
Message-Id: <20130109020712.GC6496@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1355851359-8871-1-git-send-email-hechtb+renesas@gmail.com>
 <1355851359-8871-3-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1355851359-8871-3-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Dec 18, 2012 at 06:22:39PM +0100, Bastian Hecht wrote:
> Provide alternate board code for the Armadillo 800 EVA to
> demonstrate how DT may be used given the current state of
> driver device tree support. This is intended to act as a
> reference for mach-shmobile developers.
> 
> This is based on Simon Horman's reference implementation for
> the board kzm9g.
> 
> Currently only the ethernet controller is brought up.

Thanks, looks good. I will apply this.

Could you let me know what the status of
the DT bindings for sh-eth is?
