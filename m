From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Jul 2014 15:44:43 +0000
Subject: Re: mach-shmobile: FIXME message in file pm-sh732.c
Message-Id: <20140711154443.GD1777@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <CAPDOMViqzoX_VAJKFB34LXLBVUBTbs4hWq-K_8+bC-m2NmahCQ@mail.gmail.com>
 <20140711093450.GA26660@verge.net.au>
 <CAPDOMVgi-GMQp101eZewVBOK_nFD8UJ04UydQ6bxa6Y5FP_VgQ@mail.gmail.com>
In-Reply-To: <CAPDOMVgi-GMQp101eZewVBOK_nFD8UJ04UydQ6bxa6Y5FP_VgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jul 11, 2014 at 11:24:12AM -0400, Nick Krause wrote:
> On Fri, Jul 11, 2014 at 5:34 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Jul 04, 2014 at 12:34:58AM -0400, Nick Krause wrote:
> >> While searching for FIX ME messages when using cscope on the latest kernels I
> >> get a message on 68 of this file and was wondering what I need to define SMFRAM
> >> as in order for it to point to things needed to support this portion
> >> of the  hardware.
> >
> > Hi Nick,
> >
> > while I don't have a technical answer to your question I do believe
> > that the code in question will be removed in the not too distant future
> > along with support for the sh7372 SoC.
> 
> Why are we removing support for this SoC? Is there any reason?

Because it is rather old hardware which is most likely not used against
mainline by anyone other than those maintaining the code and moving it over
to use multiplatform, CCF, and the like appears to be more work thank it is
worth.
