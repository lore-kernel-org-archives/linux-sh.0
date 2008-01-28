From: Greg KH <greg@kroah.com>
Date: Mon, 28 Jan 2008 21:31:00 +0000
Subject: Re: [PATCH][2/2] usb: ohci-sm501 driver V2
Message-Id: <20080128213059.GA6777@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080123065846.488.67995.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080123065846.488.67995.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 25, 2008 at 12:16:16PM +0900, Magnus Damm wrote:
> On Jan 25, 2008 7:19 AM, David Brownell <david-b@pacbell.net> wrote:
> >
> > On Thursday 24 January 2008, Greg KH wrote:
> > > On Thu, Jan 24, 2008 at 01:34:53PM -0800, David Brownell wrote:
> > > > On Tuesday 22 January 2008, Magnus Damm wrote:
> > > > > +??????? * regular memory. The HCD_BOUNCE flag does just that.
> > > >
> > > > ACK other than this comment... flag has been renamed.
> > >
> > > Renamed to what?  I can easily edit the diff...
> >
> > HCD_LOCAL_MEM, as I recall (the patch 1/2 in this group).
> 
> Yes, correct. Sorry about that.
> 
> Greg, please edit the diff if possible.

Now edited.

thanks,

greg k-h
