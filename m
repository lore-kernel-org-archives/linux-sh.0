From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Sep 2008 11:44:02 +0000
Subject: Re: [PATCH 00/05] sh: GPIO for SuperH using gpiolib
Message-Id: <20080929114402.GA24836@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080927181008.11246.53495.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080927181008.11246.53495.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Sep 28, 2008 at 03:10:08AM +0900, Magnus Damm wrote:
> Pinmuxed GPIO support for SuperH using gpiolib
> 
> [PATCH 01/05] sh: Add GPIO and pinmux base code
> [PATCH 02/05] sh: Add sh7722 pinmux tables 
> [PATCH 03/05] sh: Use sh7722 GPIO on Migo-R board
> [PATCH 04/05] sh: Add sh7723 pinmux tables
> [PATCH 05/05] sh: Use sh7723 GPIO on AP325RXA board
> 
> These patches add support for GPIO to SuperH. The regular GPIO operations
> are all supported for configuring and reading/writing pin data.  IRQs are
> not supported at this point.
> 
Ok, with a bit of tidying, I've checked this in to the sh/gpiolib topic
branch. I note that this depends on David's request/free hooks, so I'm
not able to merge it until there is a resolution there.
