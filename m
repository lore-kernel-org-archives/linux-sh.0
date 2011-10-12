From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Oct 2011 22:42:46 +0000
Subject: Re: [PATCH v2] sh: Take into account the base of System RAM in
Message-Id: <20111012224238.GE16825@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1317603918-30762-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1317603918-30762-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Wed, Oct 12, 2011 at 05:24:23PM +0900, Magnus Damm wrote:
> On Mon, Oct 3, 2011 at 10:05 AM, Simon Horman <horms@verge.net.au> wrote:
> > Previously virt_to_phys() assumed that physical memory always started
> > at address 0. This is not always the case.
> >
> > Tested on an sh7757lcr (32bit system) whose only System RAM region is
> > 40000000-4effffff and an ecovec24 (29bit system).
> >
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> >
> > ---
> >  kexec/arch/sh/kexec-sh.c |   45 ++++++++++++++++++++++++++++++++++++++++++++-
> >  1 files changed, 44 insertions(+), 1 deletions(-)
> >
> > v2
> > * Only use the base of System RAM as an offset into physical memory
> >  if 32bit addressing is in use.
> 
> This version looks much better, thanks!

I thought so too. But after pushing it I realised the parsing logic in
is_32bit() is flawed. I will send an update.
