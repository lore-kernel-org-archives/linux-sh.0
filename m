From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 30 Oct 2009 03:37:23 +0000
Subject: Re: [PATCH] sh: Do not apply virt_to_phys() to a physical address
Message-Id: <20091030033723.GA1824@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1256853210-2517-1-git-send-email-matt@console-pimps.org>
In-Reply-To: <1256853210-2517-1-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 29, 2009 at 09:53:30PM +0000, Matt Fleming wrote:
> The variable 'phys' already contains the physical address to flush. It
> is not a virtual address and should not be passed to virt_to_phys().
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Applied, thanks.
