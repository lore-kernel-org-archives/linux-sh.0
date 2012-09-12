From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 12 Sep 2012 18:15:03 +0000
Subject: Re: [PATCH v2] /dev/mem: use phys_addr_t for physical addresses
Message-Id: <20120912181503.GB12840@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1347473158-7219-1-git-send-email-cyril@ti.com>
In-Reply-To: <1347473158-7219-1-git-send-email-cyril@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Sep 12, 2012 at 02:05:58PM -0400, Cyril Chemparathy wrote:
> This patch fixes the /dev/mem driver to use phys_addr_t for physical
> addresses.  This is required on PAE systems, especially those that run
> entirely out of >4G physical memory space.

What is the symptom if this patch is not applied?  Does it need to be
backported to older kernels?  If so, which ones?

thanks,

greg k-h
