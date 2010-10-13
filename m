From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Oct 2010 10:25:48 +0000
Subject: Re: [PATCH] sh: free-without-alloc fix for sh_mobile_lcdcfb
Message-Id: <20101013102548.GE10013@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101013071745.19716.66656.sendpatchset@t400s>
In-Reply-To: <20101013071745.19716.66656.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 13, 2010 at 04:17:45PM +0900, Magnus Damm wrote:
> Without this fix the LCDC driver will try to free
> framebuffer memory even though the allocation failed.

Applied, thanks.
