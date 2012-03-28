From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 28 Mar 2012 05:38:35 +0000
Subject: Re: [PATCH 6/7] SH: pci-sh7780: enable big-endian operation.
Message-Id: <20120328053835.GR26543@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1331311133-26937-6-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1331311133-26937-6-git-send-email-thomas@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 09, 2012 at 05:38:52PM +0100, Thomas Schwinge wrote:
> If in big-endian mode, switch the PCI bus, too.
> 
> Tested on both litte-endian and big-endian sh7785lcr.
> 
> Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: linux-sh@vger.kernel.org

This one looks good, I'll queue it up as-is.
