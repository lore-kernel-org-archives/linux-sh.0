From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 11 Jan 2011 03:47:25 +0000
Subject: Re: [PATCH 1/5] sh: pci: Add pci_fixup_pcic to pci of landisk
Message-Id: <20110111034725.GK3760@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1294369335-4064-1-git-send-email-iwamatsu@nigauri.org>
In-Reply-To: <1294369335-4064-1-git-send-email-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 07, 2011 at 12:02:11PM +0900, Nobuhiro Iwamatsu wrote:
> This adds a pci setting revision for landisk.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

I've applied your 1-5/5 series, I'll deal with the ioremap_mode() stuff
separately.
