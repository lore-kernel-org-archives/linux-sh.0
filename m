From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 19 Dec 2008 07:52:33 +0000
Subject: Re: A patch got applied to v4l bypassing v4l lists
Message-Id: <20081219075233.GA31320@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0812181613050.5510@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0812181613050.5510@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 19, 2008 at 08:15:19AM +0100, Guennadi Liakhovetski wrote:
> On Thu, 18 Dec 2008, Mauro Carvalho Chehab wrote:
> 
> > On Fri, 19 Dec 2008 00:30:05 +0100 (CET)
> > Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > 
> > > > A side note: maybe the design of pxa_camera could be improved to avoid needing
> > > > to be touched as architecture changes. This is the only v4l driver that includes
> > > > asm/arch header files.
> > > 
> > > The patch in question was for sh_mobile_ceu_camera.c - not for pxa, and 
> > > even though that one doesn't include any asm headers, as you see, it is 
> > > also tied pretty closely with respective platform code.
> > 
> > > As for including asm headers in pxa_camera.c - it wouldn't be easy to get 
> > > rid of them, one of the main obstacles is the use of the pxa-specific 
> > > dma-channel handling API.
> > 
> > Ok. I dunno the specific details of the sh and pxa bindings, but it would be
> > better to have it more independent from architecture specific implementation
> > details.
> 
> ...that's what I'm saying - we have to work with the complete kernel tree. 
> Working with a part of it is no fun. Just think about one thing - changing 
> platform data struct layout. It will still compile as long as you preserve 
> the name, because that's just a void * you get from platform, but you 
> better don't try to run that... Or take this clock change now to the 
> sh_mobile_ceu_camera.c. It will still compile with older kernels, but it 
> won't run.
> 
Correct, this is one of the key issues with not breaking bisection. It is
not just a matter of whether something compiles or not, but whether we
can actually boot and test the result. Things that have a fixed
dependency on each other need to happen in the same change, and can not
be split. That means that either the v4l tree needs to track changes to
architecture files as well, or it will have to resync and pull down
changes made upstream periodically. The latter is how every other tree in
existence is run, largely because of these sorts of reasons. It seems
like most of the trouble comes from running a partial tree, but since the
days of the driver model, it is no longer possible to keep dependent
changes confined and isolated to that directory structure.
