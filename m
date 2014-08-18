From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Aug 2014 23:47:25 +0000
Subject: Re: [PATCH 0/8] Initial r8a7794/Alt support
Message-Id: <20140818234725.GA32173@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1408377107-3822-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1408377107-3822-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 18, 2014 at 05:51:39PM +0200, Ulrich Hecht wrote:
> Hi!
> 
> This is a minimal-plus-bureaucracy set to get the Alt board running on one
> cylinder, derived from the Renesas BSP.  I have left the serial port at 38k4
> because I seem to be unable to switch u-boot to anything else; "setenv
> baudrate ..." does not work as advertised.
> 
> Should the board actually be called "reference", there not being any legacy
> board support?

It seems to me that we should try and add Alt support without any board
file whatsoever. That is, drop patch "[PATCH 3/8] ARM: shmobile: Initial
r8a7794 Alt board support" of this series and have the board boot using the
DT_MACHINE_START stanza that is added to setup-r8a7794.c by "[PATCH 2/8]
ARM: shmobile: Initial r8a7794 SoC support".

I have made some slightly more detailed responses to those and other
patches in the series.
