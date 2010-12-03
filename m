From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 03 Dec 2010 04:45:14 +0000
Subject: Re: [PATCH 2/2] sh: se/7724: Update clock of FSI to non-legacy
Message-Id: <20101203044514.GC32384@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1291349817-3077-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1291349817-3077-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 03, 2010 at 01:42:30PM +0900, Nobuhiro Iwamatsu wrote:
> 2010/12/3 Paul Mundt <lethal@linux-sh.org>:
> > On Fri, Dec 03, 2010 at 01:16:57PM +0900, Nobuhiro Iwamatsu wrote:
> >> Current FSI clock of ecovec uses legacy clock.
> >> This update to non-legacy.
> >>
> >> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> >> ---
> >> ?arch/sh/boards/mach-se/7724/setup.c | ? 16 ++++++++++++++--
> >> ?1 files changed, 14 insertions(+), 2 deletions(-)
> >>
> > For ecovec and 7724 clock framework we already have the patch from
> > Morimoto-san queued up, perhaps se7724 needs the same fix?
> >
> > ? ? ? ?http://git.kernel.org/?p=linux/kernel/git/lethal/sh-2.6.git;a=commitdiff;hKd5d259e451d35380de2fcd1a3510ae22d000a3
> 
> Oh, sorry. These are the same revisions.
> Please ignore.
> 
> BTW , do yuo have plan that  morimoto-san patch into linus/master?
> These cannot build now by your commit
> (549015c36baadc6e67861bba6e927259e34c4d59).
> 
They're in my sh-fixes-for-linus branch, so they'll be heading to Linus
for -rc5. I was planning on sending out -rc5 pull requests later this
afternoon.
