From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 30 Dec 2007 03:06:16 +0000
Subject: Re: [DREAMCAST] : Buildfailure
Message-Id: <20071230030616.GA14821@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20071229004013.9a05bbd6.Kristoffer.Ericson@Gmail.com>
In-Reply-To: <20071229004013.9a05bbd6.Kristoffer.Ericson@Gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Your mailer has completely mangled the To/From/Cc lines, in violation of
more than one RFC. Please seek out a more competent mailer for future
postings.

On Sat, Dec 29, 2007 at 04:32:40PM +0000, michiegan@eircom.net wrote:
> > > See if this fixes things for you, seems to do the trick with my gcc-3.x
> > > and gcc-4.x compilers.
> > 
> > Builds nicely now, thanks.
> > 
> Sorry to jump in on this thread but I'm trying to figure out what
> versions are needed for a dreamcast toolchain. ATM I've got this on
> working ( http://www.linuxdevices.com/articles/AT6973012857.html ) but
> it's rather old, including a 2.4.x kernel.
> 
> Recently I got a buildroot config that used gcc-3.4.1 but the current
> kernel. Does the dreamcast build with gcc-4.x at all? The few times
> I've tried it I've gotten missing pthreads.h errors that I haven't dug
> too deep into.
> 
> Further investgations into the likes of KOS seems to indicate that
> gcc-3.4.x is the latest version that will build dreamcast apps. I'm
> just trying to get a handle on what does and doesn't work. Considering
> the recent discussion from the kernel maintainers on dropping gcc-3.x
> all together in future kernels, I'd just like to know if/how to use
> gcc-4.x for dreamcast.
> 
There's nothing 'special' about the dreamcast. It's a legacy board under
the SH kernel, with no special casing. It doesn't require a special
toolchain or anything else, either. It's worked with gcc 4.x as long as
the SH kernel has supported gcc 4.x. Whatever KOS is smoking is
irrelevant.

There are multitudes of gcc 4.x toolchains available, both in binary and
source. See the Linux/SH wiki for more details: http://www.linux-sh.org.

If you find a build problem in buildroot, it's a bug, so you should log a
bugzilla entry for it. If people don't report bugs, it's difficult to
know what we need to look at.
