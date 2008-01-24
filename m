From: David Brownell <david-b@pacbell.net>
Date: Thu, 24 Jan 2008 22:19:46 +0000
Subject: Re: [PATCH][2/2] usb: ohci-sm501 driver V2
Message-Id: <200801241419.46679.david-b@pacbell.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080123065846.488.67995.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080123065846.488.67995.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday 24 January 2008, Greg KH wrote:
> On Thu, Jan 24, 2008 at 01:34:53PM -0800, David Brownell wrote:
> > On Tuesday 22 January 2008, Magnus Damm wrote:
> > > +??????? * regular memory. The HCD_BOUNCE flag does just that.
> > 
> > ACK other than this comment... flag has been renamed.
> 
> Renamed to what?  I can easily edit the diff...

HCD_LOCAL_MEM, as I recall (the patch 1/2 in this group).
