From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 14 Dec 2009 06:20:13 +0000
Subject: Re: [PATCH] sh: Couple kernel and user write page perm bits for CONFIG_X2TLB
Message-Id: <20091214062013.GA25420@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1260703081-1945-1-git-send-email-matt@console-pimps.org>
In-Reply-To: <1260703081-1945-1-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Dec 13, 2009 at 11:18:01AM +0000, Matt Fleming wrote:
> pte_write() should check whether the permissions include either the user
> or kernel write permission bits. Likewise, pte_wrprotect() needs to
> remove both the kernel and user write bits.
> 
> Without this patch handle_tlbmiss() doesn't handle faulting in pages
> from the P3 area (our vmalloc space) because of a write. Mappings of the
> P3 space have the _PAGE_EXT_KERN_WRITE bit but not _PAGE_EXT_USER_WRITE.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Applied, thanks.
