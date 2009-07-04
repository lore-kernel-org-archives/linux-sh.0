From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 04 Jul 2009 15:37:39 +0000
Subject: Re: [PATCH] usb: m66592-udc buffer management update
Message-Id: <20090704153738.GB9933@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 03, 2009 at 10:07:23AM -0700, Greg KH wrote:
> On Fri, Jul 03, 2009 at 05:37:47PM +0900, Paul Mundt wrote:
> > On Fri, Jul 03, 2009 at 05:34:41PM +0900, Yoshihiro Shimoda wrote:
> > > Yoshihiro Shimoda wrote:
> > > > Magnus Damm wrote:
> > > >> From: Magnus Damm <damm@igel.co.jp>
> > > >>
> > > >> This patch updates the m66592-udc buffer management code.
> > > >>
> > > >> Use fixed buffers for bulk and isochronous pipes, also make
> > > >> sure to handle the isochronous-as-bulk case. With fixed buffers
> > > >> there is no need to keep track of used buffers with bi_bufnum.
> > > >>
> > > >> Also, this fixes a potential buffer offset problem where the
> > > >> base offset incorrectly varies with the number of pipes used.
> > > >>
> > > >> With this patch applied it is possible to use m66592-udc for
> > > >> both Ethernet and Serial using CONFIG_USB_CDC_COMPOSITE.
> > > >>
> > > >> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > > > 
> > > > Thank you for your patch.
> > > > I also thought that this management method was good.
> > > > In addition, thank you for finding a potential problem.
> > > > I tested this patch and confirmed it is working.
> > > 
> > > I'm sorry. I forgot to write the Acked-by:
> > > 
> > > Acked-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> > > 
> > Greg, any preferences? I was planning on just rolling this in to my
> > 2.6.32 queue unless you have any objections.
> 
> No objection from me, please do so.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
Done, thanks.
