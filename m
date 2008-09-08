From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 08 Sep 2008 02:52:14 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <20080908025214.GA13992@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 08, 2008 at 11:30:11AM +0900, Paul Mundt wrote:
> On Mon, Sep 08, 2008 at 11:26:54AM +0900, Magnus Damm wrote:
> > Hi again Luca,
> > 
> > On Fri, Sep 5, 2008 at 11:14 PM, Luca Santini
> > <luca.santini@spesonline.com> wrote:
> > > I finally made eth work with these changes...
> > 
> > Great news!
> > 
> > > Paul please check if my changes to setup-sh7760.c are ok,
> > > many thanks to Magnus and Manuel.
> > 
> > I think you should split your patch into three parts:
> > 1) smc91x specific code
> > 2) sh7760 specific code
> > 3) edos7760 specific code
> > 
> > I'm planning on submitting patch 1) upstream myself, so you don't have
> > to do anything about that. Just excluded that part. As for 2) and 3),
> > you should definitely resend them.
> > 
> > Also, please send them to a new thread. Thank you!
> > 
> No worries, I'll split out 2 and 3 manually, it's not that big of a deal.
> The SH7760 bits look fine to me anyways. Manuel?

Luca, please also send an edosk7760_defconfig so that we are able to tie
this in to the daily builds.
