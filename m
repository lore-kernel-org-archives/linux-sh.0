From: Simon Horman <horms@verge.net.au>
Date: Fri, 08 Jan 2016 01:50:57 +0000
Subject: Re: [PATCH v2 1/4] PCI: rcar: remove unused pci_sys_data structure in pcie-rcar
Message-Id: <20160108015056.GB9600@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
 <1451998831-27705-2-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1451998831-27705-2-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org

Hi Phil,

On Tue, Jan 05, 2016 at 01:00:28PM +0000, Phil Edworthy wrote:
> Commit b3a72384fe29 ("ARM/PCI: Replace pci_sys_data->align_resource
> with global function pointer") removed the struct pci_sys_data
> dependency from the ARM pcibios functions, so remove it from this
> driver.

I am a little confused by this as I still see two instances of
the following in bios32.c as of the commit above.

	struct pci_sys_data *sys = dev->sysdata;
