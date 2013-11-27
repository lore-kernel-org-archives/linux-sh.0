From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 27 Nov 2013 16:24:43 +0000
Subject: Re: [PATCH 1/3] DMA: shdma: Fix warnings due to improper casts and printk formats
Message-Id: <5898520.HHVVHa5ZWj@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart6188058.6cMNqg0QLX"
List-Id: <linux-sh.vger.kernel.org>
References: <1385512192-10303-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385512192-10303-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart6188058.6cMNqg0QLX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Andriy,

On Wednesday 27 November 2013 17:03:25 Laurent Pinchart wrote:
> Hi Andy,

Sorry for the misspelling.

> On Wednesday 27 November 2013 12:27:41 Shevchenko, Andriy wrote:
> > On Wed, 2013-11-27 at 01:29 +0100, Laurent Pinchart wrote:
> > > Use the %zu printk specifier to print size_t variables, and cast
> > > pointers to unsigned long instead of unsigned int where applicable. This
> > > fixes warnings on platforms where pointers and/or dma_addr_t have a
> > > different size than int.
> > 
> > Few comments below.
> > 
> > > diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
> > > index 2e7b394..b37d584 100644
> > > --- a/drivers/dma/sh/shdma-base.c
> > > +++ b/drivers/dma/sh/shdma-base.c
> > > @@ -227,7 +227,7 @@ bool shdma_chan_filter(struct dma_chan *chan, void
> > > *arg)
> > > 
> > >  	struct shdma_chan *schan = to_shdma_chan(chan);
> > >  	struct shdma_dev *sdev = to_shdma_dev(schan->dma_chan.device);
> > >  	const struct shdma_ops *ops = sdev->ops;
> > > 
> > > -	int match = (int)arg;
> > > +	int match = (long)arg;
> > 
> > As far as I understand this will lose data on 64bit platforms.
> > Are you aware of it? Otherwise I don't see the advantage of such
> > conversion. As far as I understand you may cast void * easily to long
> > and back, otherwise you lost data.
> 
> That's correct, but shouldn't be an issue here. The match value is a small
> integer. The reason why I cast it to long is to avoid compilation warnings
> 
> > >  	int ret;
> > >  	
> > >  	if (match < 0)
> > > 
> > > @@ -491,9 +491,9 @@ static struct shdma_desc *shdma_add_desc(struct
> > > shdma_chan *schan,
> > > 
> > >  	}
> > >  	
> > >  	dev_dbg(schan->dev,
> > > 
> > > -		"chaining (%u/%u)@%x -> %x with %p, cookie %d\n",
> > > -		copy_size, *len, *src, *dst, &new->async_tx,
> > > -		new->async_tx.cookie);
> > > +		"chaining (%zu/%zu)@%lx -> %lx with %p, cookie %d\n",
> > > +		copy_size, *len, (unsigned long)*src, (unsigned long)*dst,
> > > +		&new->async_tx, new->async_tx.cookie);
> > 
> > Instead of dancing with casting (actually for dma_addr_t it should be
> > ULL type), we can extend %pa to do this job for us:
>
> That sounds good to me. Do you plan to submit a patch ? I'd like to get this
> series upstream in v3.14.

Please use the attached patch if it can help speeding things up, and replace 
the author and SoB line with your name and address.

-- 
Regards,

Laurent Pinchart

--nextPart6188058.6cMNqg0QLX
Content-Disposition: attachment; filename="0001-lib-vsprintf.c-add-paD-format-specifier-for-dma_addr.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-lib-vsprintf.c-add-paD-format-specifier-for-dma_addr.patch"

From df335f75387fcb57bc81259ff6893f4458d47747 Mon Sep 17 00:00:00 2001
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 17:19:04 +0100
Subject: [PATCH] lib/vsprintf.c: add %paD format specifier for dma_addr_t
 types

Add the %paD format specifier for printing a dma_addr_t type, since the
DMA address size on some platforms can vary based on build options,
regardless of the native integer type.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 Documentation/printk-formats.txt |  7 +++++++
 lib/vsprintf.c                   | 14 +++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/printk-formats.txt b/Documentation/printk-formats.txt
index 445ad74..3344ca9 100644
--- a/Documentation/printk-formats.txt
+++ b/Documentation/printk-formats.txt
@@ -63,6 +63,13 @@ Physical addresses:
 	resource_size_t) which can vary based on build options, regardless of
 	the width of the CPU data path. Passed by reference.
 
+DMA addresses:
+
+	%paD	0x01234567 or 0x0123456789abcdef
+
+	For printing a dma_addr_t type which can vary based on build options,
+	regardless of the width of the CPU data path. Passed by reference.
+
 Raw buffer as a hex string:
 	%*ph	00 01 02  ...  3f
 	%*phC	00:01:02: ... :3f
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 10909c5..2e3f7ea 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1219,6 +1219,7 @@ int kptr_restrict __read_mostly;
  *            The maximum supported length is 64 bytes of the input. Consider
  *            to use print_hex_dump() for the larger input.
  * - 'a' For a phys_addr_t type and its derivative types (passed by reference)
+ * - 'aD' For a dma_addr_t type (passed by reference)
  * - 'd[234]' For a dentry name (optionally 2-4 last components)
  * - 'D[234]' Same as 'd' but for a struct file
  *
@@ -1354,10 +1355,17 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		break;
 	case 'a':
 		spec.flags |= SPECIAL | SMALL | ZEROPAD;
-		spec.field_width = sizeof(phys_addr_t) * 2 + 2;
 		spec.base = 16;
-		return number(buf, end,
-			      (unsigned long long) *((phys_addr_t *)ptr), spec);
+		switch (fmt[1]) {
+		case 'D':
+			spec.field_width = sizeof(dma_addr_t) * 2 + 2;
+			return number(buf, end,
+				(unsigned long long)*((dma_addr_t *)ptr), spec);
+		default:
+			spec.field_width = sizeof(phys_addr_t) * 2 + 2;
+			return number(buf, end,
+				(unsigned long long)*((phys_addr_t *)ptr), spec);
+		}
 	case 'd':
 		return dentry_name(buf, end, ptr, spec, fmt);
 	case 'D':
-- 
1.8.3.2


--nextPart6188058.6cMNqg0QLX--

