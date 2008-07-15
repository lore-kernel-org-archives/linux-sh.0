From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 15 Jul 2008 09:08:26 +0000
Subject: Re: [Fwd: Gentoo install]
Message-Id: <20080715090826.GD23440@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1216070824.6459.6.camel@localhost.localdomain>
In-Reply-To: <1216070824.6459.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 14, 2008 at 10:27:04PM +0100, Adrian McMenamin wrote:
> apologies sent this to the SF list by mistake. I know this isn't a
> kernel issue but i suspect the real knowledge of how to do this is
> here...
> 
> Is there a guide anywhere to how I can install gentoo on my Dreamcast?
> 
> I have got a stage 3 tarball and installed the latest portage snapshot,
> but it seems like madness to me to try to compile packages natively and
> I have read fragmentary emails suggesting that I can get some sort of
> x-compile system up and running.
> 
> But I cannot find anything coherent that explains how to do it? Any
> clues/experience?
> 
What you are probably going to end up having to do is stick with binary
distributions of the packages anyways. While you can toss everything over
the fence to a cross-compiler on a slightly less neutered host, you are
still going to run in to a world of pain on the target side with things
like updating the portage cache.
