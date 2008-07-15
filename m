From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Tue, 15 Jul 2008 10:47:34 +0000
Subject: Re: [Fwd: Gentoo install]
Message-Id: <20080715104734.GB27297@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1216070824.6459.6.camel@localhost.localdomain>
In-Reply-To: <1216070824.6459.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 15, 2008 at 11:42:36AM +0100, Adrian McMenamin wrote:
> On Tue, July 15, 2008 10:08 am, Paul Mundt wrote:
> > On Mon, Jul 14, 2008 at 10:27:04PM +0100, Adrian McMenamin wrote:
> >>
> >> Is there a guide anywhere to how I can install gentoo on my Dreamcast?
> >>
> > What you are probably going to end up having to do is stick with binary
> > distributions of the packages anyways. While you can toss everything over
> > the fence to a cross-compiler on a slightly less neutered host, you are
> > still going to run in to a world of pain on the target side with things
> > like updating the portage cache.
> 
> I am right in thinking, though, aren't I, that there is no automatic way
> of pulling in binary packages?

there's "emerge -K <pkg>" provided you have a repository.

-- 
 Manuel Lauss
