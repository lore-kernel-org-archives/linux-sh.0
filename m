From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Sep 2010 21:45:27 +0000
Subject: Re: [bug-patch] Re: [BUG?] rename patch accepted with --dry-run,
Message-Id: <20100904214527.GA20444@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <20100903193309.GC29821@pengutronix.de> <20100904000348.GA7498@n2100.arm.linux.org.uk> <201009042333.51419.agruen@suse.de>
In-Reply-To: <201009042333.51419.agruen@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Gruenbacher <agruen@suse.de>
Cc: bug-patch@gnu.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org

On Sat, Sep 04, 2010 at 11:33:51PM +0200, Andreas Gruenbacher wrote:
> On Saturday 04 September 2010 02:03:48 Russell King - ARM Linux wrote:
> > As I say, it's because GNU patch doesn't (currently) understand GIT
> > patches.  I wouldn't call that a bug in GNU patch.
> 
> GNU patch in the version used does understand GIT patch headers and does 
> support things like renames.
> 
> The --dry-run option often will not work when the same file is modified more 
> than once in the same patch, though.  This is because GNU patch doesn't 
> remember the intermediary states of files.
> 
> In this case, the patch itself is broken.

GIT has many options to control how it produces patches, and -C or -M
allow it to reduce the size of patches making them more reviewable.  It
also makes them incompatible with GNU patch, whether or not GNU patch
understands the GIT headers.

As I've already said - if you want GNU compatible patches, don't generate
GIT patches using -C or -M.

Simples.
