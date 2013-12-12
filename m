From: Simon Horman <horms@verge.net.au>
Date: Thu, 12 Dec 2013 11:45:14 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: kzm9g: add zboot support
Message-Id: <20131212114508.GA18308@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1385499200-27772-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1385499200-27772-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 28, 2013 at 08:17:40PM +0100, Ulrich Hecht wrote:
> On Thu, Nov 28, 2013 at 12:24 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > If I want to test this on my own KZM9G board, perhaps you can tell me
> > quickly if I can use USB gadget Mask ROM boot mode somehow?
> 
> Set SW1 for non-secure eMMC boot mode (positions 1, 2, 8 off, the rest
> on) without a valid image in eMMC; this will lead the mask ROM loader
> to fall back to USB.
> 
> > I'd like
> > to use the "r_usb_boot" tool but I wonder if it needed any
> > modifications to work with sh73a0?
> 
> None.

Hi Magnus,

did you get a chance to test this?
