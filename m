From: Simon Horman <horms@verge.net.au>
Date: Tue, 28 Jul 2015 00:10:22 +0000
Subject: Re: [PATCH v2 0/3] bockw SD pull-ups
Message-Id: <20150728001022.GB5973@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1437751317-12235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1437751317-12235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Mon, Jul 27, 2015 at 06:30:39PM +0200, Ulrich Hecht wrote:
> On Mon, Jul 27, 2015 at 3:09 AM, Simon Horman <horms@verge.net.au> wrote:
> > Hi Ulrich,
> >
> > On Fri, Jul 24, 2015 at 05:21:54PM +0200, Ulrich Hecht wrote:
> >> Hi!
> >>
> >> This series implements pull-up configuration in the r8a7778 PFC driver
> >> and sets the SD0_WP and SD0_CD pull-ups on the Bock-W board correctly,
> >> replacing the hack that is used in the legacy platforms.
> >>
> >> This revision uses bitfields for the pull-up table, reducing its size to 310
> >> bytes, and demotes undefined pull-ups from a bug to a warning.
> >
> > I am wondering if these patches create any forwards/backwards compatibility
> > issues if the kernel and DT are not upgraded simultaneously.
> 
> I don't think so.  The driver support without the DT changes will not
> do anything.  DT changes without driver support will yield an error
> message, but other than that it should not have any detrimental
> effect.

Thanks, in that case I'm happy with these changes from
an integration point of view.

I will defer the shmobile patch (3/3) pending acceptance
of the pinctl patches (1/3, 2/3). Please let me know if/when the
pinctl patches have been accepted as I should be able to queue
up the shmobile patch straight away.

