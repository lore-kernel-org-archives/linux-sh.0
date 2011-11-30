From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 30 Nov 2011 09:17:03 +0000
Subject: Re: [PATCH] sh: sh2a: Optimise cache flush for writethrough mode.
Message-Id: <20111130091703.GA9264@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1322637713-15227-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1322637713-15227-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 30, 2011 at 07:21:53AM +0000, Phil Edworthy wrote:
> When the operand cache is set to writethough mode, there is no
> need to flush data.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

What about the other routines?

You are presumably stipulating that any access to the OC address array
outside of cacheline invalidation should be omitted for write-through
cache mode, which suggests that quite a lot of the file in question can
simply be nopped out.

At the very least sh2a__flush_wback_region() could deal with the same
treatment. For the invalidation routines you presumably still need the
V-bit clearing, though.

sh2a__flush_invalidate_region() also bears closer inspection.
