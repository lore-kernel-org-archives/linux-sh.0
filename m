From: David Sterba <dsterba@suse.cz>
Date: Thu, 18 Jan 2018 16:56:12 +0000
Subject: Re: [PATCH v6 00/99] XArray version 6
Message-Id: <20180118165612.GS13726@twin.jikos.cz>
List-Id: <linux-sh.vger.kernel.org>
References: <20180117202203.19756-1-willy@infradead.org>
 <20180118160749.GP13726@twin.jikos.cz>
 <20180118164843.GA23800@bombadil.infradead.org>
In-Reply-To: <20180118164843.GA23800@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-s390@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-nilfs@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org, linux-remoteproc@vger.kernel.org, dsterba@suse.cz, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Stefano Stabellini <sstabellini@kernel.org>, linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-btrfs@vger.kernel.org

On Thu, Jan 18, 2018 at 08:48:43AM -0800, Matthew Wilcox wrote:
> Thank you!  I shall attempt to debug.  Was this with a btrfs root
> filesystem?  I'm most suspicious of those patches right now, since they've
> received next to no testing.  I'm going to put together a smaller patchset
> which just does the page cache conversion and nothing else in the hope
> that we can get that merged this year.

No, the root is ext3 and there was no btrfs filesytem mounted at the
time.
