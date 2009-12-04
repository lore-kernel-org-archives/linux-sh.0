From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Dec 2009 07:27:16 +0000
Subject: Re: [PATCH] sh: include empty zero page in romImage
Message-Id: <20091204072716.GB13603@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091204064235.7674.79539.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091204064235.7674.79539.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 04, 2009 at 04:24:56PM +0900, Magnus Damm wrote:
> On Fri, Dec 4, 2009 at 3:42 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > From: Magnus Damm <damm@opensource.se>
> >
> > This patch updates the romImage code to include the
> > empty_zero_page contents from vmlinux. Without this
> > patch the empty zero page is lef uninitialized.
> >
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > ---
> >
> > ?Compiles and looks fine through objdump, but not
> > ?runtime tested due to lack of hardware debugger.
> 
> Update, runtime tested this using uboot bootp + go on a migor board
> and it seems ok!
> 
Ok, applied.
