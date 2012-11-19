From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 19 Nov 2012 02:22:52 +0000
Subject: Re: [PATCH 2.6.34-rc2] sh: Fix FDPIC binary loader
Message-Id: <20121119022251.GB5978@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4BAC849A.9090403@codesourcery.com>
In-Reply-To: <4BAC849A.9090403@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 16, 2012 at 11:07:43AM +0100, Thomas Schwinge wrote:
> On Mon, 29 Mar 2010 12:15:23 +0900, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Fri, Mar 26, 2010 at 09:55:38AM +0000, Andrew Stubbs wrote:
> > > Ensure that the aux table is properly initialized, even when optional 
> > > features are missing. Without this, the FDPIC loader did not work.
> 
> Andrew's patch became commit d5ab780305bb6d60a7b5a74f18cf84eb6ad153b1.
> 
> > This was whitespace damaged and didn't apply, so I did it by hand.
> 
> Unfortunately, in Paul's manual application, one part of the patch was
> lost, and that happened to be the functional part.  I'm attaching a patch
> to address that.  The patch is for 3.5.2, but likewise applies to the
> current master branch.
> 
Good catch, thanks. I'll queue it up and make sure it finds its way back
in to -stable, too.
