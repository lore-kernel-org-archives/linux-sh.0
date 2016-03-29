From: Rich Felker <dalias@libc.org>
Date: Tue, 29 Mar 2016 20:07:19 +0000
Subject: Re: [PATCH] sh: fix smp-shx3 build regression from removal of arch localtimer
Message-Id: <20160329200719.GP21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20160327170313.GZ21636@brightrain.aerifal.cx>
In-Reply-To: <20160327170313.GZ21636@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 29, 2016 at 01:18:57PM -0500, Rob Landley wrote:
> On 03/27/2016 12:03 PM, Rich Felker wrote:
> > The removal was not complete and left behind one reference to a
> > removed function in smp-shx3.c. For completeness, also remove
> > declarations for functions that were removed.
> > 
> > Fixes: 45624ac38926 "sh: remove arch-specific localtimer and use generic one"
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Rich Felker <dalias@libc.org>
> 
> This is a bugfix during the rc1->rc2 window, as a maintainer you should
> probably cc: Linus on this. (With a reference to the bug report email,
> either by making it a reply to that message or by adding a URL to a web
> archive, in this case
> http://lkml.iu.edu/hypermail/linux/kernel/1603.3/01275.html.)
> 
> You tested the fix, if it needs another fix it's early enough to add
> another patch on top of it. For right now the priority's unbreaking
> people's builds.

Yes, if there are no comments indicating that it needs changes, I'll
send another pull request to Linus and link to the report of the build
regression. This is the whole point of having rc's, right? :)

Rich
