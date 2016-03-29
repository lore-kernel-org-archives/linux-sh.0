From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Date: Tue, 29 Mar 2016 06:33:46 +0000
Subject: Re: sh7724 regression: commit 8222dbe21e79338de92d5e1956cd1e3994cc9f93
Message-Id: <20160329083346.13b4621a@thinkpad-w530>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWR0RZhGrX4qW+fHwOYxAXffNinUdhrL=SZsMn5BUKoeA@mail.gmail.com>
In-Reply-To: <CAMuHMdWR0RZhGrX4qW+fHwOYxAXffNinUdhrL=SZsMn5BUKoeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> On Wed, Mar 16, 2016 at 08:35:20PM -0400, Rich Felker wrote:
> > On Sun, Mar 13, 2016 at 03:08:42PM -0400, Rich Felker wrote:  
> > > On Fri, Mar 11, 2016 at 12:06:22PM +0100, David Hildenbrand wrote:  
> > > >   
> > > > > > > That fixes it for me:
> > > > > > > 
> > > > > > > Tested-by: Hans Verkuil <hans.verkuil@cisco.com>
> > > > > > > 
> > > > > > > BTW, your patch is garbled and I had to manually make the change (not a big
> > > > > > > deal for a simple change like this).
> > > > > > >     
> > > > > > 
> > > > > > Thanks for testing. I just copy-pasted the patch, so this was somehow
> > > > > > expected :)
> > > > > > 
> > > > > > @maintainers, how to proceed with this? Shall I send that patch again directly
> > > > > > to the linux-sh list?
> > > > > > 
> > > > > > David    
> > > > >   
> > > > 
> > > > How to proceed with this patch? Anyone?  
> > > 
> > > Sorry for not getting you a response sooner. I don't yet have the
> > > hardware to test this fix on (would like to find some), but it looks
> > > reasonable to me and like it doesn't risk introducing other
> > > regressions. Sato-san, do you have any thoughts or objections to the
> > > patch?  
> > 
> > Can you follow up with a well-formed patch that I can apply. No
> > promises since I'm new to kernel maintainership workflow but I'll try
> > to get it in this merge window if I can.  
> 
> I was able to clean it up (looks like terminal copy&paste just botched
> all the spaces) so I'm applying it to my tree, since it seems likely
> that most SH models with MMU are broken without it. Thanks!
> 
> Rich
> 

Hi Rich,

sorry, was on vacation and could respond quickly ;)

Thanks for applying this!

David

