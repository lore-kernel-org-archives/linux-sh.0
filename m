From: David Sterba <dsterba@suse.cz>
Date: Thu, 18 Jan 2018 14:22:34 +0000
Subject: Re: [PATCH v6 85/99] btrfs: Remove unused spinlock
Message-Id: <20180118142234.GK13726@twin.jikos.cz>
List-Id: <linux-sh.vger.kernel.org>
References: <20180117202203.19756-1-willy@infradead.org>
 <20180117202203.19756-86-willy@infradead.org>
In-Reply-To: <20180117202203.19756-86-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-s390@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-nilfs@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>, linux-sh@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Stefano Stabellini <sstabellini@kernel.org>, linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-btrfs@vger.kernel.org

On Wed, Jan 17, 2018 at 12:21:49PM -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> The reada_lock in struct btrfs_device was only initialised, and not
> actually used.  That's good because there's another lock also called
> reada_lock in the btrfs_fs_info that was quite heavily used.  Remove
> this one.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

I'll pick this one now, thanks.
