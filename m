From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 19 Sep 2012 15:33:56 +0000
Subject: Re: GPIO request failure with PCF pinmux
Message-Id: <20120919153356.GW13568@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <6045802.ynsOILKLIK@avalon>
In-Reply-To: <6045802.ynsOILKLIK@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 19, 2012 at 05:19:44PM +0200, Laurent Pinchart wrote:
> On Tuesday 18 September 2012 16:12:08 Paul Mundt wrote:
> > That's a bug, the pin has been reconfigured to a different mux type which
> > we should handle. At first glance, simply handling the input/output types
> > ought to work ok, but we may need more work than that. How does it go
> > with this?
> 
> That seems to work, thank you. Will you push a patch ?
> 
Yes, I'll send it off with the next batch of fixes. Thanks for testing!
