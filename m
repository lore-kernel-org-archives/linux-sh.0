From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Jan 2014 06:07:36 +0000
Subject: Re: [PATCH 3/3 V2] ARM: shmobile: koelsch: Add I2C support
Message-Id: <20140106060733.GG24653@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1388143659-8739-4-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1388143659-8739-4-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 06, 2014 at 02:35:23PM +0900, Simon Horman wrote:
> On Fri, Dec 27, 2013 at 03:27:39PM +0400, Valentine Barshak wrote:
> > This adds I2C[1245] busses support to Koelsch board.
> > I2C[03] do not have any slave devices connected and
> > are not used because of the following:
> > * I2C0 pins are multiplexed with LBSC pins;
> > * I2C3 pins are multiplexed with EtherMAC and VIN0 pins.
> > 
> > Changes in V2:
> > * Capitalized ARM in the subject.
> > 
> > Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> 
> Thanks, I will queue this up.

Please send an update to the koelsch defconfig to enable I2C.
